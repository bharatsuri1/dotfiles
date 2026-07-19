# Obsidian

## Role

Durable personal knowledge base and Markdown authoring surface.

## Recommendation

Retain, but treat vaults as user data rather than dotfiles. Start with core plugins and add community plugins only for a demonstrated workflow.

## Modern baseline

Keep notes as portable Markdown, use one deliberate sync mechanism, and back up independently of sync. Obsidian Sync can selectively synchronize vault settings, themes, snippets, hotkeys, and plugin state; community plugins execute with broad local access and deserve review. Apply Vesper through a maintained theme or a small CSS snippet, not a fork.

## Host and legacy audit

Obsidian is installed and has a standard preference domain. No durable Obsidian configuration appears in the legacy dotfiles; Raycast previously referenced its extension.

## Configuration ownership

Bootstrap the app. Keep vault contents, workspace layouts, caches, credentials, sync metadata, and global Library state local/private. A reviewed vault-local `.obsidian` subset or CSS snippet may be versioned with that vault, not blindly stowed from this repository.

## Integration notes

Raycast may provide quick capture/search. Antinote should remain temporary capture; Obsidian is the durable destination.

## Open decisions

- Choose vault sync/backup policy and the minimal plugin set.

## Sources

- [Obsidian Help: How Obsidian stores data](https://help.obsidian.md/Files+and+folders/How+Obsidian+stores+data)
- [Obsidian Help: Sync settings and selective syncing](https://help.obsidian.md/Obsidian+Sync/Sync+settings+and+selective+syncing)
- [Obsidian Help: Security](https://help.obsidian.md/Extending+Obsidian/Plugin+security)
- Research date: 2026-07-13.
