# Sesh

## Role

Discover, create, switch, and preview Tmux sessions from live sessions, curated projects, and Zoxide's frecency database.

## Recommendation

Retain as the lightweight generic Tmux session picker. Replace the machine-specific legacy session catalog with defaults plus a few portable entries, and use one maintained picker path rather than duplicating long FZF expressions across bindings.

## Modern baseline

Sesh integrates Tmux sessions, configured sessions, Zoxide paths, and finders; its documented Tmux/FZF pattern supports filtered views and previews. Current Sesh also has a built-in TUI, so prefer it when it meets needs and reserve custom FZF integration for capabilities it lacks. Config belongs at XDG config.

## Host and legacy audit

Homebrew Sesh 2.26.2 is installed. Legacy `sesh.toml` has good sort order, icons, two-component names, and an `eza` preview, but hardcodes an outdated `~/projects` hierarchy and verbose curated sessions. Legacy Tmux duplicates a long Sesh/FZF command in multiple bindings.

## Configuration ownership

Track `sesh/.config/sesh/sesh.toml` with portable defaults and only stable paths, plus one Tmux integration snippet. Install Sesh, Tmux, Zoxide, FZF, fd, and Eza through Homebrew. Live sessions, sockets, recency/frequency databases, last-session state, previews, and host-specific project roots remain local.

## Integration notes

Tmux owns session persistence; Sesh owns discovery/switching; Zoxide supplies frecency; FZF or Sesh TUI supplies selection. Herdr owns specialized multi-agent/worktree orchestration and should not replace Sesh for ordinary projects unless testing proves it can simplify the stack.

## Open decisions

- Built-in Sesh TUI versus custom FZF popup.
- Portable project roots or zero curated paths initially.
- One conflict-free Tmux/Zsh launch binding.

## Sources

- [Sesh repository](https://github.com/joshmedeski/sesh)
- [Sesh package documentation](https://pkg.go.dev/github.com/joshmedeski/sesh)
- [Recent Tmux/Sesh community workflow](https://www.reddit.com/r/tmux/comments/1q12fz7/my_setup_and_why_tmux_workflow_is_better_than_ever/)
- Researched 2026-07-13.
