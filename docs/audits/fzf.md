# FZF

## Role

Provide the shared fuzzy-selection engine for shell completion/history-adjacent workflows, files, directories, Tmux/Sesh, Yazi, and small scripts.

## Recommendation

Retain. Use official Zsh integration selectively, a concise Vesper visual baseline, `fd` for file/directory candidates, and Bat for bounded previews. Keep context-specific options at each call site rather than growing one global option string.

## Modern baseline

Current FZF provides generated shell integration (`fzf --zsh`) and supports separate commands/options for Ctrl-T and Alt-C. `FZF_DEFAULT_OPTS_FILE` is preferable to an unwieldy environment variable for portable visual defaults. Global defaults apply to every consumer, so they should contain only universally safe UI behavior—not preview commands, multi-select, or layout assumptions.

## Host and legacy audit

Homebrew FZF 0.74.0 is installed. No standalone legacy config exists, but Tmux/Sesh and Yazi reference FZF heavily. Atuin is planned to own shell history search, so the default FZF Ctrl-R binding would overlap.

## Configuration ownership

Track a small `fzf/.config/fzf/fzfrc` if using `FZF_DEFAULT_OPTS_FILE`, plus Zsh integration policy in `fzf.zsh`. Bootstrap installs FZF, fd, and Bat. Runtime selection results, temporary files, history, sockets/listeners, and generated shell scripts remain untracked.

## Integration notes

Disable or do not source FZF Ctrl-R when Atuin owns history. Let Sesh/Tmux define popup dimensions and bind/reload behavior locally. Yazi uses its built-in FZF plugin. Vesper colors must remain readable in both terminal emulators and inside Tmux.

## Open decisions

- Exact ownership of Ctrl-T and Alt-C versus custom Zsh widgets and Zoxide.
- Whether any universal preview belongs in FZF defaults (recommend no).

## Sources

- [FZF repository and shell integration](https://github.com/junegunn/fzf)
- [FZF README](https://github.com/junegunn/fzf/blob/master/README.md)
- [FZF releases](https://github.com/junegunn/fzf/releases)
- [Community XDG options-file pattern](https://www.reddit.com/r/commandline/comments/1j3iwkz/zsh_keymap_to_start_fzf_with_default_opts/)
- Researched 2026-07-13.
