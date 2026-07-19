# Lazygit

## Role

Provide a fast, discoverable TUI for everyday Git inspection, staging, rebasing, conflict handling, and branch work.

## Recommendation

Retain as the primary interactive Git TUI while preserving Git CLI fluency. Keep configuration limited to a Vesper theme, editor integration, and an approved pager; avoid clever AI or destructive custom commands.

## Modern baseline

Lazygit uses `$XDG_CONFIG_HOME/lazygit/config.yml` and recommends specifying only settings that differ from defaults. It supports schemas, repo-specific overrides, external diff pagers, and custom commands. Global config should remain portable; repository-specific behavior belongs with the repository.

## Host and legacy audit

Homebrew Lazygit 0.63.0 is installed. Legacy config contains only a Catppuccin-style theme and author color, which is a clean scope but must be converted to Vesper. No custom commands or risky behavior need preservation.

## Configuration ownership

Track `lazygit/.config/lazygit/config.yml`. Install via Homebrew. Keep application state, recent repositories, update metadata, logs, credentials, and repository-specific `.git/lazygit.yml` outside this public repo.

## Integration notes

Inherit editor and Git transport/signing policy from Git. If Delta is selected, use the documented non-paging invocation and a Vesper-compatible syntax theme. Tmux may open Lazygit in a popup; Neovim may invoke the same binary rather than installing a separate Git UI stack.

## Open decisions

- Native diff rendering versus Delta.
- Keep only Tmux/CLI launch or also expose through Neovim.

## Sources

- [Lazygit configuration](https://lazygit.dev/docs/configuration/)
- [Lazygit complete config reference](https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md)
- [Lazygit custom pagers](https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md)
- Researched 2026-07-13.
