# Known Things — Dotfiles Laptop-Switch Inventory

> Historical reference captured during the pre-implementation audit. This is intentionally broad and non-final; current decisions live in the repository trackers and setup contract.

## 0. Current stance

- We are reviewing, researching, and planning before changing actual setup.
- The goal is not to mirror all of `$HOME`.
- The goal is a focused, intentional dotfiles repo that makes a new laptop productive quickly.
- Keep high-impact setup in the repo.
- Keep auth, runtime state, caches, and app databases out of the repo.
- Public repo means every tracked file must be safe to publish.

## 1. Repo facts

- Repo path now: `~/Code/personal/dotfiles`.
- Git remote: `https://github.com/bharatsuri1/dotfiles`.
- GitHub visibility: public.
- Branch: `main`.
- Top-level `README.md` is basically empty.
- `docs/stow-migration-plan.md` exists and is directionally useful.
- Current package layout is flat, not Stow tree-mirror.
- There is no root `.stowrc` yet.
- No live configs checked so far are symlinked back into this repo.
- `plans/` was the ignored working planning space during this audit.
- `.scratchpad/` remains ignored scratch/research space.
- `.pi/` is partially tracked for Pi settings, while npm dependencies are ignored.

## 2. Chosen direction already implied by existing work

- Use GNU Stow eventually.
- Use tree-mirror package layout targeting `$HOME`.
- Add `.stowrc` only when the first package is actually migrated.
- Intended `.stowrc` contents:
  - `--target=$HOME`
  - `--no-folding`
- Do not run `stow` against current flat package dirs.
- Migrate package-by-package, not all at once.
- Use explicit package allowlist, never `stow */`.
- Keep local/machine overrides ignored.
- Guarded local include convention is desired but not implemented everywhere yet.

## 3. Reference repo research

### `radleylewis/zsh`

- Minimal, focused zsh repo.
- Strong README structure: dependencies, setup, plugins, keybindings.
- Uses `ZDOTDIR=~/.config/zsh`.
- Has modular files:
  - `.zshenv`
  - `.zshrc`
  - `aliases.zsh`
  - `bindings.zsh`
  - `plugins.zsh`
  - `fzf.zsh`
  - `prompt.zsh`
  - `starship.toml`
- Has a tiny built-in plugin manager that auto-clones plugins on first shell startup.
- Good reference for documentation clarity and focused shell organization.
- Not necessarily a direct model for us because our current live zsh uses standard `~/.zshrc`, `~/.zshenv`, `~/.zprofile` and is already tuned.

### `radleylewis/dotfiles`

- Uses bare Git repo with `$HOME` as work tree.
- Uses submodules for larger components like zsh/nvim/qtile.
- Directly owns home paths.
- Good reference for home-tree ownership and README setup flow.
- Less aligned with our preferred safer Stow package model.

## 4. Current live shell setup

- Default shell is `/bin/zsh`.
- `~/.zshrc`, `~/.zshenv`, and `~/.zprofile` are real files.
- Live zsh is the tuned post-Oh-My-Zsh setup.
- Repo `zsh/.zshrc` is stale Oh-My-Zsh-era config.
- Live zsh startup is fast: around 47–57ms warm in quick samples.
- Live zsh has a startup timing header.
- Live zsh uses lazy caches for several tools.
- Live zsh uses Homebrew `zsh-vi-mode`.
- Live zsh uses manually cloned plugins:
  - `~/.config/zsh/plugins/zsh-autosuggestions`
  - `~/.config/zsh/plugins/zsh-syntax-highlighting`
- Live zsh has custom completions:
  - `~/.config/zsh/completions/_cargo`
  - `~/.config/zsh/completions/_rustup`
- Live zsh aliases `cd` to zoxide `z`.
- Live zsh uses Atuin, Starship, Direnv, Zoxide, FZF, Vivid, Eza, Yazi.
- Live `.zshenv` is intentionally minimal and XDG-focused.
- Live `.zprofile` handles Homebrew, Cargo, OrbStack.
- Live zsh does not currently include guarded local files like `~/.zshrc.local`.
- Running `zsh -i -c exit` in non-TTY automation prints `can't change option: zle` warnings from Homebrew fzf scripts.
- Actual terminal behavior may be fine, but automation cleanliness may need a TTY/ZLE guard.

## 5. Shell cleanup candidates

- `~/.oh-my-zsh` still exists but live zsh no longer uses OMZ.
- `~/.fzf.zsh` still exists from older fzf setup.
- Old backup files still exist:
  - `.zshrc.backup.*`
  - `.zshenv.backup.*`
  - `.zprofile.backup.*`
