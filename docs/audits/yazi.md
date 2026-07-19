# Yazi

## Role

Provide a fast terminal file manager with previews, bulk operations, and directory navigation that complements rather than replaces the shell.

## Recommendation

Retain, but regenerate a minimal override-only configuration against current Yazi 26.5.6. Keep vi navigation, `fd`/`rg` search, FZF and Zoxide built-ins, safe trash behavior, and a Vesper flavor. Add plugins only for demonstrated gaps.

## Modern baseline

Yazi has three override files—`yazi.toml`, `keymap.toml`, and `theme.toml`—under XDG config. Official guidance says not to copy full shipped defaults: include only overrides. `ya pkg` manages plugins/flavors and records dependencies in `package.toml`; Yazi and `ya` versions must match. Built-in FZF and Zoxide plugins cover common jumping needs.

## Host and legacy audit

Homebrew Yazi 26.5.6 is installed. Legacy files copy most shipped defaults and vendor complete Catppuccin and Rosé Pine flavors. The useful intent is vi-style navigation, safe trash, `fd`/`rg`, FZF/Zoxide, image/document previews, and a cwd-return workflow. The bulk defaults and old flavors should be dropped.

## Configuration ownership

Track concise override files, `package.toml`, any tiny `init.lua`, and a reviewed Vesper flavor. Bootstrap installs Yazi and external previewers (`ffmpeg`, image/PDF tools) only when chosen. Caches, thumbnails, task state, cwd handoff files, and plugin downloads remain local.

## Integration notes

Use Bat for text previews where supported and reuse `fd`, `rg`, FZF, and Zoxide. Terminal graphics differ between Ghostty, Alacritty, and Tmux, so preview behavior needs end-to-end verification. Avoid duplicating shell file-opening aliases unnecessarily.

## Open decisions

- Minimal external previewer dependency set.
- Whether any third-party plugins are essential after testing current built-ins.

## Sources

- [Yazi configuration](https://yazi-rs.github.io/docs/configuration/overview/)
- [Yazi package manager](https://yazi-rs.github.io/docs/cli/)
- [Yazi built-in plugins](https://yazi-rs.github.io/docs/plugins/builtins/)
- [Yazi plugin overview](https://yazi-rs.github.io/docs/plugins/overview/)
- Researched 2026-07-13.
