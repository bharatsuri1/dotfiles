# Laptop Switch Dotfiles Review

> Historical reference captured during the pre-implementation audit. Current decisions live in the repository trackers and setup contract.

Purpose: make this repo the intentional source of truth for a new laptop setup, down to a safe one-liner, while keeping tracked config minimal, portable, and public-safe.

## Guardrails

- Keep raw scratch research untracked; promote durable conclusions into `docs/`.
- Do not run `stow` until each package is converted to tree-mirror layout.
- Repo is public: audit secrets before adopting any live file.
- Prefer live config as canonical only after review.
- One package, one commit, one verification loop.
- No broad ignore patterns that hide real config drift.

## Current repo state

- Origin: `https://github.com/bharatsuri1/dotfiles`, branch `main`.
- Layout is still flat package dirs (`zsh/.zshrc`, `starship/starship.toml`, etc.).
- No `.stowrc` yet. This is correct until first migration.
- Top-level README is effectively empty and needs the final bootstrap story.
- `docs/stow-migration-plan.md` is directionally right but now stale in a few details.
- No live home config checked so far is symlinked back into the repo.

## Reference repo takeaways

### `radleylewis/zsh`

- Strong example of a focused zsh README: dependencies, setup, plugins, keybindings.
- Modular files (`aliases.zsh`, `bindings.zsh`, `plugins.zsh`, `fzf.zsh`, `prompt.zsh`) are readable.
- Auto-installing plugins on first launch is convenient, but for our repo we should decide if we prefer explicit bootstrap steps over shell startup side effects.
- Uses `ZDOTDIR=~/.config/zsh`; our current plan keeps standard `~/.zshrc`/`.zshenv`/`.zprofile` symlinked via Stow, which is simpler for macOS and existing live setup.

### `radleylewis/dotfiles`

- Bare-repo home checkout gives direct home-tree ownership.
- Submodules for `nvim`, `qtile`, `zsh` work for independent repos.
- Our Stow tree-mirror approach still fits our goal better: explicit packages, easy rollback, no bare-repo footguns, supports macOS Library paths.

## Live vs repo snapshot

### Live real files to adopt/review first

- `~/.zshrc`, `~/.zshenv`, `~/.zprofile`: tuned post-OMZ setup; repo `zsh/.zshrc` is stale OMZ.
- `~/.gitconfig`: simple name/email only; decide if tracked with local include.
- `~/.config/starship.toml`: differs significantly from repo.
- `~/.config/tmux/tmux.conf`: drifted.
- `~/.config/btop/btop.conf`: drifted.
- `~/.config/television/config.toml`: small drift.
- `~/.config/vimium/vimium-options.json`: small drift.
- VS Code/Cursor settings: drifted; keybindings are JSONC, not strict JSON.
- `~/.config/yazi/{keymap.toml,yazi.toml}`: small drift.
- `~/.config/nvim`: live and repo drift in lockfile/keymaps/lazy config/rose-pine plugin.

### Repo/live currently matching for core files

- `alacritty/alacritty.toml` matches live main config, but live theme path is `themes/rose-pine.toml` and differs from repo root `rose-pine.toml`.
- `atuin`, `cmux`, `direnv`, `gh`, `gh-dash`, `ghostty`, `git/ignore`, `glow`, `k9s`, `lazygit` are mostly in sync.
- `tmux/scripts/ai-picker.sh` matches live.
- Yazi flavors appear to match live.

### Present in repo but absent/not deployed live

- `bat`, `htop`, `lazydocker`, `sesh`.
- `claude/statusline-command.sh` is tracked but absent live; tracked `claude/settings.json` points at it while live `~/.claude/settings.json` is tiny.
- Cursor `cli-config.json` and `commands/*.md` have no matching obvious live path found yet.

### Manifest-only

- `brew/list.txt`: currently a full formula list with dependencies and some drift from installed packages. Consider replacing/augmenting with a standard `Brewfile` using leaves, taps, and casks.
- `raycast/extensions.md`: useful restore manifest, not a Stow target.

## Proposed target standards

- GNU Stow tree-mirror packages rooted at repo package dirs, target `$HOME`.
- Root `.stowrc` once migration starts:
  - `--target=$HOME`
  - `--no-folding`
- Use explicit package list in bootstrap, never `stow */`.
- Guarded local includes:
  - `~/.zshrc.local`
  - `~/.zprofile.local`
  - `~/.zshenv.local`
  - `~/.gitconfig.local`
- Keep runtime/plugin dirs unmanaged:
  - zsh plugins
  - tmux TPM plugins
  - app caches/globalStorage/history/session files
