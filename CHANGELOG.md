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


## [0.2.0] - 2026-09-03

### Highlights
- Your phone now reaches your Mac at one permanent address. Pair once and stay paired — through sleep, network changes, and restarts — with no QR code to re-scan.
- Remote access recovers on its own after your Mac sleeps, instead of quietly staying down until you noticed and restarted it.
- Long chat titles and pasted links no longer overflow their row on the phone.

### New Features
- Your phone now connects to your Mac through one permanent address instead of a temporary one that changed every time the connection restarted. Pair once and it stays paired — through sleep, through moving between networks, through restarting Kommandr — with no QR code to re-scan and nothing to install. Requires the latest Kommandr app on your phone.

### Fixes
- Remote access no longer dies for good when your Mac sleeps at the wrong moment. If the connection to your phone was being re-established at the instant the Mac went to sleep, it was abandoned permanently — the phone showed "can't reach your Mac" and re-scanning the QR code was the only way back, even after the Mac woke up. It now keeps retrying on its own until it is back.
- Your phone stays paired through a sleeping Mac far more often: time the Mac spends asleep no longer counts against the connection, so it is given a real chance to recover on the same address instead of being replaced with a new one — which is what forced a re-scan. A Mac that idles in and out of sleep could previously go through several of these in an evening.
- On the phone, a chat whose title is a pasted link no longer runs past the edge of its row, and a long opening message is trimmed to two lines instead of stacking up the whole card — on both the Chats screen and a project's chat list.
- A starred chat on the phone no longer spends an entire line on the star when its title is one long unbroken word.
- The last paragraph of a document is no longer pinned against the bottom of the editor — scrolling to the end of a long document now leaves room below it again.

## [0.1.0] - 2026-08-28

### Highlights
- A new Docs tab: a file explorer for the project's `docs/` folder — folders, drag to move, rename in place — with a seamless inline Markdown editor beside it, so the assistant can read and write the same documents.
- AI inside your documents: Summarize, and Edit with AI for the whole document or just the text you highlight — reviewed before anything is saved, with your choice of provider and model — plus "chat about these documents" for any selection of docs and folders.
- Every chat is now kept: conversations get a title automatically, live in a per-project Chats panel, and pick up where they left off — even after restarting the app or opening them from your phone.
- The Markdown editor is now a real inline editor — you edit the formatted text directly, like JIRA or Confluence — everywhere Kommandr edits Markdown.
- A Files drawer: browse the project folder, drag files in from Finder, preview PDFs, images, spreadsheets and documents, and drag a file into a chat to talk about it — and the phone gets the same Docs and Files screens, AI included.
- Projects can now be "General" — for coursework, a business, writing, research — which hides the developer tools, speaks plainly on the board (goals, tasks, ideas, problems), and briefs the assistant as a helper that works in your documents rather than a code repository.

### New Features
- Chats are permanent: each conversation is saved with its messages, titled automatically after the first reply, and listed in the project's Chats panel (the speech-bubble button in any chat's header) with search, pin, rename, archive, and delete.
- Reopening a chat resumes it with its full context — the app rebuilds the conversation on demand, so a chat from last week keeps working after a restart.
- Search across chats finds conversations by title and by what was said in them; copy a chat as Markdown or save it into the project's docs.
- The phone's Chats list shows the same titled conversations and opens the exact chat you tap, not just the latest one on that surface.
- Docs tab on every project: a file explorer of the project's documents — nested folders that collapse and remember it, a "New doc" that adds a row you type the name into, folders from the "…" menu or a right-click, rename and delete in place, drag documents and folders between folders — plus search, inline editing with autosave, "Ask about this doc" to open a chat with the document attached, and a "Save as doc" button on any assistant reply. The phone gets a matching Docs screen with the same editor.
- Summarize and Edit with AI on every document: a quick synopsis you can copy or insert under the heading, and rewrites from a preset ("Fix spelling & grammar", "Make it concise", "Improve clarity", "Add structure") or your own instruction — shown for review with Keep / Discard before anything is saved. Pick the provider and model right in the bar (it starts on the provider's fast model, like Claude Haiku, so answers come back in seconds); ⌘Enter or "Ask in chat" turns what you typed into a question in a chat instead. Highlight any text and an "Edit with AI" button appears over it — the rewrite then applies to just that passage, formatting intact.
- Chat about several documents at once: ⌘-click, Shift-click, or the hover checkbox to select documents and folders, then Chat or Summarize — a new chat opens with every document attached (folders included). Those chats stay listed under "Chats about docs" in the sidebar so you can pick one up later.
- The phone has the same Docs: the folder tree, new documents and folders, rename, move and delete from each row's menu, a Select mode to chat about or summarize several documents, the "Chats about docs" list, and the editor with Summarize, Edit with AI (whole document or highlighted text, reviewed before saving) and Ask in chat.
- Files on the phone: browse the project folder, add photos and documents from your phone, preview images, PDFs, audio, video, spreadsheets, Markdown and text, rename, delete, and hand any file to a chat.
- Project knowledge (what the assistant remembers about the project) is now visible and editable from the Docs tab.
- Inline Markdown editing with headings, lists, task checkboxes, tables, links and code blocks, plus a "Markdown" toggle for editing the raw text when you need it — used for documents, issue descriptions, agent prompts, memory notes and CLAUDE.md.
- Files drawer (the Files button in a project's header): folder browsing with sizes and dates, drag files in from Finder or add them with a picker, previews for images, PDFs, audio, video, CSV, Markdown and text, reveal in Finder, rename, delete, and drag-a-file-into-chat to mention it.
- Choose a project's kind — Software or General — when adding it (Kommandr suggests one from the folder's contents) or later in Project settings. General projects open on their Docs tab, hide the dev server, code, terminal, git and GitHub tools, and label the board in everyday words; the planner and the task runner plan and produce documents instead of code.
- The workspace assistant's "create project" tool accepts the kind too, and infers it from the folder when omitted.

### Fixes
- Chat history no longer depends on the browser's local storage, which Electron did not always save on quit — conversations are stored by the app itself.

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
[0.1.0]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.1.0
[0.2.0]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.2.0
