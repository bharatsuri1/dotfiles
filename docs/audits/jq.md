# jq

## Role

Provide the canonical composable processor for JSON in shell pipelines and scripts.

## Recommendation

Retain as foundational infrastructure. Do not add aliases or global modules until a real repeated need exists.

## Modern baseline

jq is stable, scriptable, stream-oriented, and broadly interoperable. Scripts should use explicit filters, quote shell expressions correctly, and prefer `--raw-output` only when downstream consumers expect text. Color can be controlled with `JQ_COLORS`, but defaults are portable.

## Host and legacy audit

jq is installed. No dedicated configuration or reusable jq module tree was found.

## Configuration ownership

Homebrew owns installation. Dotfiles may own reusable public jq modules or a color environment variable in Zsh. Data, filters containing private endpoints, credentials, and command history remain local.

## Integration notes

jq is the non-interactive transformation engine; fx is the exploratory TUI. It composes with xh, gh, kubectl, Logdy, and shell scripts. A Vesper `JQ_COLORS` palette is optional and should honor `NO_COLOR` in automation.

## Open decisions

- Whether visual consistency warrants a custom `JQ_COLORS` value.

## Sources

- [jq manual](https://jqlang.org/manual/)
- [jq repository](https://github.com/jqlang/jq)
- [NO_COLOR convention](https://no-color.org/)
- Researched 2026-07-13.
