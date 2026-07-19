# Logi Options+

## Role

Vendor configuration for Logitech mouse/keyboard buttons, gestures, and device behavior.

## Recommendation

Retain only for hardware features macOS cannot express reliably; keep app-specific mappings sparse.

## Modern baseline

Install the current signed vendor release, grant Accessibility/Input Monitoring only as required, disable analytics where offered, and avoid building a large opaque per-app mapping system. Back up mappings through the vendor-supported account flow only if acceptable.

## Host and legacy audit

Logi Options+ is installed with several helper/driver preference domains. No legacy tracked configuration exists.

## Configuration ownership

Bootstrap the vendor app and document permissions. Device state, account sync, identifiers, analytics, helper preferences, and mappings remain local unless a supported sanitized export becomes available.

## Integration notes

Avoid duplicating behavior in Homerow, Raycast, keyboard firmware, or macOS shortcuts. Vesper is irrelevant.

## Open decisions

- Identify indispensable device mappings; omit everything else.

## Sources

- [Logi Options+](https://www.logitech.com/software/logi-options-plus.html)
- [Logitech support: Options+ permissions on macOS](https://support.logi.com/hc/en-us/articles/1500005514962)
- [Apple: Input Monitoring privacy](https://support.apple.com/guide/mac-help/control-access-to-input-monitoring-mchl4cedafb6/mac)
- Research date: 2026-07-13.
