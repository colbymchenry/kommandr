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


## [0.5.1] - 2026-09-04

### Highlights
- Fixed the phone getting stuck on a plain, unstyled "Loading projects…" screen — remote access could end up fighting itself and drop every request after the first.

### Fixes
- Fixed the phone loading a plain, unstyled page stuck on "Loading projects…". Restarting remote access could leave the Mac holding two connections at once; because only the newest counts, the two knocked each other offline about twice a second and nothing after the first page request got through — and it stayed that way until the app was restarted. Remote access now keeps a single connection, and restarting it replaces that connection cleanly instead of leaving the old one fighting the new one.

## [0.5.0] - 2026-09-04

### Highlights
- Press Stop right after sending and your message comes back to the message box exactly as you typed it, so you can reword instead of retyping.
- In Live Edit, the AI works in the preview you are looking at — you watch it click through your app instead of it browsing in a window you cannot see.
- Question panels take a note on any choice you pick, for when the right answer is "this one, but…".
- Stopping just after you answer a question panel brings the questions back with your choices still selected.
- Configure Dev Server is back to a command and a port — setting up a test user for the AI's browser is no longer a thing.

### New Features
- Pressing Stop before the AI has started answering now takes your message back out of the chat and returns it to the message box, exactly as you typed it — mentions, pasted blocks and attachments included — so you can refine the prompt instead of retyping it. Once a reply has started, Stop works the way it always has and the message stays. If you were typing a follow-up while you waited, it is kept below the message that came back, and a message you pull back on one device disappears on the other too.
- You can add a note to any choice in a question panel — "Add a note" puts a line under each option you picked, and it reaches the agent alongside that choice. Handy when the right answer is "this one, but…".
- Stopping right after you answer a question panel brings the questions back with your choices still selected, so you can change a wrong pick and send again instead of re-answering from scratch.
- In Live Edit, the AI now works in the preview you're looking at. When it opens a page, clicks through a flow or checks the console, it happens in the preview pane beside the chat (each click shows a purple ripple) instead of in a hidden window, so you can watch and step in. With the preview closed it uses the in-app agent browser as before.
- Configure Dev Server is back to command and port. The "AI browser access" section is gone: agents browse your running app in the in-app browser with your own login, for any sign-in provider, so there is no Clerk test user to set up. If you had entered one there, put it in the project's .env as CLERK_TEST_EMAIL / CLERK_TEST_PASSWORD and the standalone browser still signs in with it.

## [0.4.0] - 2026-09-03

### Highlights
- You can see the browser your agents use, and take it over. A **Browser** button in the project header puts it on screen — sign in for the agent, watch it work, or click something yourself.
- Agents ask before anything consequential in the browser: paying, deleting, sending or publishing, or confirming something that can't be undone.
- Everything the browser does is recorded with a snapshot, so you can check afterwards exactly what an agent did in your accounts.
- Browser logins are kept per client: sign into a tool once and every project has it, while one client's accounts stay separate from another's.
- Screenshots from the in-app browser stopped failing and falling back to the slower browser — that had been happening dozens of times a day.
- Full-page screenshots of sites that reveal sections as you scroll now come out complete, instead of blank below the first screen.
- Claude Fable 5.1 and Claude Opus 4.8 are in the Claude model picker.

### New Features
- Claude Fable 5.1 and Claude Opus 4.8 are in the Claude model picker, next to Opus 5, Fable 5, Sonnet 5 and Haiku 4.5. Fable 5 stays available for anyone who wants to keep using it.
- You can now see the browser the agent drives. A **Browser** button in the project header puts the in-app agent browser on screen so you can sign in for the agent, watch it work, or take over — anything you sign into there stays signed in for it, and the agent keeps driving the same window. The popover carries the address bar, back, forward and reload. Agents get the same door: when a page needs your login they show the window and ask you to sign in, instead of telling you to sign into the Live Edit preview.
- Browser logins are kept per client. By default every project's agent browser shares one set of logins, so you sign into a tool once; a client can be given its own with the **Own browser logins** switch on its page, for accounts (Shopify, Google, Framer…) that are theirs rather than yours or another client's. The Live Edit preview uses the same profile as the agent browser, so signing in there signs the agent in too.
- Full-page screenshots scroll through the page before capturing, so sites that reveal sections as you scroll (Framer, Webflow, lazily loaded images) come out complete instead of blank below the first screen — in the in-app browser and the standalone one alike.
- Consequential browser actions ask you first. When an agent's click looks like a payment or purchase, a deletion or account change, sending or publishing something, or confirming a dialog that says it cannot be undone, the click pauses and a question appears in the chat (and on your phone): allow it, do it yourself in the agent browser, or deny. An agent can't slip past the check by scripting the click either: on a checkout page, a page with a card field, or under a warning dialog, that is refused too. The off switch is in Settings → General → AI browser.
- Browser activity: every page the agent opens, every click, everything it types (secrets masked), every interacting script and window show/hide is recorded with a snapshot and the approval decision, so you can audit what it did in your accounts afterwards. Open it from the project header's Browser button; entries are kept for 30 days.