- Runtime zsh files should remain untracked:
  - `.zsh_history`
  - `.zsh_sessions/`
  - `.zcompdump`
  - `.zshrc.zwc`

## 6. Bash/profile facts

- `~/.bash_profile` and `~/.profile` exist.
- They contain installer-added PATH snippets and hardcoded user-home paths.
- They include LM Studio, GitButler, Antigravity, SDKMAN, Cargo, and Atuin snippets.
- If zsh is the laptop standard, do not migrate these wholesale.
- Only keep a minimal `.profile` if needed for non-zsh login contexts.

## 7. Git setup facts

- `~/.gitconfig` is a real file.
- It contains a public name/email identity; the exact identity is intentionally omitted from this reference snapshot.
- Repo has `git/ignore` matching live `~/.config/git/ignore`.
- Future tracked Git config should probably include guarded local override support via `~/.gitconfig.local`.
- Need decide whether public identity is tracked directly or kept local-only.

## 8. Terminal facts

### Ghostty

- Repo `ghostty/config` matches live `~/.config/ghostty/config`.
- Ghostty app exists in `/Applications`.
- `ghostty` command is not on PATH.
- Ghostty appears to be the likely primary terminal.

### Alacritty

- Repo main `alacritty/alacritty.toml` matches live main config.
- Alacritty app exists in `/Applications`.
- `alacritty` command is not on PATH.
- Live theme path is `~/.config/alacritty/themes/rose-pine.toml`.
- Repo theme file is currently at `alacritty/rose-pine.toml`, and it differs from live theme.
- Alacritty may be backup/reference if Ghostty is primary.

## 9. Prompt facts

- Repo `starship/starship.toml` differs significantly from live `~/.config/starship.toml`.
- Repo Starship is intentionally minimal and latency-bounded.
- Live Starship looks broader and more symbol-heavy.
- Do not blindly apply “live wins” here.
- Need decide prompt philosophy:
  - minimal/fast/predictable, or
  - richer module/symbol preset.

## 10. Tmux facts

- Repo `tmux/tmux.conf` differs from live `~/.config/tmux/tmux.conf`.
- Repo `tmux/scripts/ai-picker.sh` matches live.
- Live tmux has meaningful improvements:
  - Sesh section cleanup/reordering.
  - Better git/current path status commands.
  - Copy/scroll/mouse UX additions.
- Live tmux likely deserves line-by-line adoption.
- Live tmux uses TPM plugins under `~/.config/tmux/plugins/`.
- TPM plugin dir must remain unmanaged/untracked.
- `tmux` command is installed.
- Tmux config syntax checks passed when using a temporary tmux server.

## 11. Neovim facts

- Repo `nvim/` is no longer a nested Git repo.
- Live `~/.config/nvim` has drift from repo.
- Drift includes:
  - `lazy-lock.json`
  - `lazyvim.json`
  - `lua/config/keymaps.lua`
  - `lua/config/lazy.lua`
  - `lua/plugins/rose-pine.lua`
- Live keymaps are much richer than tracked keymaps.
- Tracked `nvim/README.md` is still the default LazyVim starter README.
- Neovim should probably be a core package, but it needs intentional review rather than blind adopt.

## 12. Editor facts

### VS Code

- VS Code app exists in `/Applications`.
- `code` CLI exists at `/usr/local/bin/code`.
- `code --list-extensions` works.
- Repo `vscode/keybindings.json` matches live.
- Repo `vscode/settings.json` differs from live.
- VS Code settings/keybindings live under macOS Library path:
  - `~/Library/Application Support/Code/User/settings.json`
  - `~/Library/Application Support/Code/User/keybindings.json`
- VS Code keybindings are JSONC, not strict JSON.
- Scratch Brewfile captured VS Code extensions.

### Cursor

- Cursor User settings exist under:
  - `~/Library/Application Support/Cursor/User/settings.json`
  - `~/Library/Application Support/Cursor/User/keybindings.json`
- Cursor app was not visible in `/Applications` snapshot.
- `cursor` CLI is not on PATH.
- Repo Cursor settings and keybindings differ from live.
- Repo has Cursor command docs and `cli-config.json`, but no obvious matching live path was found.
- Treat Cursor as stale/unverified until actual usage/app path is confirmed.

## 13. AI/dev-agent tool facts

### Claude

- Repo `claude/settings.json` is rich and references `~/.claude/statusline-command.sh`.
- Repo `claude/statusline-command.sh` exists and is executable.
- Live `~/.claude/settings.json` is tiny and only contains empty hooks.
- Live `~/.claude/statusline-command.sh` is absent.
- Need decide desired Claude Code setup before stowing.
- Do not track `.claude.json` because it appears to contain sensitive state.

