# Wget

## Role

Provide reliable non-interactive downloads, mirroring, timestamping, and resumable retrieval where curl's transfer-oriented interface is less convenient.

## Recommendation

Retain, but remain configuration-free initially. Use curl for portable API examples and Wget for retrieval/mirroring workflows.

## Modern baseline

GNU Wget supports recursive retrieval, timestamping, continuation, proxy configuration, and startup files. It reads `$WGETRC` when set, otherwise `$HOME/.wgetrc`; this provides an intentional XDG bridge. Global defaults can subtly change scripts, so avoid them without a demonstrated need.

## Host and legacy audit

Wget is installed. No `.wgetrc`, XDG config, or legacy Wget policy was found.

## Configuration ownership

Homebrew owns installation. If required, Zsh may set `WGETRC=$XDG_CONFIG_HOME/wget/wgetrc` and Stow may own that file. Credentials, cookies, proxy secrets, `.netrc`, downloaded content, logs, and mirror state remain local.

## Integration notes

Overlaps with curl and xh. Do not alias one over another; their flags and behavior differ. Honor proxy environment variables and avoid colors in automation. Vesper is not applicable.

## Open decisions

- Whether any global wgetrc is justified; omission is the current default.

## Sources

- [GNU Wget 1.25 manual](https://www.gnu.org/software/wget/manual/wget.html)
- [Homebrew formula](https://formulae.brew.sh/formula/wget)
- Researched 2026-07-13.
