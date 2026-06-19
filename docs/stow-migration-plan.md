# Stow Migration Plan — Make `dotfiles` the Source of Truth

**Status:** Draft / research complete — ready to execute one package at a time.
**Date:** 2026-06-19
**Repo:** `~/Code/personal/dotfiles` → `origin: https://github.com/bharatsuri1/dotfiles` (branch `main`)
**Tool:** GNU Stow 2.4.1 (`/opt/homebrew/bin/stow`, already installed)

---

## 1. Goal

Turn this repo into the **single source of truth** for every tool's config, with the live
files in `$HOME` becoming **symlinks** managed by `stow`. Migrate **one package at a time**,
starting with **zsh**, committing and pushing each step so GitHub tracks the full history.

End state:

- Every tracked config file lives in this repo under a stow "package" directory.
- The corresponding file in `$HOME` is a symlink → repo file (created by `stow`).
- `git pull` + `stow <pkg>` on a fresh machine reproduces the environment.
- No more drift between "what's in the repo" and "what's actually running".

---

## 2. Current-state assessment

### 2.1 Repo layout today

The repo uses **flat package dirs** — each top-level dir (e.g. `starship/`, `tmux/`, `k9s/`)
holds the files that *conceptually* belong in `~/.config/<pkg>/`. There is no `.stowrc`, no
`docs/`, and no install/bootstrap script. Tracked packages:

```
alacritty/  atuin/  bat/  btop/  brew/  claude/  cmux/  cursor/  direnv/
gh/  gh-dash/  ghostty/  git/  glow/  htop/  k9s/  lazydocker/  lazygit/
nvim/  raycast/  sesh/  starship/  television/  tmux/  vimium/  vscode/
yazi/  zsh/
```

### 2.2 Home layout today

- `~/.zshrc`, `~/.zshenv`, `~/.zprofile` — **real files, NOT tracked** (repo `zsh/.zshrc` is
  the *stale Oh-My-Zsh* version; `~/.zshrc` is the tuned version and was never committed).
- `~/.config/<pkg>/` — real dirs for: `alacritty atuin btop cmux direnv gh gh-dash ghostty
  git glow k9s lazygit nvim raycast television tmux vimium yazi zsh`.