### OpenCode

- Live `~/.config/opencode/opencode.jsonc` is minimal and portable-looking.
- Live OpenCode commands exist:
  - `devcontainer.md`
  - `workspaces.md`
  - `worktree.md`
- Live Supacode presence plugin is generated and should probably be regenerated/documented, not hand-maintained unless intentionally chosen.
- OpenCode may be a candidate package later.

### Codex/Gemini/Supacode

- Live Codex/Gemini dirs contain auth/state/history.
- `~/.codex/auth.json` appears sensitive.
- `~/.gemini/oauth_creds.json` appears sensitive.
- `~/.supacode/settings.json` tripped secret-keyword scan.
- These should not be tracked blindly.

## 14. CLI/TUI config facts

### In sync or mostly in sync

- `atuin` repo config matches live.
- `cmux` repo config matches live.
- `direnv` repo config matches live.
- `gh` repo config matches live.
- `gh-dash` repo config matches live.
- `ghostty` repo config matches live.
- `git/ignore` repo config matches live.
- `glow` repo config matches live.
- `k9s` repo config matches live.
- `lazygit` repo config matches live.
- `tmux/scripts/ai-picker.sh` matches live.

### Drifted

- `btop/btop.conf` differs from live.
- `television/config.toml` differs slightly from live.
- `vimium/vimium-options.json` differs slightly from live.
- `yazi/keymap.toml` differs slightly from live.
- `yazi/yazi.toml` differs from live.
- Yazi flavors appear to match live.

### Present in repo but absent/not deployed live

- `bat`
- `htop`
- `lazydocker`
- `sesh`
- `claude/statusline-command.sh`

## 15. Tool command availability facts

Installed/found commands include:

- `stow`
- `git`
- `zsh`
- `brew`
- `nvim`
- `tmux`
- `starship`
- `direnv`
- `atuin`
- `zoxide`
- `vivid`
- `fzf`
- `fd`
- `rg`
- `eza`
- `bat`
- `yazi`
- `lazygit`
- `lazydocker`
- `gh`
- `k9s`
- `sesh`
- `btop`
- `htop`
- `jq`
- `gum`

Notable command-name or availability caveats:

- `television` formula installs executable `tv`.
- `gh-dash` is installed as `gh dash` extension, not a standalone command.
- `cmux` app exists but `cmux` command was not found.
- `ghostty` app exists but `ghostty` command was not found.
- `alacritty` app exists but `alacritty` command was not found.
- `cursor` command was not found.

## 16. Homebrew facts

- Current `brew/list.txt` is a raw formula inventory with many dependencies.
- Current `brew/list.txt` drifts from installed packages.
- `brew leaves` is a better starting point for intentional bootstrap.
- `brew bundle dump` in scratch produced a better structure:
  - taps
  - formulae
  - casks
  - VS Code extensions
  - cargo package
  - npm package
- Current taps:
  - `gromgit/brewtils`
  - `olets/tap`
  - `teamookla/speedtest`
- Current casks from Homebrew:
  - `font-symbols-only-nerd-font`
  - `stats`
- This cask list is incomplete compared to actual apps in `/Applications`.
- Future direction is likely curated `brew/Brewfile` instead of raw `brew/list.txt`.

## 17. GUI app facts

Apps observed in `/Applications` include many important tools not captured by current Homebrew casks:

- Alacritty
- Ghostty
- cmux
- Claude Code URL Handler
- CleanShot X
- Copilot
- Dashlane
- Discord
- GitButler
- Google Chrome
- Homerow
- IINA
- LM Studio
- Obsidian
- Ollama
- OpenCode
- OrbStack
- Podman Desktop
- Raycast
- Shottr
- Stats
- supacode
- Todoist
- Visual Studio Code
- And many photography/media apps

Need decide which of these are bootstrap-critical versus manual install/licensed apps.

## 18. Raycast facts

- Repo has `raycast/extensions.md` as a manifest, not a stow target.
- Live Raycast extension set appears broader than tracked manifest.
- Live candidates include:
  - Apple Notes
  - Apple Reminders
  - CleanShot X
  - Coffee
  - Color Picker
  - Flighty
  - GitHub
  - Google Chrome
  - Google Meet
  - Google Search
  - Google Workspace
  - Kill Process
  - Linear
  - Messages
  - Music
  - Obsidian
  - Raycast Explorer
  - Speedtest
  - Spotify Player
  - Todoist
  - Google Translate
  - Visual Studio Code
  - YouTube
- Tracked manifest lists some things not seen in extracted live package set, such as `1password`.
- Raycast internal config/storage should not be tracked.
- Best use is a curated extension checklist/manifest.

