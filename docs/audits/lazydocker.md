# Lazydocker

## Role

Provide an optional TUI for inspecting containers, logs, images, volumes, and Compose services during local development.

## Recommendation

Retain, but keep it secondary to normal `docker`/`podman` commands and Lazygit-style workflows. Install with Homebrew; start from upstream defaults and add only portable behavior proven useful.

## Modern baseline

Lazydocker supports Docker-compatible runtimes, custom commands, log presentation, and an XDG-aware user configuration. Community use is strongest as an interactive troubleshooting layer, not an automation interface. Prefer explicit CLI commands in scripts and documentation.

## Host and legacy audit

The Homebrew formula is installed. `dotfiles-legacy/lazydocker/config.yml` exists but is empty, so there is no behavior to preserve.

## Configuration ownership

Homebrew owns installation. A future non-empty portable config may live under `~/.config/lazydocker/config.yml` via Stow. Docker contexts, sockets, credentials, container state, logs, and project-specific Compose data remain local.

## Integration notes

Overlaps with Docker/Podman Desktop and direct CLI use. It has a visual TUI, so any future custom theme should use Vesper terminal colors and remain legible in both Ghostty and Alacritty.

## Open decisions

- Retain only if container work remains frequent enough to justify a second interface.
- Decide whether Docker or Podman/OrbStack is the supported local runtime before adding runtime-specific commands.

## Sources

- [Lazydocker repository and configuration](https://github.com/jesseduffield/lazydocker)
- [Homebrew formula](https://formulae.brew.sh/formula/lazydocker)
- [Community discussion: container TUIs](https://www.reddit.com/r/docker/search/?q=lazydocker&restrict_sr=1&sort=top)
- Researched 2026-07-13.
