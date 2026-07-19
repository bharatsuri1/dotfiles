# Bazecor

## Role

Configuration and firmware utility for supported Dygma keyboards.

## Recommendation

Retain for the matching hardware, but treat the keyboard's onboard configuration as the durable source and keep an exported recovery copy.

## Modern baseline

Use stable firmware, export/back up layers before updates, make one change at a time, and validate recovery/bootloader procedures before flashing. Prefer onboard layers over host-only remapping for portability.

## Host and legacy audit

Bazecor is installed with its standard preference domain. No exported keyboard definition exists in legacy dotfiles.

## Configuration ownership

Bootstrap the app. Track only explicit sanitized backups/exports if Bazecor supports a stable format; keep device identifiers, logs, firmware caches, and app preferences local.

## Integration notes

Coordinate layers with Vial, Homerow, terminal bindings, and macOS modifier conventions. Ideally one configurator owns each physical keyboard. Vesper is irrelevant.

## Open decisions

- Identify the Dygma board/firmware and establish an export/restore test.

## Sources

- [Dygma Help Center: Bazecor](https://support.dygma.com/hc/en-us/categories/360002820997-Bazecor)
- [Bazecor source](https://github.com/Dygmalab/Bazecor)
- [Dygma firmware releases](https://github.com/Dygmalab/Raise-Firmware/releases)
- Research date: 2026-07-13.
