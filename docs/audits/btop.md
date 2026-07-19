# Btop

## Role

Provide a fast interactive overview of CPU, memory, processes, disks, and network activity in the terminal.

## Recommendation

Retain. Track a small intentional config and a Vesper theme; avoid committing the complete auto-generated file unless every setting is deliberate.

## Modern baseline

Upstream supports Apple Silicon and stores configuration and user themes in `$XDG_CONFIG_HOME/btop`. Defaults are already sensible. Truecolor, terminal synchronized output, a 2-second sampling interval, and optional Vim keys are appropriate modern defaults.

## Host and legacy audit

Btop is installed. The live and legacy trees contain a full generated `btop.conf` and a Rose Pine theme. Most values are upstream defaults; the old theme conflicts with the Vesper direction and should not carry forward unchanged.

## Configuration ownership

Homebrew owns the binary. Stow should own only `~/.config/btop/btop.conf` and `themes/vesper.theme`. Logs and runtime state stay untracked.

## Integration notes

Overlaps with Stats for persistent menu-bar monitoring; Btop is the on-demand terminal inspector. It should inherit the terminal background and use the Vesper palette. Validate glyphs and synchronized output in Ghostty and Alacritty.

## Open decisions

- Whether to enable Vim navigation globally.
- Whether to show a transparent terminal background.

## Sources

- [Btop repository, macOS support, configuration and themes](https://github.com/aristocratos/btop)
- [Homebrew formula](https://formulae.brew.sh/formula/btop)
- [Community recommendations](https://www.reddit.com/r/commandline/search/?q=btop&restrict_sr=1&sort=top)
- Researched 2026-07-13.
