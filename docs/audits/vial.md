# Vial

## Role

Open keyboard configurator for Vial/QMK-compatible hardware.

## Recommendation

Retain for compatible non-Dygma keyboards; keep layouts on-device and maintain a versioned export for disaster recovery.

## Modern baseline

Confirm firmware provenance, save the current layout before changes, and keep a known recovery method. Vial offers live remapping without reflashing, but firmware changes remain hardware-risk operations.

## Host and legacy audit

Vial is installed and has current and older preference domains; no tracked layout export exists.

## Configuration ownership

Bootstrap the app. Track sanitized `.vil`/supported layout exports when stable; keep USB state, device identifiers, logs, and GUI preferences local.

## Integration notes

Overlaps with Bazecor by device, not globally. Harmonize navigation layers with Homerow, Vimium, Zsh Vi Mode, and editor bindings. Vesper is irrelevant.

## Open decisions

- Inventory compatible keyboards and decide canonical export location.

## Sources

- [Vial documentation](https://get.vial.today/docs/)
- [Vial source](https://github.com/vial-kb/vial-gui)
- [Vial security model](https://get.vial.today/docs/security.html)
- Research date: 2026-07-13.
