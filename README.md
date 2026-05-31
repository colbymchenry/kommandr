# kommandr

Drive your terminal AI coding agents — Claude Code, Gemini CLI, Codex, any of them — from your phone.

Run `kommandr` on your machine, scan the QR it prints, and your terminal session (with the agent running in it) opens on your phone — with an on-screen key bar so you can actually steer an agent on a touch keyboard.

## Install

**macOS / Linux**

```sh
curl -fsSL https://raw.githubusercontent.com/colbymchenry/kommandr/main/install.sh | sh
```

**Windows** (PowerShell)

```powershell
irm https://raw.githubusercontent.com/colbymchenry/kommandr/main/install.ps1 | iex
```

Then run it and scan the QR with your phone camera — no app required:

```sh
kommandr
```

## Why kommandr

Soft keyboards can't send `Esc`, the arrow keys, `Ctrl-C`, or `Tab` — the keys you constantly reach for when driving an agent. kommandr puts a key bar on screen for exactly those, so checking on and steering a long-running agent from your phone actually works.

- One command, one QR — no SSH setup, no account, no port forwarding.
- A real terminal in the browser (xterm.js), live-resizing to your screen.
- Your session persists — lock your phone, come back later, it's still running.
- A single self-contained binary that keeps itself up to date.

## How it works

`kommandr` starts a small server bound to `127.0.0.1`, attaches it to a persistent terminal session (tmux on macOS/Linux, PowerShell via ConPTY on Windows), and opens a free [Cloudflare quick tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/trycloudflare/) so your phone can reach it over TLS. The QR it prints points at that tunnel.

It runs in the foreground — close the terminal or press `Ctrl-C` and the server stops.

## Security

- The server binds to **loopback only**; the tunnel is the only way in.
- Every connection is **token-gated** with a constant-time compare. The token is a 32-byte secret at `~/.kommandr/token` (`0600`) — the tunnel URL is useless without it.
- The QR embeds that token and prints to your **console only**, so there's no web page handing it out.
- The tunnel URL is ephemeral (new every run); the token persists.

## Updating

kommandr checks for a newer release on startup, verifies the download's sha256, swaps itself, and restarts. To update on demand:

```sh
kommandr update
```

Set `KOMMANDR_NO_UPDATE=1` to skip the startup check.

## Commands & options

| command / env | what it does |
|---|---|
| `kommandr` | start the server and print the QR |
| `kommandr update` | update to the latest release now |
| `kommandr version` | print the installed version |
| `PORT=8722` | local server port (default `8722`) |
| `KOMMANDR_NO_UPDATE=1` | skip the startup update check |

## Requirements

- **macOS / Linux:** `tmux` (the installer offers to install it for you).
- **Windows:** Windows 10/11, x64 or ARM64 — uses built-in PowerShell, no WSL needed.

---

Built by [Colby McHenry](https://github.com/colbymchenry).
