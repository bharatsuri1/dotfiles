# Raycast

## Role

Act as the primary launcher and command palette for applications, snippets, quicklinks, window actions, and selected integrations.

## Recommendation

Retain, but keep the installation intentionally small. Document the approved extension inventory and restore through official export/import rather than tracking internal databases.

## Modern baseline

Raycast v2 can export settings, aliases, hotkeys, extensions, snippets, quicklinks, layouts, and sensitive categories to an encrypted `.rayconfig`; snippets and quicklinks can be exported separately as unencrypted JSON. Extension credentials and permissions require local review.

## Host and legacy audit

Raycast is installed. Legacy documentation lists twelve extensions spanning reminders, credentials, CleanShot, Chrome, meetings, process control, Obsidian, speed testing, translation, and VS Code. A broader current-host inventory also observed Apple Notes, Apple Reminders, CleanShot X, Coffee, Color Picker, Flighty, GitHub, Google Chrome, Google Meet, Google Search, Google Workspace, Kill Process, Linear, Messages, Music, Obsidian, Raycast Explorer, Speedtest, Spotify Player, Todoist, Google Translate, Visual Studio Code and YouTube integrations. This is evidence for review, not an approved install list. Re-audit each for actual use, permissions and overlaps. A live config exists but must not be treated as a portable public file.

## Configuration ownership

Homebrew cask/bootstrap owns the app. Dotfiles own a human-readable approved extension list and optional non-sensitive snippets/quicklinks. Encrypted backups live outside the public repo; tokens, clipboard history, notes, AI chats, MCP settings, and databases remain local.

## Integration notes

Overlaps with Spotlight, Homerow, window managers, Speedtest, Chrome, Obsidian, and ChatGPT. Use Vesper appearance if supported, but native readability takes priority. Reserve global hotkeys centrally.

## Open decisions

- Which legacy extensions earn inclusion.
- Whether manual encrypted export or Raycast Cloud Sync is authoritative.

## Sources

- [Raycast import and export](https://manual.raycast.com/import-export)
- [Raycast settings](https://manual.raycast.com/settings)
- [Raycast extensions](https://manual.raycast.com/extensions)
- [Community dotfiles discussion](https://www.reddit.com/r/raycastapp/comments/1shunqk/make_raycast_settings_dotfiles_friendly/)
- Researched 2026-07-13.
