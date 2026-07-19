# Logdy

## Role

Turn command output or log files into a searchable local web interface for live inspection.

## Recommendation

Retain provisionally as a focused complement to lnav. Install through Homebrew, bind locally by default, and avoid persisting sensitive streams.

## Modern baseline

Logdy accepts stdin and files, can aggregate multiple sources, and opens a web UI. Official install scripts perform optional download reporting; Homebrew avoids shell-piped installation. Saved `logdy.config.json` files are working-directory artifacts and may encode source assumptions.

## Host and legacy audit

Logdy is installed. No durable global configuration was found.

## Configuration ownership

Homebrew owns installation. Dotfiles should contain no config unless a portable, sanitized global default emerges. Per-project config belongs with the project after review. Logs, saved streams, browser data, network bindings, and private parsing rules remain local.

## Integration notes

lnav owns deep terminal analysis; Logdy owns convenient live browser visualization. Pipe structured output from applications directly and avoid exposing the UI beyond localhost. Vesper theming is not currently a dotfiles priority unless the product exposes a supported theme surface.

## Open decisions

- Whether regular usage justifies keeping both Logdy and lnav.
- Whether local-only network binding needs an explicit enforced default.

## Sources

- [Logdy overview](https://logdy.dev/docs/what-is-logdy)
- [Logdy quick start and install behavior](https://logdy.dev/docs/quick-start)
- [Logdy command modes](https://logdy.dev/docs/explanation/command-modes)
- Researched 2026-07-13.
