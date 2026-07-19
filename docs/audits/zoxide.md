# Zoxide

## Role

Provide frecency-based directory navigation across interactive shells and feed directory history to tools such as Sesh and Yazi.

## Recommendation

Retain Zoxide through Homebrew and initialize it once from the interactive Zsh configuration. Prefer its dedicated `z` and `zi` commands initially instead of aliasing `cd`; this preserves predictable shell semantics and avoids requiring every function to use `builtin cd`.

## Modern baseline

Zoxide supports XDG data storage, multiple shells and an optional interactive selector. Initialization should occur only in interactive shells. Its database is behavioral state, not configuration, and should never be committed. If `zi` is enabled, use the existing FZF stack rather than introducing another selector.

## Host and legacy audit

Zoxide 0.10.0 is installed at `/opt/homebrew/bin/zoxide`. Legacy configuration cached generated init output, aliased `cd` to `z`, required defensive `builtin cd` calls, and used Zoxide from Yazi and Sesh. Retain the cross-tool integration, but first measure whether direct `zoxide init zsh` is expensive enough to justify generated caching. The `cd` replacement is not approved.

## Configuration ownership

Track the Zsh initialization and any aliases in the Zsh package, the Yazi plugin binding in Yazi configuration, and Zoxide-backed sources in Sesh configuration. Keep the frecency database in the tool's XDG data location and out of Git, backups and machine bootstrap fixtures.

## Integration notes

Sesh can combine configured sessions with Zoxide results. Yazi can jump through Zoxide. Atuin owns command history; Zoxide owns directory frecency. FZF styling should come from the shared Vesper configuration.

## Open decisions

- Keep explicit `z`/`zi` commands or intentionally replace interactive `cd`.
- Direct initialization versus a generated cache, decided by measurement.

## Sources

- [Zoxide repository and shell setup](https://github.com/ajeetdsouza/zoxide)
- [Homebrew Zoxide formula](https://formulae.brew.sh/formula/zoxide)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/)
- Local host, legacy Zsh, Yazi and Sesh audit, 2026-07-13.
