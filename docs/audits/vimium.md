# Vimium

## Role

Provide Vim-like keyboard navigation in Chrome without replacing native browser behavior on text-heavy applications.

## Recommendation

Retain. Rebuild a compact export containing intentional mappings, search engines, exclusions, and Vesper UI CSS; remove stale search providers and personal locations.

## Modern baseline

Vimium supports portable option export/import, custom `map`/`unmap` directives, search-engine shortcuts, exclusion rules, and link-hint CSS. Keep defaults unless a conflict is demonstrated and exclude sites whose editors implement their own Vim behavior.

## Host and legacy audit

The legacy JSON includes many search engines and extensive dark UI CSS. It also contains a location-oriented shortcut that must not enter a public repository. Preserve only active general-purpose engines and the styling concept, rewritten for Vesper.

## Configuration ownership

The browser extension is installed through Chrome policy/manual bootstrap. Stow can retain a sanitized importable JSON reference, but Chrome's extension database and sync state remain local. Never track browsing data or personal query URLs.

## Integration notes

Coordinate with Chrome, Homerow, Zsh Vi Mode, Neovim web apps, and application shortcuts. Vesper CSS should cover hints, Vomnibar, HUD, focus, and readable contrast.

## Open decisions

- Which web applications require exclusions.
- Whether Chrome Sync or explicit JSON import is the restoration authority.

## Sources

- [Vimium repository and key mappings](https://github.com/philc/vimium)
- [Vimium project site](https://vimium.github.io/)
- [Chrome extension management](https://support.google.com/chrome_webstore/answer/2664769)
- Researched 2026-07-13.