### Fixes
- Screenshots from the in-app agent browser no longer fail with "Preview bridge did not respond within 60s" and fall back to the standalone browser. Any capture over about a megabyte — a full-page capture, a photo-heavy page — was silently dropping the app's internal connection; captures now travel as files. This had been happening 10–30 times a day since the in-app browser shipped.
- Console logs and network requests from the visible Live Edit preview (ghost mode) are captured again. The preview's color-scheme handling had been holding the only debugger slot, so the capture never attached.

## [0.3.0] - 2026-09-03

### Highlights
- Creating a new project is one page again — pick what you're building, the framework **and its version**, where it goes, and which tracker its issues live in (local, JIRA, Neon…), then Create. New projects come out ready to use instead of asking to be initialized.
- The Planner and the General chat can browse the web in a brand-new project, before any dev server is set up — so "go look at this site and rebuild it here" works, screenshots and all.

### New Features
- Create New is a single page instead of a three-step wizard: what you're building, the framework, its version, a few framework options, name and folder, issue key, storage backend, client, and a note for the agent — with a one-line summary of exactly what will be created above the Create button.
- Pick the framework when creating a project. Websites offer Astro, Eleventy or plain Vite; web apps Next.js, SvelteKit, Nuxt or React Router; mobile apps Expo or the React Native CLI; API backends Hono, Express, Fastify or NestJS; Shopify themes Skeleton or Dawn. Astro was previously forced on every website.
- Pick the framework version from a dropdown listing its release lines from the npm registry — 7.x, 6.x, 5.x, Expo's SDK 57, SDK 56…, and pre-release tags — with the latest release preselected. The agent pins the version you choose.
- Choose the storage backend (local SQLite, JIRA, PostgreSQL/Neon…) and the client for a new project right in the Create New form, the same choices the Add Existing and Clone tabs already offered.
- Create a General project (documents, files and tasks — no code) from the same form: an empty folder with a docs/ directory, ready in a second, no agent involved.
- The Create New form remembers the parent folder you used last time (falling back to the folder your most recent project lives in), and lets you pick which AI provider and model scaffolds the project.
- If scaffolding fails after the folder was created, the error screen offers to register the folder as it is instead of starting over.
- The AI browser can save its screenshots into the project (`saveAs` on the screenshot tool), so a Planner asked to study a site can keep full-page and per-section captures under the repo and point each task at exact reference images instead of describing them.

### Fixes
- The Planner and the General chat can use the browser in a project that has no dev server set up yet — a fresh project whose reference site lives elsewhere, for example. The browser tools only loaded once a dev server was configured, so asking the Planner to screenshot a site got "I can't browse the web from this planning session" back. The Planner is also told how to use the browser now; before, even in a project with a dev server, nothing in its briefing mentioned it.
- A chat no longer stays stuck on "Writing…" with the composer reading "Claude Code is responding…" after a reply that asked you two or more questions along the way — the response had finished, but the chat only unlocked after pressing Stop.
- A project created from the Create New tab no longer lands on "This project hasn't been initialized yet": Kommandr now sets up the issue store (and the storage backend you chose) before registering the project, so the board works the moment the scaffold finishes.
- The Create New tab's framework options are decided by Kommandr instead of being generated by a model on every visit — the form appears instantly, and the same framework always offers the same options.
- Scaffolding a project with a non-Claude default provider no longer asks it for a model it doesn't have.

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
[0.3.0]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.3.0
[0.4.0]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.4.0
[0.5.0]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.5.0
[0.5.1]: https://github.com/colbymchenry/kommandr/releases/tag/desktop-v0.5.1