## 19. Project path facts

- Current repo path is `~/Code/personal/dotfiles`.
- Existing `docs/stow-migration-plan.md` references `~/Code/personal/dotfiles`.
- `sesh/sesh.toml` references `~/projects`, `~/projects/code`, `~/projects/dotfiles`, etc.
- Need choose final new-laptop project root convention.
- This decision affects `sesh`, bootstrap docs, and possibly shell aliases/functions.

## 20. Local override facts

Desired ignored local override patterns already exist:

- `*.local`
- `*.local.*`
- `.envrc.local`

Likely useful local files:

- `~/.zshrc.local`
- `~/.zprofile.local`
- `~/.zshenv.local`
- `~/.gitconfig.local`

Current live zsh/git files do not yet implement these includes.

## 21. Secret/public safety facts

Repo is public, so avoid tracking:

- auth tokens
- OAuth credentials
- app databases
- state/history/cache
- globalStorage folders
- generated session data
- machine-specific IDs

Known likely sensitive live files:

- `.claude.json`
- `.codex/auth.json`
- `.gemini/oauth_creds.json`
- parts of `.supacode/settings.json`

GitHub CLI auth should be restored with `gh auth login`, not by tracking auth files.

## 22. External plugin facts

Observed external plugins:

- zsh autosuggestions:
  - URL: `https://github.com/zsh-users/zsh-autosuggestions`
  - Current commit: `c3d4e57`
- zsh syntax highlighting:
  - URL: `https://github.com/zsh-users/zsh-syntax-highlighting.git`
  - Current commit: `dcc99a8`
- tmux TPM:
  - URL: `https://github.com/tmux-plugins/tpm`
  - Current commit: `99469c4`

Likely direction:

- Do not vendor plugin clones.
- Either document explicit clone commands or intentionally use submodules/pinning later.
- Explicit clone commands are simpler and more intentional for now.

## 23. Candidate core set

High-impact candidates for final Stow allowlist:

- `zsh`
- `git`
- `starship`
- `ghostty`
- `tmux`
- `nvim`
- `direnv`
- `atuin`
- `gh`
- `lazygit`
- `yazi`

Secondary candidates:

- `k9s`
- `btop`
- `bat`
- `glow`
- `gh-dash`
- `cmux`

Hold/unverified candidates:

- `alacritty`
- `vscode`
- `cursor`
- `claude`
- `opencode`
- `sesh`
- `television`
- `vimium`
- `htop`
- `lazydocker`

Manifest/checklist-only candidates:

- `brew`
- `raycast`
- GUI apps
- editor extensions
- auth/login checklist

## 24. Main open decisions

- Primary terminal: Ghostty only, or Ghostty plus Alacritty?
- Primary editor: Neovim first, VS Code fallback, Cursor still relevant?
- Final project root: `~/Code/personal`, `~/projects`, or something else?
- Git identity: tracked directly or local-only?
- Starship philosophy: minimal/fast or rich/symbol-heavy?
- Zsh organization: keep single tuned `.zshrc` or modularize like reference repo?
- Zsh plugin strategy: explicit bootstrap clones or auto-install from shell?
- Brew strategy: curated `Brewfile`, raw inventory, or both?
- GUI app strategy: Homebrew casks where possible or manual checklist?
- Which AI tools deserve first-class dotfiles support?
- What is the minimum one-liner allowed to do automatically?
- What should require manual confirmation before overwrite/adoption?

## 25. Possible final reference doc sections

When we start picking, the final build-towards doc could have these sections:

1. Philosophy and scope.
2. New laptop one-liner.
3. Bootstrap phases.
4. Core stowed packages.
5. Manifest/checklist-only items.
6. Local overrides and secrets boundary.
7. Manual auth/app checklist.
8. Package migration order.
9. Verification checklist.
10. Rollback strategy.

## 26. Theme direction — Vesper

- Moving forward, configs should be themed using Vesper.
- Primary reference: `https://github.com/vladzima/vesper-theme`.
- Original VS Code theme reference: `https://github.com/raunofreiberg/vesper`.
- Canonical palette research is now tracked in `docs/vesper-palette.md`.
- Core colors:
  - background: `#101010`
  - foreground: `#FFFFFF`
  - accent/warning/modified: `#FFC799`
  - accent hover: `#FFCFA8`
  - success/added/strings: `#99FFE4`
  - error/deleted: `#FF8080`
  - muted: `#A0A0A0`
  - dim: `#7E7E7E`
  - surfaces: `#161616`, `#1C1C1C`, `#232323`, `#282828`
- Existing Rose Pine/Catppuccin configs should be converted gradually when touched or migrated, not churned all at once before final scope is decided.
