# Dotfiles Tracker

This is the working source of truth for the new dotfiles setup. It records approved decisions and tracks each component before implementation. Legacy files are reference material only; nothing is carried forward without review.

Repository-wide policy lives in the [setup contract](setup-contract.md). Visual configuration uses the canonical [Vesper palette](vesper-palette.md).

> [!IMPORTANT]
> **Theme direction: Vesper.** New and rebuilt configuration should use the Vesper palette consistently. Existing Rose Pine and Catppuccin settings are references, not defaults for the gold setup.

## Audit queue

- [ ] Starship
- [ ] Alacritty
- [ ] Ghostty
- [ ] Neovim
- [ ] Git
- [ ] Tmux
- [ ] Herdr
- [ ] Atuin
- [ ] Yazi
- [ ] Lazygit
- [ ] GitHub CLI (`gh`)
- [ ] Direnv
- [ ] Bat
- [ ] Ripgrep (`rg`)
- [ ] Homebrew
- [ ] Visual Studio Code
- [ ] Pi
- [ ] OpenCode
- [ ] FZF
- [ ] Gum
- [ ] GNU Stow
- [ ] Sesh
- [ ] Lazydocker
- [ ] Btop
- [ ] K9s
- [ ] gh-dash
- [ ] Glow
- [ ] Vimium
- [ ] Raycast
- [ ] lnav
- [ ] uv
- [ ] fd
- [ ] jq
- [ ] fx
- [ ] xh
- [ ] Logdy
- [ ] FFmpeg
- [ ] pnpm
- [ ] Wget
- [ ] Speedtest
- [ ] Obsidian
- [ ] Google Chrome
- [ ] Stats
- [ ] CleanShot X
- [ ] Homerow
- [ ] Discord
- [ ] Dashlane
- [ ] Proton VPN
- [ ] ChatGPT
- [ ] Orca
- [ ] Supacode
- [ ] Bazecor
- [ ] Vial
- [ ] Logi Options+
- [ ] Capture One
- [ ] DaVinci Resolve
- [ ] Darkroom
- [ ] Photomator
- [ ] ON1 Photo RAW
- [ ] Alcove
- [ ] Antinote
- [ ] FluidVoice
- [ ] Plaud
- [ ] Ollama

## Installed application reference

The following applications were found on the current Mac but are not part of the active audit queue. This is a reference inventory for possible later review, not part of the critical path for rebuilding the dotfiles setup.

- AppCleaner
- CapCut
- Copilot
- DockDoor
- Flighty
- GitButler
- IINA
- LM Studio
- Luminar AI
- Luminar Neo
- OrbStack
- Podman Desktop
- Shottr
- Spokenly
- Todoist
- TurboTax 2025
- TypeWhisper
- balenaEtcher
- cmux
- iMovie

Supporting helpers, updater payloads, rollback copies, uninstallers, and duplicate variants such as ChatGPT Classic are intentionally excluded from this reference list.

## Zsh

**Status:** Structure approved; contents and plugin policy still under review.

- [x] Use the XDG Zsh layout at `~/.config/zsh`.
- [x] Set `ZDOTDIR` from `/etc/zshenv`.
- [x] Do not maintain a `~/.zshenv` bootstrap shim.
- [x] Stow durable configuration from `zsh/.config/zsh/`.
- [x] Keep caches, history, runtime state, and plugin clones outside the repo.
- [x] Split aliases, functions, bindings, FZF, plugins, and prompt configuration.
- [x] Research lightweight plugin-manager options.
- [x] Use Homebrew-installed Antidote with static plugin loading.
- [ ] Audit Eza integration.
- [ ] Audit Zoxide integration.
- [ ] Audit Vivid integration.
- [ ] Audit Zsh Vi Mode integration.
- [ ] Finalize the plugin list.
- [ ] Review live and reference configuration file by file.
- [ ] Define the exact load order.
- [ ] Create and verify the clean Zsh package.

### Environment variables

`/etc/zshenv` provides the bootstrap required for Zsh to find the XDG configuration:

```zsh
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
```

