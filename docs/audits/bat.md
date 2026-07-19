# Bat

## Role

Provide syntax-highlighted, Git-aware file viewing and previews while preserving `cat` for scripts and pipelines.

## Recommendation

Retain. Use Bat interactively and as the shared previewer for FZF/Yazi, with a small Vesper theme and conservative paging. Do not alias `cat` globally because that changes machine-readable behavior.

## Modern baseline

Bat supports an XDG config file discoverable with `bat --config-file`, custom themes in its config directory, and cache rebuilding with `bat cache --build`. Configuration should contain one argument per line. Shell aliases are appropriate for explicitly interactive variants, not for replacing POSIX utilities in scripts.

## Host and legacy audit

Homebrew Bat 0.26.1 is installed. Legacy config only selects Catppuccin Mocha and vendors its theme. The narrow scope is good; replace it with Vesper and verify theme discovery after Stow/bootstrap.

## Configuration ownership

Track `bat/.config/bat/config` and a Vesper `.tmTheme` only if not supplied upstream. Bootstrap installs Bat and rebuilds the local theme cache. Cache binaries, syntax-set cache, and generated metadata remain local.

## Integration notes

FZF and Yazi should call Bat with explicit noninteractive flags and size limits. Git may use Bat only for human-facing viewing, not as a pager replacement. Vesper syntax colors should remain readable on both terminal backgrounds.

## Open decisions

- Upstream Vesper theme versus a small maintained local theme.

## Sources

- [Bat repository and configuration](https://github.com/sharkdp/bat)
- [Bat themes](https://github.com/sharkdp/bat#adding-new-themes)
- [Homebrew Bat formula](https://formulae.brew.sh/formula/bat)
- Researched 2026-07-13.
