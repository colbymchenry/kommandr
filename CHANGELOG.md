# Changelog

All notable changes to the Kommandr desktop app are documented here. Each
release also ships as a [GitHub Release](https://github.com/colbymchenry/kommandr/releases)
tagged `desktop-vX.Y.Z` on the public repo, which is where most people will look —
its notes are extracted verbatim from this file.

Each release opens with a short **Highlights** list — the handful of things most
users will notice — followed by the full notes.

This project follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]


## [0.0.3] - 2026-08-27

### Highlights
- Switch projects from the title bar or with ⌘K — recent projects first, type to search all of them.
- Kommandr now tells you when a new version is out — a prompt with what's new and a download progress bar, and a badge on Settings if you choose "Later".
- The app no longer opens the developer console on launch.

### New Features
- Switch projects from the title bar: the arrow beside the project name (or ⌘K anywhere) opens a menu of your most recently opened projects, and typing searches all of them — the same switcher GitHub puts beside a repository name.
- When a new version is released, Kommandr shows what's new, downloads it with a progress bar, and offers to restart; dismissing the prompt leaves an update badge on Settings, and Settings → General → Software update lets you check, download, and restart any time.
- Kommandr keeps checking for updates every few hours while it's open, not just at launch.

### Fixes
- The developer tools console opened on every launch of the installed app; it now opens only in development.

## [0.0.2] - 2026-08-27

### Highlights
- The app icon, the mark in the sidebar, and the sign-in screen now use the same K as kommandr.com.

### Fixes
- The macOS app icon and the in-app mark were still the old "beads" artwork; they now match the K on kommandr.com, and the installer window no longer says "Beads Dashboard".

## [0.0.1] - 2026-08-27

### Highlights
- First public alpha of the Kommandr desktop app: signed and notarized macOS builds for Apple silicon and Intel, with in-app updates from here on.
- The subscription screen shows the real price, the yearly option, and everything Kommandr includes.
- Team owners and staff are no longer shown the "subscription has ended" screen, and get an Owner or Staff badge in the footer.
- Task Runner sessions start with the epic's description, the branch state, and the previous task's handoff note instead of rediscovering them from the repo.
- Task Runner agents now write their own handoff notes, aimed at whoever picks up the next task.

### New Features
- The subscription screen now shows what Kommandr includes — planning board, Task Runner, Live Editor, git client, phone control, and every supported coding agent — instead of a bare button.
- Every Task Runner session now starts with the epic's own description — its rules, the decisions already made, and where the design lives — instead of just the epic's title, so a fresh session after a context reset (or a task run on its own) no longer rediscovers the brief from the repo.
- Task Runner agents now write their own handoff note when they close a task, aimed at the next task in the epic and ending with what to read first. The note used to be generated afterwards by a smaller model from a cut-down recording of the session; that path remains as the fallback when the agent leaves no note.
- Every fresh Task Runner session starts with the branch, the commits on it, and the working-tree state already in hand instead of running git to find out.

### Fixes
- The subscription screen quoted a stale $20/month; it now shows the real price (and yearly option) from billing.
- Owners of the Kommandr team were shown the "subscription has ended" screen; they are now treated like staff, and team accounts show an Owner or Staff badge in the footer where the trial countdown would be.
- A Task Runner handoff note silently shrank to a bare list of files whenever the task's output contained a NUL byte; the full note is written again.
[0.0.1]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.0.1
[0.0.2]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.0.2
[0.0.3]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.0.3
