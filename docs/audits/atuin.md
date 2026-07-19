# Atuin

## Role

Replace flat shell history search with structured, fast, context-aware history and optional encrypted cross-machine synchronization.

## Recommendation

Retain. Start with local history and deliberate filters; enable hosted sync only after deciding recovery and privacy policy. Use the official Zsh integration without taking over unrelated bindings.

## Modern baseline

Atuin keeps durable config in `~/.config/atuin` and mutable database, key, and session token under XDG data by default. Sync is end-to-end encrypted, but the encryption key is essential for recovery and must be stored securely outside dotfiles. Current 18.13 supports daemon-backed fuzzy search, but a resident daemon is optional complexity.

## Host and legacy audit

Atuin 18.13.6 is installed via its own `~/.atuin/bin` path rather than Homebrew, with an XDG config. The legacy file is largely the generated full reference plus a Catppuccin theme; this should be replaced by a short override-only file. Existing database, key, token, and history were not inspected.

## Configuration ownership

Track only `atuin/.config/atuin/config.toml` and a Vesper theme if necessary. Bootstrap installs Atuin and initializes shell integration. Database, history, encryption key, auth session, sync account, cache, and host/session metadata remain local; back up the key through the password manager.

## Integration notes

Atuin owns interactive history search, so avoid overlapping FZF Ctrl-R bindings. Load its Zsh init after basic keymap selection and verify compatibility with zsh-vi-mode. Sesh may consume directory frecency from Zoxide, not Atuin.

## Open decisions

- Local-only, Atuin-hosted encrypted sync, or self-hosted sync.
- Whether daemon-fuzzy yields enough benefit to run a daemon.
- Search/filter defaults: workspace/directory context versus global recall.

## Sources

- [Atuin configuration](https://docs.atuin.sh/cli/configuration/config/)
- [Atuin sync](https://docs.atuin.sh/cli/guide/sync/)
- [Atuin shell setup](https://docs.atuin.sh/cli/guide/shell-integration/)
- [Atuin dotfiles](https://docs.atuin.sh/cli/guide/dotfiles/)
- Researched 2026-07-13.
