# Darkroom

## Role

Fast Apple-platform photo editing integrated with the system photo library.

## Recommendation

Retain only if its quick Photos-first workflow is distinct from Photomator and Capture One; otherwise omit to reduce editing overlap.

## Modern baseline

Treat Apple Photos/iCloud Photos as the library authority, preserve nondestructive edits, and avoid exporting duplicate masters without purpose. Subscription/account and Photos permissions are bootstrap concerns.

## Host and legacy audit

Darkroom is installed with a sandboxed application identity. No legacy configuration exists.

## Configuration ownership

Bootstrap through the App Store. Photos library, edits, presets, account state, caches, and preferences remain local/iCloud-owned. Track a written role decision, not containers or defaults.

## Integration notes

Directly overlaps with Photomator and partly ON1/Capture One. Vesper is not appropriate for a color-editing canvas; use neutral UI.

## Open decisions

- Decide whether Darkroom or Photomator owns quick Photos-library edits.

## Sources

- [Darkroom](https://darkroom.co/)
- [Darkroom Help Center](https://darkroom.co/help)
- [Apple: nondestructive editing in Photos extensions](https://support.apple.com/guide/photos/use-editing-extensions-phtf519dbb3/mac)
- Research date: 2026-07-13.
