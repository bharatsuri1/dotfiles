# Visual Studio Code

## Role

Provide a GUI editor/debugger and extension host for workflows where Neovim is not the best surface.

## Recommendation

Retain, but rebuild a small default profile rather than restoring the broad legacy settings file. Track only stable editor ergonomics, Vesper, keyboard bindings, terminal shell choice, privacy preferences, and a curated extension manifest.

## Modern baseline

On macOS, user settings and keybindings live under `~/Library/Application Support/Code/User`; named profiles add generated profile IDs. Profiles can be exported/imported and launched by name. Settings Sync is convenient but becomes a competing source of truth if Git also owns settings. Workspace/language settings should live with projects rather than in global dotfiles.

## Host and legacy audit

VS Code 1.127.0 and the `code` launcher are installed. Legacy settings cover many languages, Remote SSH, Vim emulation, Docker, GitLens, Claude Code, Svelte, experimental TypeScript, terminal details, exclusions, and UI choices. It also contains machine-specific remote-platform structure and obsolete/extension-dependent settings. Preserve only validated habits; do not copy wholesale.

## Configuration ownership

Track sanitized `settings.json` and `keybindings.json` at their macOS target plus a reviewed extension list or Brewfile entries. Bootstrap owns app/extension installation. Never track Settings Sync tokens, account state, global storage, workspace storage, caches, logs, recent files, remote hosts, machine IDs, or extension secrets.

## Integration notes

Neovim remains primary terminal editor; define when VS Code is preferred. Use Zsh as integrated shell without duplicating shell initialization. Vesper and the Nerd Font should align visually. Remote SSH identities/hosts belong in SSH config, not editor settings.

## Open decisions

- Git-managed settings versus VS Code Settings Sync; choose one authority.
- Whether to retain VSCodeVim now that Neovim is primary.
- Final minimal extension list.

## Sources

- [VS Code user and workspace settings](https://code.visualstudio.com/docs/configure/settings)
- [VS Code profiles](https://code.visualstudio.com/docs/configure/profiles)
- [VS Code command line](https://code.visualstudio.com/docs/configure/command-line)
- [VS Code Settings Sync](https://code.visualstudio.com/docs/configure/settings-sync)
- Researched 2026-07-13.
