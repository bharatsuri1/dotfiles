# Stats

## Role

Lightweight macOS menu-bar system telemetry.

## Recommendation

Retain, with a deliberately small sensor set that answers routine health questions without menu-bar noise.

## Modern baseline

Install from the signed release or Homebrew cask, show only actionable modules, and avoid aggressive polling. Stats is open source and stores ordinary macOS preferences; community usage strongly favors it as a focused alternative to heavyweight monitors.

## Host and legacy audit

Installed both as an application and Homebrew cask, with preference domain `eu.exelban.Stats`. No legacy tracked configuration exists.

## Configuration ownership

Bootstrap through Homebrew. Keep live sensor history and preferences local initially; only export/defaults-manage a small stable preference subset after verifying keys are portable across versions and hardware.

## Integration notes

Overlaps with Btop. Stats owns ambient menu-bar visibility; Btop owns interactive diagnosis. Match Vesper colors only if supported without fragile preference mutation.

## Open decisions

- Select the minimal visible modules and update interval.

## Sources

- [Stats project](https://github.com/exelban/stats)
- [Stats Homebrew cask](https://formulae.brew.sh/cask/stats)
- [r/macapps community discussion](https://www.reddit.com/r/macapps/search/?q=stats%20menu%20bar&restrict_sr=1)
- Research date: 2026-07-13.
