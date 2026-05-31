#!/bin/sh
# kommandr installer (macOS / Linux)
#   curl -fsSL https://raw.githubusercontent.com/colbymchenry/kommandr/main/install.sh | sh
#
# Downloads the prebuilt kommandr binary for your platform from the latest GitHub
# release, verifies its sha256, and installs it. No Node, no build step — and the
# binary self-updates after that.
#
# Env overrides:
#   KOMMANDR_VERSION=v0.1.0      pin a specific release (default: latest)
#   KOMMANDR_HOME=~/.kommandr    where the binary + token + cache live
#   KOMMANDR_BIN=~/.local/bin    dir for the `kommandr` symlink on your PATH
#   KOMMANDR_BASE_URL=…          download from a mirror/dir instead of GitHub
#                                (expects <base>/<asset> + <base>/checksums.txt)
set -eu

REPO="colbymchenry/kommandr"
HOME_DIR="${KOMMANDR_HOME:-$HOME/.kommandr}"
BIN_STORE="$HOME_DIR/bin"                      # the real binary (next to the cloudflared cache)
BIN_DIR="${KOMMANDR_BIN:-$HOME/.local/bin}"    # a `kommandr` symlink here, on PATH

say() { printf '\033[36m[kommandr]\033[0m %s\n' "$1"; }
die() { printf '\033[31m[kommandr]\033[0m %s\n' "$1" >&2; exit 1; }

# --- detect platform -------------------------------------------------------
os="$(uname -s)"
case "$os" in
  Darwin) os=darwin ;;
  Linux)  os=linux ;;
  *) die "unsupported OS '$os'. On Windows, use install.ps1 in PowerShell." ;;
esac
arch="$(uname -m)"
case "$arch" in
  x86_64|amd64)  arch=amd64 ;;
  aarch64|arm64) arch=arm64 ;;
  *) die "unsupported architecture '$arch' (need x86_64/amd64 or aarch64/arm64)." ;;
esac
ASSET="kommandr-$os-$arch"

# --- tmux preflight (the session runs inside tmux on unix) -----------------
if ! command -v tmux >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    say "tmux not found — installing via Homebrew…"
    brew install tmux || die "brew install tmux failed; install tmux manually and re-run."
  elif command -v apt-get >/dev/null 2>&1; then die "tmux is required:  sudo apt-get install -y tmux   (then re-run)"
  elif command -v dnf     >/dev/null 2>&1; then die "tmux is required:  sudo dnf install -y tmux       (then re-run)"
  elif command -v pacman  >/dev/null 2>&1; then die "tmux is required:  sudo pacman -S tmux            (then re-run)"
  else die "tmux is required but not found. Install tmux, then re-run."
  fi
fi

# --- pick a downloader -----------------------------------------------------
if   command -v curl >/dev/null 2>&1; then dl() { curl -fsSL -o "$2" "$1"; }
elif command -v wget >/dev/null 2>&1; then dl() { wget -qO "$2" "$1"; }
else die "need curl or wget to download."
fi

VER="${KOMMANDR_VERSION:-latest}"
if   [ -n "${KOMMANDR_BASE_URL:-}" ]; then base="${KOMMANDR_BASE_URL%/}"
elif [ "$VER" = latest ];            then base="https://github.com/$REPO/releases/latest/download"
else                                      base="https://github.com/$REPO/releases/download/$VER"
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

say "downloading $ASSET ($VER)…"
dl "$base/$ASSET" "$tmp/$ASSET" || die "download failed: $base/$ASSET"

# --- verify sha256 against checksums.txt -----------------------------------
if dl "$base/checksums.txt" "$tmp/checksums.txt" 2>/dev/null && [ -s "$tmp/checksums.txt" ]; then
  want="$(awk -v f="$ASSET" '$2==f || $2=="*"f {print $1}' "$tmp/checksums.txt" | head -n1)"
  if   command -v shasum    >/dev/null 2>&1; then got="$(shasum -a 256 "$tmp/$ASSET" | awk '{print $1}')"
  elif command -v sha256sum >/dev/null 2>&1; then got="$(sha256sum    "$tmp/$ASSET" | awk '{print $1}')"
  else got=""; say "no sha256 tool — skipping checksum verification."
  fi
  if [ -n "$want" ] && [ -n "$got" ]; then
    [ "$got" = "$want" ] || die "checksum mismatch for $ASSET — aborting for safety."
    say "checksum verified ✓"
  else
    say "no checksum entry for $ASSET — skipping verification."
  fi
else
  say "checksums.txt unavailable — skipping verification."
fi

# --- install (atomic rename within the store dir) --------------------------
mkdir -p "$BIN_STORE"
cp "$tmp/$ASSET" "$BIN_STORE/.kommandr.new"
chmod +x "$BIN_STORE/.kommandr.new"
mv -f "$BIN_STORE/.kommandr.new" "$BIN_STORE/kommandr"

mkdir -p "$BIN_DIR"
ln -sf "$BIN_STORE/kommandr" "$BIN_DIR/kommandr"

say "installed ✔   ($BIN_DIR/kommandr → $BIN_STORE/kommandr)"
case ":$PATH:" in
  *":$BIN_DIR:"*) say "run:  kommandr" ;;
  *) say "add $BIN_DIR to your PATH, then run 'kommandr':"
     say "  echo 'export PATH=\"$BIN_DIR:\$PATH\"' >> ~/.zshrc && export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac
