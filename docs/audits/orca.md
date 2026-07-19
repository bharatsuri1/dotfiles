# Orca

## Role

Modern open-source slicer for preparing 3D-printer jobs.

## Recommendation

Adopt on the new machine only if a supported printer workflow exists; otherwise keep tracked as optional rather than baseline.

## Modern baseline

Install the signed upstream build, start from maintained printer/filament/process profiles, calibrate per machine and material, and review generated G-code before first use. Preserve tested profiles independently of transient application caches.

## Host and legacy audit

Orca is intentionally tracked for the future machine but is not installed on this host. No legacy configuration exists.

## Configuration ownership

Bootstrap optionally. Version only deliberately exported, sanitized profiles; keep device identifiers, cloud credentials, camera endpoints, job history, caches, and machine-specific calibration local/private.

## Integration notes

May use FFmpeg for media workflows. Vesper is not a priority; functional preview contrast takes precedence.

## Open decisions

- Confirm printer model and whether vendor cloud integration is needed.

## Sources

- [OrcaSlicer project](https://github.com/SoftFever/OrcaSlicer)
- [OrcaSlicer documentation](https://www.orcaslicer.com/wiki/)
- [OrcaSlicer releases](https://github.com/SoftFever/OrcaSlicer/releases)
- Research date: 2026-07-13.
