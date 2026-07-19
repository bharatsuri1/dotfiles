# xh

## Role

Provide a fast, human-friendly HTTP client for interactive API requests.

## Recommendation

Retain. Use native xh behavior and explicit request commands; do not alias over `curl` or `http` globally.

## Modern baseline

xh reimplements HTTPie's ergonomic syntax in Rust, supports macOS packages and TLS features, defaults status checking differently from strict HTTPie compatibility mode, and provides `xhs` for HTTPS-default shorthand. Credentials and certificates should be passed through secure local mechanisms.

## Host and legacy audit

xh is installed. No dedicated configuration or legacy request collection was found.

## Configuration ownership

Homebrew owns installation. Zsh may contain a minimal completion or HTTPS convention. Project-specific public examples belong with their projects. Tokens, cookies, sessions, client certificates, private hosts, request history, and payload captures stay local.

## Integration notes

Overlaps with curl and GUI API clients. xh is the interactive client; curl remains the universal script/documentation baseline. Pipe JSON to jq or fx and live streams to Logdy. Vesper is not materially applicable beyond inherited ANSI colors.

## Open decisions

- Whether to standardize on `xh` or `xhs` for interactive use.

## Sources

- [xh repository and compatibility behavior](https://github.com/ducaale/xh)
- [Homebrew formula](https://formulae.brew.sh/formula/xh)
- [HTTP Semantics, RFC 9110](https://www.rfc-editor.org/rfc/rfc9110)
- Researched 2026-07-13.