- `~/.config/<pkg>` **absent** (repo has config but it's not deployed) for: `bat claude
  cursor htop lazydocker sesh vscode`.
- `~/.config/starship.toml` — a **file** at the `~/.config` root (not `~/.config/starship/`).
- `~/.gitconfig` — real, untracked.
- `~/.claude/settings.json` — Claude Code config lives in `~/.claude`, **not** `~/.config/claude`.
- VS Code / Cursor settings live under
  `~/Library/Application Support/Code/User/` and `~/Library/Application Support/Cursor/User/`
  (macOS non-XDG paths).
- `~/.config/tmux/plugins/` — TPM-managed plugin clones (must stay untracked).
- `~/.config/zsh/plugins/{zsh-autosuggestions,zsh-syntax-highlighting}/` — **nested git
  clones** (each has its own `.git`). Must stay untracked.

### 2.3 Drift

A spot-check of 7 tracked XDG configs showed **all 7 have diverged** between repo and live
(`alacritty`, `git/ignore`, `tmux.conf`, `k9s`, `gh`, `ghostty`, `direnv`). The repo is
behind on most tools. The existing `scratchpad/plan.md` (gitignored) documents per-tool sync
work that was done to the **live** files but never committed. **Implication:** for each
package, the *live* file is usually the source of truth and must be pulled into the repo
during migration (use `stow --adopt` or a manual copy — see §6).

### 2.4 Gotchas discovered

1. **`nvim/` is a nested git repo** with the *same* origin as the parent
   (`github.com/bharatsuri1/dotfiles`). It is not a submodule (no `.gitmodules`). The parent
   also tracks `nvim/*` as plain blobs. This double-tracking must be resolved (see §11).
2. **`.pi/` is partially tracked** (`.pi/settings.json`, `.pi/npm/.gitignore`); the npm
   `node_modules` are ignored via `.pi/npm/.gitignore`. This is pi-agent workspace state,
   **not** a stow target. Leave as-is.
3. **`scratchpad/` is gitignored** — do not put this plan there (it must be committed). Hence
   `docs/stow-migration-plan.md`.
4. **`brew/list.txt` and `raycast/extensions.md` are manifests**, not config files to
   symlink. Keep tracked, do **not** stow.
5. **zsh plugins are external git clones** — never track them in this repo (see §14).
6. **Backups littering `$HOME`**: `.zshrc.backup.20260613225527`, `.zshenv.backup.*`,
   `.zprofile.backup.*` — leftover from the earlier OMZ→tuned migration. Safe to delete
   after zsh is migrated and verified.

---

## 3. Principles

1. **One package, one commit, one push.** Small, reviewable, bisectable history. Use the
   repo's existing conventional-commit style (`feat(zsh):`, `chore(stow):`, etc.).
2. **Live file wins on drift.** When repo and live differ, the live file is canonical
   (unless we explicitly decide otherwise) and gets adopted into the repo.
3. **Atomic per package.** Never half-migrate a package. A package is either fully stowed
   (all its files symlinked) or not touched.
4. **Verify before pushing.** After stowing a package, exercise the tool (open it, reload
   config) to confirm the symlink is actually read. Only then commit+push.
5. **Rollback is always `stow -D <pkg>`** plus restoring the adopted file. Keep backups until
   verified.
6. **No symlinks committed.** The repo holds real files only; symlinks exist only in `$HOME`.
7. **Local overrides are explicit and untracked.** Machine-specific paths, work-only settings,
   secrets, and experimental tweaks live in `*.local` files that are sourced/included by the
   tracked config. The tracked file owns the default behavior; local files own local variance.

---

## 4. Stow convention decision: **tree-mirror packages**

### Chosen: each package dir mirrors the `$HOME`-relative path of its files.

```
zsh/
  .zshrc
  .zshenv
  .zprofile
  .config/zsh/completions/_cargo
  .config/zsh/completions/_rustup
starship/
  .config/starship.toml
tmux/
  .config/tmux/tmux.conf
  .config/tmux/scripts/ai-picker.sh
vscode/
  "Library/Application Support/Code/User/settings.json"
  "Library/Application Support/Code/User/keybindings.json"
claude/
  .claude/settings.json
  .claude/statusline-command.sh
```

Then **every** package is installed with the same command from the repo root:

```sh
stow -t ~ <pkg>      # or just `stow <pkg>` once .stowrc sets --target=$HOME
```

**Why this over the current flat style:**

- Handles **every** target location uniformly: `$HOME` dotfiles, `~/.config`, macOS
  `~/Library/...`, `~/.claude`, etc. — one command, one mental model.
- The current flat style (`stow -t ~/.config <pkg>`) breaks for zsh (needs both `$HOME` and
  `~/.config`), vscode/cursor (Library path), claude (`~/.claude`), and the top-level
  `.zshrc`/`.zshenv`/`.zprofile`. Tree-mirror breaks for nothing.
- It is the de-facto standard for stow-managed dotfiles.

**Cost:** a one-time `git mv` restructure of each package as we migrate it. Since we go
one-by-one and re-adopt the live (canonical) files anyway, the restructure is free.

**Rejected alternative — keep flat + per-package `--target`:** would require remembering a
different target per package (`-t ~/.config` for most, `-t ~` for zsh top-level, `-t
"$HOME/Library/.../User"` for vscode/cursor). More fragile, more docs, no upside.

---

## 5. Prerequisites (do once, first)

1. **Verify clean working tree** before starting:
   ```sh
   cd ~/Code/personal/dotfiles && git status
   ```
   Commit or stash anything pending first.
2. **Add `.stowrc`** at repo root so `stow <pkg>` always targets `$HOME`:
   ```
   --target=$HOME
   --no-folding        # see §5 note below on folding
   ```
   `--no-folding` forces stow to symlink **individual files** rather than whole directories.
   This is critical for `~/.config/zsh/`, `~/.config/tmux/`, `~/.config/atuin/` etc. where
   the live dir also contains unmanaged content (plugins, receipts). With folding, stow
   would try to replace the whole dir with one symlink and fail/refuse. Commit the `.stowrc`.
3. **Confirm stow version** ≥ 2.4 (we have 2.4.1 — supports `--adopt`, `--no-folding`).
4. **Refresh `.gitignore`** for dotfiles usage before migration. Keep `scratchpad/`, runtime
   plugin dirs, `.DS_Store`, pi npm dependencies, and local override files ignored; remove the
   stale GitHub Pages/Jekyll ignores unless this repo becomes a Pages site again.
5. **Back up `$HOME` dotfiles** being migrated for the session (a tarball is enough):
   ```sh
   tar czf ~/dotfiles-pre-stow-backup-$(date +%Y%m%d).tgz \
     ~/.zshrc ~/.zshenv ~/.zprofile ~/.gitconfig ~/.config/zsh ~/.config/starship.toml
   ```
   Delete after all packages verified.

---

## 6. Canonical per-package migration procedure

Run this for **each** package, substituting `<pkg>` and the file list. The example uses
`starship` (simplest: single XDG file).

```sh
cd ~/Code/personal/dotfiles
git checkout main && git pull

# 1. Restructure the package to tree-mirror layout (git mv preserves history).
mkdir -p starship/.config
git mv starship/starship.toml starship/.config/starship.toml

# 2. If the live file has drifted, adopt it (makes live → repo canonical, creates symlink):
#    --adopt moves the existing live file INTO the package and symlinks it back.
stow --adopt starship
#    (If the repo file is already identical to live, plain `stow starship` suffices.)

# 3. Inspect what stow did:
ls -l ~/.config/starship.toml          # should be symlink → repo path
git status                              # adopted file shows as modified

# 4. Verify the tool still works:
starship config                         # or open a new shell / reload

# 5. Stage, commit, push:
git add -A starship .stowrc
git commit -m "chore(stow): migrate starship to tree-mirror stow package"
git push
```

### When `--adopt` is wrong
`stow --adopt` will **overwrite the repo file with the live file**. That's what we want when
live is canonical. If for some package we decide the *repo* version is canonical, instead:
```sh
rm ~/.config/<pkg>/<file>      # remove live
stow <pkg>                     # create symlink to repo file
```

### Conflicts (existing real files / dirs)
- Real **file** where a symlink is wanted → `stow` refuses; use `--adopt` (preferred) or `rm`
  the live file then `stow`.
- Real **directory** in the way (e.g. `~/.config/zsh/` already exists) → with
  `--no-folding`, stow descends into it and symlinks only the individual managed files,
  leaving unmanaged siblings (plugins/) untouched. This is exactly what we want.
- Real directory that is **entirely** owned by one package and contains nothing unmanaged →
  stow would fold it into a single symlink; `--no-folding` prevents that for safety.

---

## 7. Package inventory

Legend — **Live**: `real`/`symlink`/`absent`. **Target**: where the file must land in `$HOME`.
**Drift**: does live differ from repo? **Priority**: migration order tier.

| Package | Repo files | Live location | Live | Drift | Target (tree-mirror path) | Gotchas | Priority |
|---|---|---|---|---|---|---|---|
| **zsh** | `.zshrc` (stale!), README | `~/.zshrc`, `~/.zshenv`, `~/.zprofile`, `~/.config/zsh/{completions,plugins}` | real | yes (big) | `zsh/.zshrc`, `.zshenv`, `.zprofile`, `.config/zsh/completions/_cargo,_rustup` | plugins are nested git clones — do NOT track; see §9, §13 | **1** |
| starship | `starship.toml` | `~/.config/starship.toml` | real | yes | `starship/.config/starship.toml` | file lives at `~/.config` root, not in a dir — tree-mirror handles it | 2 |
| git | `ignore` | `~/.config/git/ignore` + `~/.gitconfig` (untracked) | real | yes | `git/.config/git/ignore`, `git/.gitconfig` | decide whether to track `.gitconfig` (contains user.name/email — fine, it's per-user but we want it versioned) | 2 |
| direnv | `direnv.toml` | `~/.config/direnv/direnv.toml` | real | yes | `direnv/.config/direnv/direnv.toml` | — | 2 |
| gh | `config.yml` | `~/.config/gh/config.yml` | real | yes | `gh/.config/gh/config.yml` | may contain tokens? audit before committing | 2 |
| gh-dash | `config.yml` | `~/.config/gh-dash/config.yml` | real | ? | `gh-dash/.config/gh-dash/config.yml` | — | 2 |
| glow | `glow.yml` | `~/.config/glow/glow.yml` | real | ? | `glow/.config/glow/glow.yml` | — | 2 |
| ghostty | `config` | `~/.config/ghostty/config` | real | yes | `ghostty/.config/ghostty/config` | — | 2 |
| alacritty | `alacritty.toml`, `*.toml` themes | `~/.config/alacritty/` | real | yes | `alacritty/.config/alacritty/...` | theme tomls included | 2 |
| atuin | `config.toml`, `themes/` | `~/.config/atuin/` | real | ? | `atuin/.config/atuin/config.toml`, `themes/` | live also has `atuin-receipt.json` — unmanaged, leave | 2 |
| k9s | `config.yaml`, `aliases.yaml`, `skins/` | `~/.config/k9s/` | real | yes | `k9s/.config/k9s/...` | live may have more files (skins cache); audit | 2 |
| lazygit | `config.yml` | `~/.config/lazygit/config.yml` | real | ? | `lazygit/.config/lazygit/config.yml` | — | 2 |
| lazydocker | `config.yml` | `~/.config/lazydocker/` | absent | n/a | `lazydocker/.config/lazydocker/config.yml` | not deployed; stowing will deploy it | 3 |
| bat | `config`, `themes/` | `~/.config/bat/` | absent | n/a | `bat/.config/bat/...` | not deployed | 3 |
| sesh | `sesh.toml` | `~/.config/sesh/` | absent | n/a | `sesh/.config/sesh/sesh.toml` | not deployed | 3 |
| htop | `htoprc` | `~/.config/htop/` | absent | n/a | `htop/.config/htop/htoprc` | not deployed | 3 |
| btop | `btop.conf`, `themes/` | `~/.config/btop/` | real | ? | `btop/.config/btop/...` | live may have downloaded themes; audit | 3 |
| television | `config.toml` | `~/.config/television/` | real | ? | `television/.config/television/config.toml` | — | 3 |
| yazi | `yazi.toml`, `keymap.toml`, `theme.toml`, `package.toml`, `flavors/` | `~/.config/yazi/` | real | ? | `yazi/.config/yazi/...` | `flavors/` are git clones? audit for nested .git | 3 |
| tmux | `tmux.conf`, `scripts/` | `~/.config/tmux/` | real | yes | `tmux/.config/tmux/tmux.conf`, `scripts/` | `plugins/` is TPM-managed — unmanaged; `--no-folding` essential; see §12 | 3 |
| vimium | `vimium-options.json` | `~/.config/vimium/` | real | ? | `vimium/.config/vimium/vimium-options.json` | — | 3 |
| claude | `settings.json`, `statusline-command.sh` | `~/.claude/settings.json` | real | ? | `claude/.claude/settings.json`, `.claude/statusline-command.sh` | target is `~/.claude`, NOT `~/.config/claude`; live `~/.claude` has runtime dirs (sessions, cache) — `--no-folding` | 4 |
| cmux | `cmux.json` | `~/.config/cmux/` | real | yes (recently synced) | `cmux/.config/cmux/cmux.json` | — | 4 |
| vscode | `settings.json`, `keybindings.json` | `~/Library/Application Support/Code/User/` | real | ? | `vscode/Library/Application Support/Code/User/...` | macOS Library path; see §10 | 4 |
| cursor | `settings.json`, `keybindings.json`, `cli-config.json`, `commands/` | `~/Library/Application Support/Cursor/User/` + `~/.cursor/`? | real | ? | `cursor/Library/Application Support/Cursor/User/...` + possibly `~/.cursor/...` | **needs investigation**: where does `cli-config.json` + `commands/` actually live? verify before migrating; see §10 | 4 |
| nvim | full LazyVim tree | `~/.config/nvim/` | real | ? | `nvim/.config/nvim/...` | **nested git repo with same origin** — must resolve first; see §11 | 5 |
| raycast | `extensions.md` (manifest only) | `~/.config/raycast/` (dynamic) | real | n/a | **not a stow target** | repo file is a manifest doc, not a config to symlink | — |
| brew | `list.txt` (manifest) | n/a | — | n/a | **not a stow target** | manifest only | — |

---

## 8. Migration order (phases)

### Phase 0 — setup (one commit)
- Add `.stowrc` (`--target=$HOME --no-folding`).
- Add `docs/stow-migration-plan.md` (this file).
- Commit: `chore(stow): add .stowrc and migration plan`.
- Push.

### Phase 1 — zsh (the requested starting point)
See §9 for the full deep-dive. One commit.

### Phase 2 — simple XDG packages (low risk, one commit each)
Order: `starship` → `direnv` → `git` → `glow` → `gh-dash` → `gh` (audit tokens first) →
`ghostty` → `alacritty` → `atuin` → `k9s` → `lazygit` → `television` → `vimium` → `cmux`.

### Phase 3 — XDG packages with unmanaged siblings / not-yet-deployed
`tmux` (plugins), `btop`/`yazi` (audit nested clones/themes), `bat`, `sesh`, `htop`,
`lazydocker` (deploy on stow).

### Phase 4 — non-XDG / macOS Library paths
`claude` (`~/.claude`), `vscode`, `cursor` (investigate cli-config + commands location).

### Phase 5 — nvim (nested repo resolution)
See §11. Only after a clear decision on collapse-vs-submodule.

### Phase 6 — cleanup
- Delete `.zshrc.backup.*`, `.zshenv.backup.*`, `.zprofile.backup.*` from `$HOME`.
- Delete the pre-stow tarball.
- Update top-level `README.md` with the bootstrap recipe (`git clone … && stow */`).

---

## 9. Deep-dive: zsh (Phase 1)

### 9.1 Target tree-mirror layout
```
zsh/
  .zshrc                          ← adopt from ~/.zshrc (the tuned version)
  .zshenv                         ← adopt from ~/.zshenv
  .zprofile                       ← adopt from ~/.zprofile
  .config/zsh/completions/_cargo  ← adopt from ~/.config/zsh/completions/_cargo
  .config/zsh/completions/_rustup ← adopt from ~/.config/zsh/completions/_rustup
  README.md                       ← already exists (keep, update if needed)
```

### 9.2 What is NOT tracked (stays as real dirs/files in `$HOME`)
- `~/.config/zsh/plugins/zsh-autosuggestions/` — external git clone
- `~/.config/zsh/plugins/zsh-syntax-highlighting/` — external git clone
- `~/.zsh_history`, `~/.zcompdump`, `~/.zshrc.zwc`, `~/.zsh_sessions/` — runtime state
- `~/.cache/zsh/completions` — generated completion cache
- `~/.cache/{brew,vivid,zoxide,atuin,starship,direnv}/` — all generated by `_lazy_cache`

With `--no-folding`, stow will descend into the existing real `~/.config/zsh/` and symlink
**only** `completions/_cargo` and `completions/_rustup`, leaving `plugins/` untouched. ✓

### 9.3 Steps
```sh
cd ~/Code/personal/dotfiles
git checkout main && git pull

# 1. Restructure to tree-mirror. The current zsh/.zshrc is STALE (OMZ) — we will adopt over it.
git mv zsh/.zshrc zsh/.zshrc.stale-omz   # temporary; will be removed after adopt
mkdir -p zsh/.config/zsh/completions

# 2. Adopt the three top-level files (live → repo, symlink created).
stow --adopt zsh      # will pull ~/.zshrc, ~/.zshenv, ~/.zprofile into zsh/
#    Note: .zshenv and .zprofile don't exist in the package yet, so stow creates
#    symlinks for what it can. Simpler: pre-create empty files then adopt, OR
#    copy live files into the package manually first:

# Cleaner approach — manual adopt (explicit, no surprises):
cp ~/.zshrc    zsh/.zshrc
cp ~/.zshenv   zsh/.zshenv
cp ~/.zprofile zsh/.zprofile
cp ~/.config/zsh/completions/_cargo  zsh/.config/zsh/completions/_cargo
cp ~/.config/zsh/completions/_rustup zsh/.config/zsh/completions/_rustup
rm zsh/.zshrc.stale-omz
# Now remove live files and let stow create symlinks:
rm ~/.zshrc ~/.zshenv ~/.zprofile
rm ~/.config/zsh/completions/_cargo ~/.config/zsh/completions/_rustup
stow zsh
```

> Rationale for the manual approach: `stow --adopt` requires the package to already contain
> an entry for each file being adopted, and its overwriting semantics are easy to misread.
> For zsh — the highest-stakes package — explicit `cp` + `rm` + `stow` is clearer and lets us
> `diff` before deleting live files.

### 9.4 Verify (mandatory before commit)
```sh
ls -l ~/.zshrc ~/.zshenv ~/.zprofile                      # all symlinks → repo
ls -l ~/.config/zsh/completions/                          # _cargo, _rustup symlinks
ls -l ~/.config/zsh/plugins/                              # STILL real dirs (untouched)
# Start a fresh interactive shell and confirm:
exec zsh -l
#   → expect "── zsh loaded in <100ms ──" header
#   → vi-mode, completions, atuin ^R, starship prompt all working
#   → `which gst` shows alias; `cd` is zoxide alias
```

### 9.5 Commit
```sh
git add -A zsh .stowrc
git commit -m "feat(zsh): migrate to stow-managed tree-mirror package

Adopt the tuned .zshrc/.zshenv/.zprofile (replacing the stale OMZ copy)
and custom completions (_cargo, _rustup) as a stow package. Plugins
(zsh-autosuggestions, zsh-syntax-highlighting) remain external clones,
untracked. .stowrc forces --no-folding so ~/.config/zsh/ stays a real
dir with only the managed files symlinked."
git push
```

### 9.6 Update `zsh/README.md`
The README's "File Layout" already describes `~/.zshenv` / `~/.zprofile` / `~/.zshrc` as the
startup files — after migration they are symlinks into the repo. Add a short "Installation"
section noting `stow zsh` and the manual plugin-clone step (see §14).

---

## 10. Deep-dive: vscode & cursor (Phase 4)

### vscode
- Live: `~/Library/Application Support/Code/User/{settings,keybindings}.json`
- Tree-mirror: `vscode/Library/Application Support/Code/User/settings.json` etc.
- Install: `stow vscode` (with `.stowrc --target=$HOME`, stow creates the symlink at the
  Library path). macOS `~/Library/Application Support/Code/User/` is a real dir with lots of
  unmanaged content (globalStorage, History, snippets) → `--no-folding` is essential; stow
  will symlink only the two managed JSON files.

### cursor — **needs investigation first**
- `settings.json`, `keybindings.json` → `~/Library/Application Support/Cursor/User/` (confirmed).
- `cli-config.json` → **unknown**. Cursor CLI config likely lives at `~/.cursor/cli-config.json`
  or similar. Verify with `find ~ -name cli-config.json 2>/dev/null` and `cursor --help`.
- `commands/*.md` → Cursor custom commands. Likely `~/.cursor/commands/` or under the User
  dir. Verify before migrating.
- If cursor spans **two** target locations (`~/Library/.../User/` AND `~/.cursor/`), that's
  fine for tree-mirror — one package can contain both `cursor/Library/.../User/*` and
  `cursor/.cursor/*`. Confirm paths, then stow once.

---

## 11. Deep-dive: nvim (Phase 5)

### Problem
`nvim/` is a nested git repo whose `origin` is the **same** as the parent
(`github.com/bharatsuri1/dotfiles`). The parent also tracks `nvim/*` files as blobs. This
means: edits inside `nvim/` are seen by **both** the inner repo and the parent, history is
duplicated/conflicting, and `stow` would symlink `~/.config/nvim` to the repo dir (fine), but
the nested `.git` makes the parent's view of `nvim/` ambiguous.

### Recommended decision: **collapse the nested repo**
1. Remove the inner `.git`:
   ```sh
   rm -rf nvim/.git
   ```
2. The parent already tracks the files as blobs — verify with `git status nvim` (should be
   clean; any diffs are real drift to adopt).
3. Restructure to tree-mirror: `git mv nvim/* nvim/.config/nvim/` (move all files one level
   down under `nvim/.config/nvim/`). Preserve `nvim/.gitignore`, `nvim/LICENSE`, etc.
4. Adopt live drift if any (`~/.config/nvim/` is real), then `stow nvim`.

**Why collapse, not submodule:** the inner repo shares the parent's origin and seems to be
an accidental second checkout, not an intentionally shared upstream. A submodule would point
elsewhere. Collapsing gives a single linear history in one repo — the stated goal.

**Alternative (submodule):** only if we want nvim shareable independently with its own
upstream. Not the case today. Document as rejected.

### Caution
`nvim/` is a LazyVim distribution with `lazy-lock.json` (plugin pin versions). The
`~/.config/nvim/` live dir may have `lazy/` (installed plugins) and state — those are
runtime, unmanaged. `--no-folding` ensures stow symlinks only the tracked files. Audit what
else lives in `~/.config/nvim/` before stowing (don't accidentally track `lazy/`, `.netrw`,
state, swap).

---

## 12. Deep-dive: tmux (Phase 3)

- Live `~/.config/tmux/` contains: `tmux.conf` (real), `scripts/` (real), `plugins/` (TPM
  clones, real, **unmanaged**).
- Tree-mirror: `tmux/.config/tmux/tmux.conf`, `tmux/.config/tmux/scripts/ai-picker.sh`.
- `--no-folding` is mandatory: without it stow would try to fold `~/.config/tmux/` into a
  single symlink and bail because of `plugins/`.
- `.gitignore` already has `tmux/plugins/` — keep it (defensive; the package won't contain a
  `plugins/` dir anyway).
- Adopt `tmux.conf` (it has drifted), then stow. Verify: `tmux source-file ~/.config/tmux/tmux.conf` + open a session.

---

## 13. Local overrides (`*.local`) — machine-specific setup

Industry-standard dotfiles repos keep the committed config portable and layer local-only
settings through ignored override files. This avoids hard-coding work/personal machine paths,
private aliases, credentials, experimental toggles, and host-specific behavior in Git.

Recommended conventions for this repo:

```txt
~/.zshrc.local          # sourced by tracked ~/.zshrc if present
~/.zprofile.local       # optional login-shell additions
~/.zshenv.local         # only truly global environment; keep minimal
~/.gitconfig.local      # included by tracked ~/.gitconfig if present
~/.config/direnv/*.local.toml or .envrc.local  # per-project/local secrets, untracked
```

Tracked shell files should contain guarded includes, for example:

```sh
[ -r "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
[ -r "$HOME/.zprofile.local" ] && source "$HOME/.zprofile.local"
[ -r "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
```

Tracked Git config should include local identity/credential overrides when present:

```ini
[include]
  path = ~/.gitconfig.local
```

`*.local`, `*.local.*`, and `.envrc.local` should be ignored globally in this repo. If a local
file becomes generally useful, promote it into the tracked config intentionally.

---

## 14. zsh plugins (external clones) — bootstrap documentation

Not tracked, not stowed. Document the install in `zsh/README.md` so a fresh machine reproduces them:

```sh
mkdir -p ~/.config/zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.config/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.config/zsh/plugins/zsh-syntax-highlighting
```

`zsh-vi-mode` is Homebrew-installed at `/opt/homebrew/opt/zsh-vi-mode/` (not a stow concern).

Optional future enhancement: convert these two to git submodules so a `git clone --recursive`
of the dotfiles repo brings them along. **Out of scope for this migration** — note as a
future item.

---

## 15. `.gitignore` changes

Current `.gitignore` is mostly Jekyll cruft (legacy from a GitHub Pages origin). Clean up and
make it dotfiles-relevant:

```gitignore
# macOS
.DS_Store

# Local scratch / planning (not tracked)
scratchpad/

# pi-agent workspace (partially tracked via .pi/settings.json; ignore the rest)
.pi/npm/node_modules/

# Local machine overrides / secrets
*.local
*.local.*
.envrc.local

# tmux plugins (TPM-managed)
tmux/plugins/

# nvim runtime (unmanaged, if it ever lands in-repo via adopt)
nvim/.config/nvim/lazy/
nvim/.config/nvim/.netrwhist

# zsh runtime (never track)
#   (plugins live outside the repo, so nothing to ignore here)
```

Remove the stale Jekyll/Gemfile/Pages ignores unless we still use them (we don't). Commit as
`chore: refresh .gitignore for stow-managed dotfiles`.

---

## 16. Verification & rollback (per package)

### Verify checklist (run after every `stow <pkg>`)
1. `ls -l <target>` shows a symlink → `~/Code/personal/dotfiles/<pkg>/...`.
2. `readlink -f <target>` resolves to the repo file.
3. `stow -t ~ -n <pkg>` (dry-run) reports no pending actions (already stowed).
4. Exercise the tool: reload/restart it, confirm it reads config, no errors.
5. `git status` in repo is clean (the adopted file was committed).

### Rollback
```sh
stow -D <pkg>                       # remove symlinks
# restore the pre-adopt backup of the live file (kept in the session tarball)
git revert <commit-sha>             # undo the repo change
```

---

## 17. Commit & push cadence

- **One commit per package** (occasionally one prep commit for a group of trivial repo hygiene,
  such as `.stowrc`, `.gitignore`, and this plan).
- **Conventional-commit style** matching existing history:
  - `chore(stow): add .stowrc and migration plan`
  - `feat(zsh): migrate to stow-managed tree-mirror package`
  - `chore(git): adopt live .gitconfig and git/ignore into stow package`
  - `fix(tmux): adopt drifted tmux.conf into stow package`
- **Push after every commit** — `git push` (main tracks origin/main). This is the "git history
  tracked in GitHub origin remote" requirement.
- Keep commits small and the working tree clean between packages so a mistake is easy to
  revert without taking down other packages.

---

## 18. Risks & open questions

1. **Secrets in config.** `gh/config.yml` and any tool that stores tokens could leak
   credentials to a public GitHub repo. **Audit each config file before committing.** Move
   secrets to env vars or a separate untracked file. (`gh` especially — `gh auth status` to
   see what's stored; `gh` typically keeps tokens in the system keychain, not config.yml, but
   verify.)
2. **Repo visibility.** `github.com/bharatsuri1/dotfiles` — confirm whether it's public or
   private. If public, the secrets audit is non-negotiable.
3. **`stow --adopt` overwriting repo files.** We mostly use the explicit `cp`+`rm`+`stow`
   flow for high-stakes packages (zsh) to avoid surprises. Reserve `--adopt` for low-risk
   single-file packages where live is clearly canonical.
4. **Nested `.git` in `nvim/`** — collapsing it (`rm -rf nvim/.git`) is destructive; do it
   only after confirming the inner repo has no unpushed unique history:
   ```sh
   git -C nvim log --oneline -20
   git -C nvim status
   ```
   If there's unique unpushed work, preserve it first.
5. **`yazi/flavors/` and `btop/themes/`** — verify these aren't nested git clones before
   tracking; if they are, treat like zsh plugins (untracked, documented, or submodule).
6. **`cursor` cli-config + commands location** — must be resolved before Phase 4 (§10).
7. **Folding vs no-folding.** We standardize on `--no-folding` in `.stowrc`. Downside: more
   symlinks (one per file rather than one per dir). Acceptable and safer given every managed
   XDG dir also holds unmanaged content on this machine.
8. **`brew/list.txt` / `raycast/extensions.md`** stay as tracked manifests, not stowed.
9. **`.pi/`** stays as-is (partially tracked workspace), not stowed.

---

## 19. Quick-reference: the loop

```sh
# Per package, from repo root:
git pull
# (restructure to tree-mirror with git mv)
# (adopt live file: cp live→repo, rm live, stow <pkg>)
stow <pkg>                       # .stowrc supplies --target=$HOME --no-folding
# verify the tool works
git add -A <pkg> .stowrc
git commit -m "<type>(<pkg>): <message>"
git push
```

---

## 20. Tomorrow's starting point

1. Phase 0: add `.stowrc`, refresh `.gitignore`, commit this plan, push.
2. Phase 1: migrate **zsh** per §9, verify, commit, push.
3. Then proceed through Phase 2 packages, one per commit.