The path is confirmed by the [Zsh startup-file documentation](https://zsh.sourceforge.io/Doc/Release/Files.html) and the macOS-provided `/bin/zsh`. The bootstrap stays minimal because `/etc/zshenv` is read by every Zsh invocation.

The tracked `.zshenv` owns the portable XDG base directories:

```zsh
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
```

Environment rules:

- `.zshenv` must remain quiet and safe for non-interactive shells.
- Universal, portable variables belong in `.zshenv`.
- Login-only `PATH` and toolchain setup belongs in `.zprofile`.
- Interactive initialization belongs in `.zshrc` or its sourced modules.
- Secrets and machine-specific values remain untracked.

### File structure

```text
zsh/
└── .config/
    └── zsh/
        ├── .zshenv
        ├── .zprofile
        ├── .zshrc
        ├── aliases.zsh
        ├── bindings.zsh
        ├── functions.zsh
        ├── fzf.zsh
        ├── plugins.zsh
        └── prompt.zsh
```

GNU Stow deploys this package as symlinks under `~/.config/zsh/`.

Mutable supporting data stays outside the package:

```text
~/.cache/zsh/          # generated caches
~/.local/share/zsh/    # external plugin clones, if used
~/.local/state/zsh/    # history and mutable state
```

### Plugin management

**Status:** Antidote with static loading is selected. It will be installed through Homebrew and evaluated during implementation.

The manager should:

- Manage only a small, intentional plugin list.
- Add negligible warm-start overhead.
- Keep the plugin declaration in Git.
- Keep downloaded repositories outside the Stow package under an appropriate XDG data or cache directory.
- Keep generated loading files under `$XDG_CACHE_HOME`.
- Be installed and updated explicitly during bootstrap or maintenance.
- Never access the network during normal shell startup.
- Preserve explicit plugin load order, especially for syntax highlighting and bindings.

#### Options researched

Research snapshot: 2026-07-13.

| Option | Fit for this setup | Tradeoff |
|---|---|---|
| [Antidote](https://github.com/mattmc3/antidote) | **Selected.** Zsh-native, available through Homebrew, uses a small `.zsh_plugins.txt` manifest, and supports generating a static load file for fast startup. | Introduces a manager plus generated bundle; plugin updates and bundle regeneration need an explicit workflow. |
| [Znap](https://github.com/marlonrichert/zsh-snap) | Lightweight Zsh-native manager with simple `znap source` declarations and compilation/startup optimization features. | Its documented quick start auto-clones from `.zshrc`; we would need to move installation into bootstrap to preserve the no-network-at-startup rule. |
| [Sheldon](https://github.com/rossmacarthur/sheldon) | Fast Rust implementation, Homebrew-installable, XDG-aware TOML manifest, parallel installation, and lock support. | Adds a compiled external binary and a separate configuration format for only a handful of Zsh plugins. |
| [Zinit](https://github.com/zdharma-continuum/zinit) | Mature and highly capable, with deferred “Turbo” loading and detailed plugin controls. | Its feature set and configuration language are more complex than this minimal setup requires. |
| Manual clones and sourcing | Smallest runtime surface and explicitly recommended by the `zsh-syntax-highlighting` maintainers. | Bootstrap, updates, pinning, paths, and load order become our own maintenance code. |

Community adoption and active maintenance make Antidote, Znap, Sheldon, and Zinit credible current choices. Popularity alone is not the decision criterion; simplicity, deterministic startup, XDG compatibility, and measured startup time matter more here.

#### Selected option

Use **Antidote with static loading** as the selected design:

```text
~/.config/zsh/.zsh_plugins.txt  # tracked plugin manifest
/opt/homebrew/opt/antidote/     # Homebrew-managed plugin manager
~/.cache/antidote/              # disposable plugin clones
~/.cache/zsh/plugins.zsh        # generated static loading file
```

Bootstrap would install Antidote and fetch plugins. Interactive startup would source only the already-generated static loading file. Updates would be an explicit command, never an automatic shell-start side effect.

Before approval, benchmark a representative plugin list against direct manual sourcing and confirm that required load-order hooks remain clear.
