# Kommandr

AI-assisted project management for software teams: a macOS desktop app that keeps your
issues, epics and sprints next to the AI coding agents that work on them — Claude Code,
Codex, Gemini, Cursor, Copilot and more — with a phone companion to check on runs from anywhere.

This repository holds **releases only** — the desktop app builds and the changelog. Source
lives in private repositories.

## Kommandr desktop app (macOS)

Download the latest build, open the `.dmg`, and drag Kommandr to Applications:

| Mac | Download |
|---|---|
| Apple silicon (M1 and later) | [Kommandr-arm64.dmg](https://github.com/colbymchenry/kommandr/releases/latest/download/Kommandr-arm64.dmg) |
| Intel | [Kommandr-x64.dmg](https://github.com/colbymchenry/kommandr/releases/latest/download/Kommandr-x64.dmg) |

Every build is Developer ID signed and notarized by Apple. The app checks for updates
itself and offers to install them; see [CHANGELOG.md](./CHANGELOG.md) for what's in each
version, or browse the [releases](https://github.com/colbymchenry/kommandr/releases)
(desktop releases are tagged `desktop-vX.Y.Z`). Checksums ship alongside every release as
`SHA256SUMS`.

Windows and Linux builds are not available yet. This is an early alpha — expect rough edges,
and please report anything broken.

### Phone companion

The Kommandr iOS app pairs with the desktop app by QR code so you can follow task runs,
answer an agent's questions, and start work from your phone. It is distributed through
TestFlight — ask for an invite.
