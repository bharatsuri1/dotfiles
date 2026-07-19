# Herdr

## Role

Manage persistent terminal workspaces, Git worktrees, and multiple AI coding-agent panes from one interface.

## Recommendation

Retain for evaluation because it directly supports the intended agent-heavy Tmux workflow. Keep the initial config nearly default: Vesper theme when available and only proven key changes. Do not let it duplicate Sesh's general project/session role without a clear boundary.

## Modern baseline

The installed CLI exposes persistent server/client sessions, named sessions, SSH attachment, worktree/workspace helpers, agent integrations, stable/preview channels, and `HERDR_CONFIG_PATH`. Its own default-config output should be treated as the authoritative schema. The product site is the primary public reference; community evidence is still limited compared with mature terminal tools.

## Host and legacy audit

Herdr is installed in `~/.local/bin`, with `~/.config/herdr/config.toml`. Current durable settings are only an all-agent panel scope and Rosé Pine theme. Logs live beside the config and must not enter Git. No legacy repository package exists.

## Configuration ownership

Track only reviewed durable preferences at `herdr/.config/herdr/config.toml`. Bootstrap owns installation and update-channel selection. Logs, API sockets, sessions, workspace/worktree state, agent transcripts, notifications, update metadata, and remote targets remain local.

## Integration notes

Define Herdr as the specialized multi-agent/worktree layer; Tmux provides terminal persistence, while Sesh remains the lightweight generic session picker. Replace Rosé Pine with Vesper only if Herdr supports it; otherwise use the nearest neutral built-in theme rather than vendoring a fragile approximation.

## Open decisions

- Whether Herdr earns a permanent place after a real project trial.
- Stable versus preview update channel.
- Boundary with Sesh and direct Tmux workflows.

## Sources

- [Herdr](https://herdr.dev/)
- Local `herdr --help` and `herdr --default-config`, inspected 2026-07-13.
- Researched 2026-07-13; public documentation/community coverage is limited.
