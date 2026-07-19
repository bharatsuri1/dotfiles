# GitHub CLI (`gh`)

## Role

Provide the authenticated command-line interface for GitHub repositories, pull requests, issues, releases, workflows, and automation.

## Recommendation

Retain. Use browser-based login with macOS credential storage for interactive use, SSH Git protocol if selected in the Git audit, Neovim as editor, and a very small alias set. Keep tokens and host/account records out of Git.

## Modern baseline

`gh auth login` uses a secure credential store when available; environment tokens are intended for headless automation and override stored credentials. `GH_CONFIG_DIR` controls config location. Extensions are executable code and should be individually reviewed and installed declaratively rather than restored from a host dump.

## Host and legacy audit

Homebrew `gh` 2.96.0 is installed. Legacy `config.yml` sets SSH protocol, Neovim, prompts, and one `co: pr checkout` alias. These are portable preferences. Authentication host files were not read and must not be tracked.

## Configuration ownership

Track a sanitized `gh/.config/gh/config.yml` only if stable preferences justify it; aliases can alternatively live in bootstrap commands. Bootstrap installs approved extensions. Credentials, `hosts.yml`, tokens, account/hostname details, caches, and command output remain local.

## Integration notes

Git owns transport, identity, signing, editor, and pager policy. `gh-dash` is a separate TUI audit. Lazygit handles local repository manipulation; `gh` handles GitHub-specific server operations.

## Open decisions

- Whether the tiny portable config is worth stowing versus applying with `gh config set`.
- Final reviewed extension list.

## Sources

- [GitHub CLI manual](https://cli.github.com/manual/)
- [`gh auth login`](https://cli.github.com/manual/gh_auth_login)
- [GitHub CLI environment variables](https://cli.github.com/manual/gh_help_environment)
- [GitHub CLI extensions](https://cli.github.com/manual/gh_extension)
- Researched 2026-07-13.
