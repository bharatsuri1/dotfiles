# Speedtest

## Role

Provide an occasional command-line measurement of internet latency, download throughput, and upload throughput.

## Recommendation

Omit from the core dotfiles package unless a recurring diagnostic workflow requires it. macOS already includes `networkQuality`; retain Speedtest only as an optional Brewfile item for Ookla-comparable results.

## Modern baseline

Ookla's official CLI is proprietary and licensed for personal, non-commercial use. Tests communicate with third-party servers and reveal network/IP characteristics. Apple's built-in `networkQuality` measures responsiveness and capacity without another package; results are methodology-dependent and should not be treated as universal truth.

## Host and legacy audit

A `speedtest` formula is installed, and the legacy Raycast extension list includes a Speedtest extension. No durable config exists. This duplicates both `networkQuality` and Raycast/browser access.

## Configuration ownership

If retained, bootstrap owns installation only. No result history, server identifiers, coordinates, IP information, or license-acceptance state belongs in public dotfiles.

## Integration notes

Choose one casual entry point: CLI, Raycast, or browser. Scripts should prefer `networkQuality` when macOS-only and parse stable machine output carefully. Vesper is not applicable.

## Open decisions

- Whether Ookla result comparability is valuable enough to retain the extra proprietary binary.

## Sources

- [Ookla Speedtest CLI](https://www.speedtest.net/apps/cli)
- [Apple `networkQuality` manual](https://keith.github.io/xcode-man-pages/networkQuality.8.html)
- [Community comparison with built-in networkQuality](https://www.reddit.com/r/apple/comments/r1pd9k/the_secret_of_the_macos_monterey_network_quality/)
- Researched 2026-07-13.