- Prefer `Brewfile` for laptop setup instead of dependency-heavy `brew/list.txt`.
- README should become the canonical one-liner + phases + manual auth checklist.

## Migration outline

1. Repo hygiene/planning
   - Promote durable planning conclusions into tracked documentation.
   - Update top-level README when ready.
   - Refresh migration doc after current findings.
2. Zsh first
   - Convert `zsh/` to tree-mirror.
   - Adopt live `.zshrc`, `.zshenv`, `.zprofile`, completions.
   - Add guarded local includes.
   - Document external plugin install/update.
   - Add `.stowrc` with first real migration.
3. Core low-risk packages
   - `starship`, `git`, `direnv`, `gh-dash`, `gh`, `ghostty`, `alacritty`, `atuin`, `k9s`, `lazygit`, `cmux`.
4. Packages with unmanaged siblings or not currently deployed
   - `tmux`, `btop`, `yazi`, `bat`, `sesh`, `htop`, `lazydocker`, `television`, `vimium`.
5. macOS / app-specific packages
   - `claude`, `vscode`, `cursor` after path decisions.
6. `nvim`
   - No nested git repo now, but live drift needs review.
7. Bootstrap
   - Create idempotent install script only after packages are migrated enough to support it.
   - One-liner should clone repo, install prerequisites, run explicit Stow list, then print auth/manual checklist.

## Open questions

- Should brew become `Brewfile` only, or keep `brew/list.txt` as a raw inventory too?
- Which AI/editor tool configs should be tracked: Claude, Cursor commands, opencode, Codex/Gemini/Supacode? Public repo means be conservative.
- Should zsh plugins remain explicit bootstrap clones, or be auto-installed by a tiny plugin manager? Explicit seems more intentional.
- Confirm final repo path convention on new laptop: current repo is `~/Code/personal/dotfiles`, while some configs mention `~/projects/dotfiles`.
- Decide whether tracked `.gitconfig` includes public identity directly or delegates identity to `~/.gitconfig.local`.
- Decide whether live Starship or optimized repo Starship is canonical; they differ in philosophy.

## Additional review notes

- Current key tool commands are present for most CLI/TUI tooling; notable command-name caveats:
  - `television` installs executable `tv`.
  - `gh-dash` is installed as `gh dash` extension, not a standalone `gh-dash` binary.
  - `cmux`, `ghostty`, and `alacritty` were not found as shell commands in this environment; treat as app/config targets, not CLI prerequisites unless installation approach changes.
- Homebrew taps currently present: `gromgit/brewtils`, `olets/tap`, `teamookla/speedtest`.
- Hardcoded path scan found `sesh/sesh.toml` still points at `~/projects/...`, while this repo currently lives under `~/Code/personal/dotfiles`. Decide final new-laptop project root before adopting `sesh`.
- Current live zsh/git files do not yet implement guarded local includes; add them during zsh/git adoption if we keep that standard.

## App install coverage gap

- `/Applications` contains many important apps not represented by current Homebrew casks or repo manifests: Alacritty, Ghostty, cmux, Cursor/supacode/OpenCode-style tools, Raycast, CleanShot X, 1Password/Dashlane-class apps, OrbStack, Obsidian, LM Studio/Ollama, etc.
- Current Homebrew casks only show `font-symbols-only-nerd-font` and `stats`; bootstrap will need either a richer `Brewfile` cask section or an explicit manual app checklist.
- `mas` is not installed, so Mac App Store restore is currently not captured.

## Zsh performance/automation note

- Live zsh warm startup samples are ~47-57ms, which is excellent.
- Running `zsh -i -c exit` in a non-TTY harness prints two `can't change option: zle` warnings from Homebrew `fzf` key-bindings/completion restoring the `zle` option. Actual terminal behavior may be fine, but during adoption consider guarding full interactive widget setup with a TTY/ZLE check if we want clean automation shells.

## Documentation coverage

- Only `zsh/` and `nvim/` have package-level READMEs today.
- Top-level `README.md` is empty placeholder. For the laptop switch, it should carry the canonical setup contract: prerequisites, one-liner, what gets stowed, what remains manual, rollback, and local override conventions.
- Package-level docs should stay selective. Avoid README sprawl for every tiny config; document only high-risk/complex packages (`zsh`, `tmux`, `nvim`, bootstrap/brew, editor/app paths).

## Canonical-source cautions

- Do not blindly apply "live wins" to every file:
  - Starship: repo version is intentionally minimal/latency-bounded; live version looks closer to a broad Nerd Font symbol preset. Decide based on desired prompt philosophy.
  - Tmux: live has meaningful UX improvements (sesh section cleanup, git path command fixes, copy/scroll mouse UX). Live likely should be adopted, but review line-by-line.
  - Claude: repo has rich settings/statusline, but live settings are minimal and statusline script is absent. Decide desired Claude Code setup before stowing.

