# Starship

## Role

Provide one fast, shell-independent prompt with only high-value repository and environment context.

## Recommendation

Retain. Rebuild the legacy prompt as a small Vesper-native configuration: directory, Git branch and a cheap dirty indicator, jobs, direnv state, and vi-mode-aware character. Keep expensive language/version and Git-diff modules opt-in.

## Modern baseline

Starship uses `~/.config/starship.toml` by default, publishes a JSON schema, and recommends measuring slow modules with `starship timings`. Defaults are extensive, so an intentional prompt should explicitly define its format and keep command/scan timeouts bounded. Nerd Font symbols require a patched font across both terminal emulators.

## Host and legacy audit

Homebrew Starship 1.26.0 is installed and a legacy `starship.toml` exists. Its strongest ideas are bounded timeouts, disabled Git metrics/status, compact two-line layout, direnv signal, and vi-mode character. The mixed Rosé Pine/Catppuccin palette and custom Git subprocesses should not be copied wholesale.

## Configuration ownership

Track `starship/.config/starship.toml`. Install the binary and chosen Nerd Font through bootstrap/Homebrew. Do not track caches or shell-generated init output.

## Integration notes

Initialize once, late in interactive Zsh after vi-mode and environment tools. Use the same Vesper color tokens in Starship, Ghostty, Alacritty, Tmux, FZF, and TUIs. Benchmark prompt startup before accepting custom command modules.

## Open decisions

- Whether the dirty marker is valuable enough to justify a subprocess in large repositories.
- One-line versus two-line prompt after real use.

## Sources

- [Starship configuration](https://starship.rs/config/)
- [Starship advanced configuration and timings](https://starship.rs/advanced-config/)
- [Community presets](https://starship.rs/presets/)
- Researched 2026-07-13.
