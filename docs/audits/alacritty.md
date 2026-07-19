# Alacritty

## Role

Serve as a minimal, cross-platform GPU terminal and fallback/reference implementation alongside the macOS-first terminal.

## Recommendation

Retain only if a second terminal is intentionally desired; otherwise omit after Ghostty validation. If retained, keep a small TOML file matching shared font, Vesper palette, padding, cursor, Option-as-Alt, clipboard, and Shift-Enter behavior.

## Modern baseline

Current Alacritty configuration is TOML at `$XDG_CONFIG_HOME/alacritty/alacritty.toml`; YAML-era examples are obsolete. Prefer imported theme files and documented macOS options. Alacritty deliberately does not provide tabs or splits, so Tmux owns multiplexing.

## Host and legacy audit

`/Applications/Alacritty.app` and an XDG config are present. The legacy config is thoughtfully aligned with Ghostty but duplicates a large amount of behavior and points to a theme path inconsistent with the checked-in legacy filenames. Preserve only intentional deltas from defaults.

## Configuration ownership

Track `alacritty/.config/alacritty/alacritty.toml` and a local Vesper theme file if upstream does not ship one. Install the app and Nerd Font through bootstrap. Window state and logs remain local.

## Integration notes

Set true color and Meta behavior consistently with Zsh, Neovim, and Tmux. Avoid terminal-specific keybindings that collide with Tmux, Homerow, or macOS shortcuts.

## Open decisions

- Keep Alacritty as a tested fallback or standardize exclusively on Ghostty.

## Sources

- [Alacritty configuration reference](https://alacritty.org/config-alacritty.html)
- [Alacritty default bindings](https://alacritty.org/config-alacritty-bindings.html)
- [Alacritty repository](https://github.com/alacritty/alacritty)
- Researched 2026-07-13.
