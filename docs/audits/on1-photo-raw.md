# ON1 Photo RAW

## Role

File-oriented RAW editor and photo-management suite with effects and plugins.

## Recommendation

Retain only if a named capability or existing edit archive depends on it; otherwise omit from the clean baseline because Capture One and Photomator already cover its core roles.

## Modern baseline

Preserve original files and sidecar/catalog backups, export proprietary presets through supported UI, and avoid allowing multiple cataloging tools to manage the same folder tree without a clear authority.

## Host and legacy audit

ON1 Photo RAW 2026 is installed with multiple versioned preference domains. No portable ON1 configuration appears in legacy dotfiles.

## Configuration ownership

Installation/license are bootstrap concerns. Catalog databases, previews, caches, activation, AI models, private presets, and image sidecars remain outside public dotfiles. A separate private backup may hold authored preset exports.

## Integration notes

Substantial overlap with Capture One, Photomator, and Darkroom. Vesper must not affect color review.

## Open decisions

- Identify the unique ON1 workflow; omit if none remains.

## Sources

- [ON1 Photo RAW documentation](https://on1help.zendesk.com/hc/en-us/categories/115000370127-ON1-Photo-RAW)
- [ON1 Photo RAW](https://www.on1.com/products/photo-raw/)
- [ON1 support: backup and restore](https://on1help.zendesk.com/hc/en-us/search?query=backup%20restore)
- Research date: 2026-07-13.
