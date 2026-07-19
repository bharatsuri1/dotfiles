# Vivid

## Role

Generate one intentional `LS_COLORS` palette for terminal file listings and tools that honor the standard environment variable.

## Recommendation

Retain Vivid through Homebrew. Create or select a Vesper-compatible theme, generate `LS_COLORS` during bootstrap or explicit theme maintenance, and source/export the generated result during interactive startup. Do not run Vivid on every shell launch.

## Modern baseline

Vivid converts a declarative YAML theme and file-type database into GNU `LS_COLORS`. A custom theme can live under the XDG config tree. The generated environment value is derived output: it should be reproducible, disposable and stored in cache rather than maintained manually.

## Host and legacy audit

Vivid 0.11.1 is installed at `/opt/homebrew/bin/vivid`. Legacy configurations generated Catppuccin Mocha directly on each shell startup, while later design notes proposed a cached Rose Pine value. Preserve the cached-generation pattern but replace both palettes with Vesper and avoid elaborate generic lazy-cache machinery unless several audits justify it.

## Configuration ownership

Track a Vesper theme YAML if the built-in catalog has no suitable exact theme, plus the small Zsh loader. Homebrew owns Vivid. Store generated `LS_COLORS` under `$XDG_CACHE_HOME/vivid`; do not track it. The environment variable should be exported only where color-capable interactive tools need it.

## Integration notes

Eza consumes `LS_COLORS` automatically. Bat, FZF, Yazi and terminal applications have their own theme systems and should not be forced through `LS_COLORS`, though their Vesper palettes should remain visually coherent.

## Open decisions

- Use an upstream Vesper theme if one exists and is maintained, or track a small local theme.
- Generate during machine bootstrap only or provide a dedicated theme refresh command.

## Sources

- [Vivid repository](https://github.com/sharkdp/vivid)
- [Vivid theme format](https://github.com/sharkdp/vivid/tree/master/themes)
- [Homebrew Vivid formula](https://formulae.brew.sh/formula/vivid)
- Local host and legacy Zsh audit, 2026-07-13.
