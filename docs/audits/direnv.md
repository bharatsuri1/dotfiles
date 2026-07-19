# Direnv

## Role

Load and unload project-specific development environments automatically and transparently when changing directories.

## Recommendation

Retain. Keep the global config minimal, use explicit per-project `.envrc` files, and require manual review plus `direnv allow`. Do not globally auto-load arbitrary `.env` files.

## Modern baseline

Direnv's security model hashes authorized `.envrc` content and blocks changed files until re-approved. The Zsh hook must be loaded after prompt initialization guidance is considered so environment changes render correctly. Its stdlib supports composable project environments; secrets should come from ignored local files or a secret manager, not committed `.envrc` content.

## Host and legacy audit

Homebrew Direnv 2.37.1 is installed with an XDG config. Legacy `direnv.toml` only hides environment diffs. That reduces noise but can conceal important changes, so it should be retained only if prompt/status feedback remains clear.

## Configuration ownership

Track `direnv/.config/direnv/direnv.toml` only for global durable policy. Project `.envrc` belongs in each project repository when non-secret. Approval records, caches, loaded environment state, `.env` secrets, and local overrides remain untracked.

## Integration notes

Initialize once in interactive Zsh; Starship may show loaded/denied state. Coordinate with uv and language version managers rather than stacking redundant activation hooks. Treat every new `.envrc` as executable code during review.

## Open decisions

- Keep `hide_env_diff = true` or prefer visible diffs during the initial clean setup.

## Sources

- [Direnv documentation](https://direnv.net/)
- [Direnv hook](https://direnv.net/docs/hook.html)
- [Direnv security](https://direnv.net/man/direnv.1.html#SECURITY)
- [Direnv stdlib](https://direnv.net/man/direnv-stdlib.1.html)
- [Community security discussion](https://www.reddit.com/r/programming/comments/renify/tools_you_should_know_about_direnv/)
- Researched 2026-07-13.
