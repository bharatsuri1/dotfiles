# fx

## Role

Provide an interactive terminal viewer and exploratory processor for JSON streams and files.

## Recommendation

Retain as jq's interactive complement. Start configuration-free and add a tiny XDG rc file only for reusable, non-sensitive functions.

## Modern baseline

fx supports interactive navigation, streaming JSON, Vim-style movement, JavaScript expressions, YAML input, collapsed mode, and optional line numbers. It can load `.fxrc.js` from the current directory, home, or XDG config location; repository-local rc files should be treated as executable code.

## Host and legacy audit

fx is installed. No legacy or live rc file was found.

## Configuration ownership

Homebrew owns installation. Stow may own `$XDG_CONFIG_HOME/fx/.fxrc.js` if global helpers emerge. Input history, viewed data, project rc files, and sensitive API payloads remain local.

## Integration notes

Use jq for reproducible filters and scripts, fx for discovery. It pairs naturally with xh and gh output. Vesper support is limited; prefer inherited terminal colors and verify focus/selection contrast.

## Open decisions

- Whether fx has enough unique usage alongside jq to remain installed.

## Sources

- [fx official site](https://fx.wtf/)
- [fx repository](https://github.com/antonmedv/fx)
- [fx package documentation, including `.fxrc.js`](https://www.npmjs.com/package/fx)
- Researched 2026-07-13.