## Public-repo secret boundary

- Likely secret-bearing live files should stay out of this repo and be handled by app login/restore only: `.claude.json`, `.codex/auth.json`, `.gemini/oauth_creds.json`, and parts of `.supacode/settings.json`.
- `~/.config/gh/hosts.yml` did not trip the coarse keyword scan, but GitHub auth should still be restored via `gh auth login`, not by tracking auth files.

## Potential new package candidates

- `opencode`: live `~/.config/opencode/opencode.jsonc` is minimal (`shell: zsh`, `permission: allow`) and command docs (`devcontainer`, `workspaces`, `worktree`) look portable/useful. Generated Supacode presence plugin should likely be documented or regenerated, not hand-maintained unless we decide otherwise.
- `supacode`: live settings exist but tripped secret-keyword scan; do not track until audited carefully.
- `codex`/`gemini`: live dirs contain auth/state/history; likely not dotfiles targets except possibly a tiny sanitized config if needed later.

## Raycast manifest drift

- Live Raycast extensions are broader than tracked `raycast/extensions.md`. Current live candidates include Apple Notes/Reminders, GitHub, Google Workspace, Linear, Messages, Music, Spotify Player, Todoist, YouTube, etc.
- Tracked manifest still lists some extensions not in the extracted live package set (for example `1password`); verify via Raycast UI before updating because UUID/local extension storage may not be a perfect source of truth.

## Brew/bootstrap research

- A scratch `brew bundle dump` produced a much better laptop-bootstrap shape than `brew/list.txt`: taps, formulae, casks, VS Code extensions, one cargo package, and the global pi npm package.
- The generated scratch Brewfile still needs curation: it includes some dependencies/top-level ambiguity (`xz`, `node`, `pinentry`) and only two casks, so it should not be committed blindly.
- Good future direction: replace `brew/list.txt` with a curated `Brewfile` plus maybe `brew/leaves.txt` as inventory if desired.

## Editor extension coverage

- `code --list-extensions` works and matches the VS Code extensions captured by scratch `brew bundle dump`.
- `cursor` CLI is not currently on PATH and Cursor app was not visible in `/Applications` snapshot, even though `~/Library/Application Support/Cursor/User` exists. Treat Cursor config as stale/unverified until the app/CLI path is confirmed.

## Bootstrap shape sketch

Eventual one-liner should probably be:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/bharatsuri1/dotfiles/main/install.sh)"
```

But `install.sh` should stay boring and auditable:

1. Confirm macOS + Apple Silicon assumptions, or print unsupported warning.
2. Ensure Xcode CLT and Homebrew.
3. Clone/update repo at the chosen path.
4. Run `brew bundle --file brew/Brewfile` after curation.
5. Create required directories and install explicit external plugins (zsh plugins, TPM) or print clear next steps.
6. Stow an explicit allowlist of migrated packages only.
7. Print manual auth/app checklist: `gh auth login`, Atuin login/import, Raycast login/extensions, app licenses, SSH keys, cloud CLIs.
8. Never overwrite existing real files without backup and confirmation unless a documented `--force/adopt` mode is passed.

## External plugins observed

- zsh autosuggestions: `https://github.com/zsh-users/zsh-autosuggestions` at `c3d4e57`.
- zsh syntax highlighting: `https://github.com/zsh-users/zsh-syntax-highlighting.git` at `dcc99a8`.
- tmux TPM: `https://github.com/tmux-plugins/tpm` at `99469c4`.
- Keep these outside the repo unless we intentionally introduce submodules/pinning. For laptop setup, explicit clone commands are probably enough.

## Cleanup candidates after migration

- `~/.oh-my-zsh` remains present even though live zsh no longer uses OMZ.
- `~/.fzf.zsh` remains from legacy fzf setup; live zsh uses Homebrew fzf scripts directly.
- zsh runtime files (`~/.zshrc.zwc`, `~/.zcompdump`, history/session files) should stay untracked and can be regenerated.
- Old backup files (`.zshrc.backup.*`, `.zshenv.backup.*`, `.zprofile.backup.*`) can be deleted only after zsh is stowed and verified.

## Bash/profile note

- `~/.bash_profile` and `~/.profile` contain installer-added PATH snippets (LM Studio, GitButler, Antigravity, SDKMAN, Cargo, Atuin) with hardcoded user-home paths.
- If new laptop standard shell is zsh-only, do not migrate these wholesale. Prefer a minimal `.profile` only if non-zsh login contexts need it.
