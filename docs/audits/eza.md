# Eza

## Role

Provide a readable, Git-aware and icon-capable interactive directory listing while leaving portable scripts free to use standard `ls`.

## Recommendation

Retain Eza through Homebrew. Define a small family of explicit interactive aliases such as `l`, `ll`, `la` and `lt`; do not globally alias `ls` until the behavior has been reviewed for scripts, copied commands and remote shells. Use `--icons=auto`, automatic color, grouped directories and restrained Git metadata.

## Modern baseline

Eza supports Git status, hyperlinks, icons, tree views and `LS_COLORS`. Icons require a Nerd Font, already relevant to the terminal and Starship audits. Output should degrade cleanly when redirected. Prefer a few stable aliases over a large flag matrix, and keep expensive recursive or Git-heavy views opt-in.

## Host and legacy audit

Eza 0.23.4 is installed at `/opt/homebrew/bin/eza`. Legacy Zsh aliases replaced `ls` and used icons plus directory grouping; Sesh previews also depend on Eza. Carry forward the useful presentation defaults and Sesh integration only after checking non-interactive assumptions. Replace the old Rose Pine/Catppuccin color inheritance with Vesper-derived `LS_COLORS` from Vivid.

## Configuration ownership

Eza has no required durable configuration for this setup. Track aliases in the Zsh package and any Sesh preview commands in Sesh configuration. Homebrew owns the binary. Theme data comes from Vivid rather than an Eza-specific generated file.

## Integration notes

Coordinate with Vivid for `LS_COLORS`, Ghostty/Alacritty for font glyphs, and Sesh/Yazi so previews do not duplicate responsibilities. Standard `ls` remains available for portability and recovery.

## Open decisions

- Whether `ls` itself should remain standard or become an interactive Eza alias.
- Final minimal alias set and whether Git columns should be default or opt-in.

## Sources

- [Eza repository](https://github.com/eza-community/eza)
- [Eza documentation](https://eza.rocks/)
- [Homebrew Eza formula](https://formulae.brew.sh/formula/eza)
- Local host, legacy Zsh and Sesh audit, 2026-07-13.
