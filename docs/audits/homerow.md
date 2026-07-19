# Homerow

## Role

Keyboard-driven activation of macOS UI elements.

## Recommendation

Retain as the focused GUI navigation layer if it continues to reduce pointer use.

## Modern baseline

Grant Accessibility permission deliberately, use one memorable activation shortcut, and prefer native accessibility labels over OCR where possible. Keep app exclusions minimal and intentional.

## Host and legacy audit

Homerow is installed with preference domain `com.superultra.Homerow`; no tracked legacy configuration was found.

## Configuration ownership

Bootstrap the app and document required macOS permissions. Keep license/account data and generated UI state local. A small supported preference export may be tracked only after portability testing.

## Integration notes

Complements Vimium inside Chrome and Zsh Vi Mode in the terminal. Avoid shortcut conflicts with Raycast and window-management bindings. Vesper has little material impact beyond hint contrast.

## Open decisions

- Finalize activation shortcut and whether scrolling mode is enabled.

## Sources

- [Homerow documentation](https://www.homerow.app/)
- [Homerow manual](https://www.homerow.app/manual)
- [Apple: control access to accessibility features](https://support.apple.com/guide/mac-help/allow-apps-to-control-your-mac-mh43185/mac)
- Research date: 2026-07-13.
