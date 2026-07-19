# lnav

## Role

Provide interactive navigation, filtering, querying, and correlation of local log files.

## Recommendation

Retain for non-trivial log investigation. Track only deliberate UI policy and reusable public log-format definitions.

## Modern baseline

lnav supports JSON-schema configuration, custom log formats, SQL queries, themes, and layered config directories. The official management CLI can explain configuration provenance. Prefer default colors when terminal transparency is important and use custom formats only for stable, non-private schemas.

## Host and legacy audit

lnav is installed. The live config directory contains only history and metadata databases; these are mutable and unsuitable for version control. No legacy durable config exists.

## Configuration ownership

Homebrew owns installation. Stow may own schema-valid JSON configuration and public format definitions under `~/.config/lnav`; text-input history, log metadata, sessions, captures, and source logs remain local.

## Integration notes

Overlaps with `tail`, `jq`, Logdy, and K9s logs. lnav is the deep terminal log analyzer; Logdy is the browser-based live viewer. A Vesper theme is optional; semantic log levels must remain distinct.

## Open decisions

- Whether observed workflows justify custom formats.
- Whether to keep the built-in theme or author Vesper.

## Sources

- [lnav stable documentation](https://docs.lnav.org/en/latest/)
- [lnav configuration](https://docs.lnav.org/en/latest/config.html)
- [lnav repository](https://github.com/tstack/lnav)
- Researched 2026-07-13.
