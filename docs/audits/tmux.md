# Tmux

## Role

Provide persistent terminal sessions, remote resilience, panes/windows, and a shared workspace substrate for Sesh and terminal coding agents.

## Recommendation

Retain, but reduce the legacy configuration substantially. Keep core ergonomics, vi copy mode, current-directory splits, clipboard support, true color, and Sesh entry points. Minimize plugins and avoid automatic session restoration until its behavior is explicitly wanted.

## Modern baseline

Homebrew is the official documented macOS installation route. Tmux reads `~/.tmux.conf`; use a small home bootstrap or launch with `-f ~/.config/tmux/tmux.conf` if strict XDG ownership is required. Current releases support extended keys and terminal feature detection; verify effective capabilities rather than accumulating broad terminal overrides. Plugins are optional, not baseline.

## Host and legacy audit

Homebrew Tmux 3.7b is installed. The legacy config contains a mature workflow but is large: prefix-free Meta bindings, several popups, custom AI scripts, Sesh/FZF integration, battery/CPU status processes, TPM with nine plugins, and resurrect/continuum. Preserve the navigation model only after checking collisions; replace Rosé Pine with Vesper and discard cosmetic/status complexity by default.

## Configuration ownership

Track `tmux/.config/tmux/tmux.conf` and reviewed helper scripts. Bootstrap installs Tmux and explicitly installs/pins any approved plugins. Sockets, server state, resurrect snapshots, logs, pane content, and project/session state remain local.

## Integration notes

Ghostty/Alacritty own rendering; Tmux owns persistent multiplexing; Sesh owns discovery. Align Meta/Option, CSI-u/extended-key, clipboard/OSC 52, and Neovim navigation behavior. Every status command affects responsiveness and should be justified.

## Open decisions

- XDG startup strategy: tiny `~/.tmux.conf` source file versus an alias/wrapper using `-f`.
- Exact plugin set; likely start with none or only TPM plus one proven need.
- Whether persistence/restoration is desirable.

## Sources

- [Tmux getting started](https://github.com/tmux/tmux/wiki/Getting-Started)
- [Tmux macOS installation](https://github.com/tmux/tmux/wiki/Installing)
- [Tmux manual](https://man.openbsd.org/tmux)
- [Tmux FAQ](https://github.com/tmux/tmux/wiki/FAQ)
- Researched 2026-07-13.
