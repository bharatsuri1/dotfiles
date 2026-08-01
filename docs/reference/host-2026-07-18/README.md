# Current-host Reference — 2026-07-18

This directory preserves the point-in-time host evidence used during the
dotfiles rebuild audit. It is reference material only and is not consumed by the
turnkey installer.

## Contents

- `Brewfile.reference` is the raw `brew bundle dump` shape captured during the
  audit. It includes tools, extensions and packages that have not necessarily
  been approved for the rebuilt setup.
- `formulae.txt` is the installed formula inventory and includes transitive
  dependencies.
- `casks.txt` is the Homebrew-managed cask inventory. It is not a complete list
  of applications installed through other channels.
- `managed-live-paths.txt` lists portable-looking configuration paths observed
  on the host. It contains paths only, not their contents.

## Safety and use

- No credentials, tokens, application databases, histories or machine IDs are
  included.
- User-specific absolute paths have not been retained.
- The active `dotfiles-macos/Brewfile` remains the reviewed installation source.
- Future snapshots should use a new dated directory instead of rewriting this
  historical evidence.
