# Google Chrome

## Role

Compatibility browser for Google services, development, and sites that require Chromium.

## Recommendation

Retain as an intentional compatibility/work browser, not as an automatically restored personal-state bundle.

## Modern baseline

Use separate profiles only when they create a real boundary, keep extension count low, enable automatic updates and Safe Browsing, and review sync/privacy settings. macOS managed preferences exist, but Google warns that policy deployment is an administrative mechanism; personal dotfiles should not impersonate enterprise management without a concrete need.

## Host and legacy audit

Chrome is installed with its standard preference domain. Legacy Raycast configuration referenced the Chrome extension; no safe declarative Chrome baseline was found.

## Configuration ownership

Bootstrap the cask. Keep profiles, cookies, history, credentials, tokens, bookmarks, extension databases, and `~/Library/Application Support/Google/Chrome` local. Track only a human-reviewed extension list or narrow, documented policy profile if later justified.

## Integration notes

Audit Vimium as the keyboard layer and Raycast browser commands. Vesper may be applied through a vetted browser theme, but visual consistency does not justify a broad extension footprint.

## Open decisions

- Decide profile boundaries, sync policy, and minimal extension allowlist.

## Sources

- [Google Chrome Safety Center](https://safety.google/chrome/)
- [Chrome Enterprise: set browser policies](https://support.google.com/chrome/a/answer/187202)
- [Chromium administrator guidance](https://www.chromium.org/administrators/)
- Research date: 2026-07-13.
