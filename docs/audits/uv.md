# uv

## Role

Own modern Python version, environment, dependency, tool, and script workflows.

## Recommendation

Adopt as the default Python workflow and retain the installed binary. Prefer project-local `pyproject.toml`/`uv.lock`; keep global configuration sparse.

## Modern baseline

uv supports user, project, and system configuration, lockfiles, inline script metadata, tool execution, and managed Python. Official storage guidance places cache in `$XDG_CACHE_HOME/uv` and recommends cache and virtual environments share a filesystem for efficient linking. Do not globally override project reproducibility.

## Host and legacy audit

uv is installed. The live `~/.config/uv/uv-receipt.json` is installation metadata, not user policy, and should not be preserved. No durable legacy configuration was found.

## Configuration ownership

Bootstrap/Homebrew owns installation. Dotfiles may own `~/.config/uv/uv.toml` only for genuinely global policy. Projects own `pyproject.toml`, `.python-version`, and `uv.lock`. Caches, managed interpreters, environments, tool installs, credentials, and receipts remain local.

## Integration notes

Coordinate PATH with Zsh and avoid competing Python managers unless a project requires one. `direnv` may activate project environments but should not duplicate uv's dependency resolution. Vesper is not applicable.

## Open decisions

- Homebrew versus Astral installer as the bootstrap authority.
- Whether any global index policy is needed; credentials must never be tracked.

## Sources

- [uv configuration files](https://docs.astral.sh/uv/configuration/files/)
- [uv storage](https://docs.astral.sh/uv/reference/storage/)
- [uv projects](https://docs.astral.sh/uv/guides/projects/)
- Researched 2026-07-13.
