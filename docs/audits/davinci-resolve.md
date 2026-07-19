# DaVinci Resolve

## Role

Professional video editing, color, audio, and delivery environment.

## Recommendation

Retain as the single serious video editor; bootstrap conservatively and protect project libraries independently of media.

## Modern baseline

Use project-library backups, archive critical projects with media when portability matters, manage cache/proxy locations explicitly, and export keyboard/preset assets through supported UI. Color management should be intentional and display-calibrated.

## Host and legacy audit

DaVinci Resolve is installed with its normal application domain. No legacy tracked configuration exists.

## Configuration ownership

Install/activate separately. Project libraries, media, galleries, LUTs of uncertain license, caches, proxies, credentials, and hardware state stay local/private. Track only personally authored, portable exports such as keyboard maps, presets, or LUT references after review.

## Integration notes

FFmpeg complements conversion/inspection but should not mutate managed Resolve media. Capture One may supply still assets. Vesper must not influence color-critical viewers.

## Open decisions

- Select project-library backup and cache/scratch-volume policy.

## Sources

- [Blackmagic Design Resolve support](https://www.blackmagicdesign.com/support/family/davinci-resolve-and-fusion)
- [DaVinci Resolve training](https://www.blackmagicdesign.com/products/davinciresolve/training)
- [DaVinci Resolve product page](https://www.blackmagicdesign.com/products/davinciresolve)
- Research date: 2026-07-13.
