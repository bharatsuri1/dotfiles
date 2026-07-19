# Alcove

## Role

Dynamic Island-style macOS status surface for media, system events, and shortcuts.

## Recommendation

Retain only if it replaces visible menu-bar/status friction; otherwise omit as cosmetic overlap.

## Modern baseline

Keep displayed modules limited, avoid redundant media/system monitors, and grant Accessibility or Screen Recording only when a retained feature requires it. Prefer native update and login-item controls.

## Host and legacy audit

Alcove is installed with preference domain `com.henrikruscon.Alcove`; no legacy configuration exists.

## Configuration ownership

Bootstrap the app and document permissions/login policy. License, preferences, media state, caches, and UI position remain local unless the vendor adds a supported export.

## Integration notes

May overlap with Stats, macOS notifications, Raycast, and media controls. If retained, use a restrained Vesper-compatible appearance without sacrificing contrast.

## Open decisions

- Identify which Alcove modules remain uniquely useful.

## Sources

- [Alcove](https://tryalcove.com/)
- [Alcove documentation](https://docs.tryalcove.com/)
- [Apple: manage login items](https://support.apple.com/guide/mac-help/open-items-automatically-when-you-log-in-mh15189/mac)
- Research date: 2026-07-13. Public portability documentation is limited.
