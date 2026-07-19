# Glow

## Role

Render Markdown cleanly in pipelines or an interactive terminal browser.

## Recommendation

Retain as the lightweight Markdown reader. Keep configuration minimal and use a custom Vesper Glamour style only if automatic dark-mode styling is insufficient.

## Modern baseline

Glow supports CLI and TUI modes, paging, width control, local/remote Markdown, and custom JSON styles. Upstream recommends `glow config` to locate the platform config. Automatic style selection and terminal-aware paging are sensible defaults.

## Host and legacy audit

Glow is installed. Legacy `glow.yml` enables mouse and pager, uses auto style, and forces width 150. Carry forward the intent but avoid a fixed wide wrap that performs poorly in narrow panes.

## Configuration ownership

Homebrew owns installation. Stow may own `~/.config/glow/glow.yml` and a Vesper style JSON. Downloaded content and transient browsing state remain local.

## Integration notes

Overlaps with Bat for source-like previews and Obsidian/MarkEdit for editing; Glow owns rendered terminal reading. Coordinate `$PAGER` with Git and preserve terminal background behavior.

## Open decisions

- Whether a Vesper stylesheet adds enough value over `style: auto`.
- Whether paging should be automatic or explicitly requested.

## Sources

- [Glow repository, configuration and styles](https://github.com/charmbracelet/glow)
- [Glamour styles](https://github.com/charmbracelet/glamour/tree/master/styles)
- [Homebrew formula](https://formulae.brew.sh/formula/glow)
- Researched 2026-07-13.
