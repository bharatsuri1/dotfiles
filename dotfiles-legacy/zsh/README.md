# Zsh Configuration

A performance-tuned, Oh-My-Zsh-free zsh setup targeting **<100ms** interactive shell startup, with a Rose Pine color palette, vi-mode editing, and aggressive lazy-loading throughout.

---

## File Layout

Three zsh startup files, following the standard zsh load order:

```
~/.zshenv          ← every invocation (scripts, scp, rsync, login…)
~/.zprofile        ← login shells only (before .zshrc)
~/.zshrc            ← interactive shells only
```

Plus supporting directories:

```
~/.config/
├── zsh/
│   ├── completions/              ← custom completion functions (_cargo, _rustup)
│   └── plugins/
│       ├── zsh-autosuggestions/  ← fish-style inline suggestions
│       └── zsh-syntax-highlighting/  ← real-time command coloring
├── starship.toml                 ← prompt config (Rose Pine palette)
└── atuin/config.toml             ← synced history config
```

And cached init scripts (regenerated on binary update):

```
~/.cache/
├── brew/shellenv.zsh     ← brew shellenv output
├── vivid/rose-pine       ← LS_COLORS palette
├── zoxide/init.zsh       ← zoxide init
├── atuin/init.zsh        ← atuin init
├── starship/init.zsh     ← starship init
└── direnv/hook.zsh       ← direnv hook
```

---

## Startup Flow

### `.zshenv` — Universal environment

Sourced by **every** zsh process. Kept minimal — no PATH, no commands that produce output:

| Export | Purpose |
|--------|---------|
| `XDG_{CONFIG,CACHE,DATA,STATE}_HOME` | XDG base directory spec |
| `EDITOR` | `nvim` — needed by git, crontab, etc. in non-interactive contexts |
| `LESS` | `-R` — raw control chars for colored output |
| `HOMEBREW_NO_ENV_HINTS` | Suppress brew's "run this to install" messages |
| `PODMAN_COMPOSE_WARNING_LOGS` | Silence podman-compose warnings |
| `VIRTUAL_ENV_DISABLE_PROMPT` | Let starship handle venv display |
| `K9S_CONFIG_DIR` | XDG-aligned k9s config location |
| `LOGDY_CONFIG`, `LOGDY_PORT` | Logdy tool config |

**Design rule:** If a variable is needed by tools that run outside an interactive shell (git commit messages, crontab, remote commands), it belongs here, not in `.zshrc`.

### `.zprofile` — Login shell setup

Runs once per login shell, before `.zshrc`. Handles expensive one-time PATH setup:

| Item | Strategy |
|------|----------|
| Homebrew | Cached `brew shellenv` — regenerated only when the `brew` binary is newer than the cache |
| Rust/Cargo | Sources `~/.cargo/env` |
| OrbStack | Conditionally sourced (silently skips if absent) |

**Design rule:** PATH additions that need to exist before `.zshrc` runs go here. The `.zshrc` PATH block does **not** duplicate these entries — `typeset -U path` would deduplicate anyway, but avoiding the redundancy is cleaner.

### `.zshrc` — Interactive shell

The main configuration file (~300 lines). Organized into ordered sections, where ordering matters (plugins depend on options, highlight plugin must be last, etc.).

---

## Architecture Details

### `_lazy_cache` — Cached init pattern

Most shell tools ship an `eval "$(tool init zsh)"` pattern that runs the tool's binary on every new shell. At 20–80ms each, this adds up fast. Instead, every such tool goes through `_lazy_cache`:

```
_lazy_cache <cache-path> <trigger-binary> <command> [args...]
_lazy_cache -e ENVVAR <cache-path> <trigger-binary> <command> [args...]
```

- Caches the init script output to disk under `~/.cache/`
- Regenerates only when the generating binary is newer than the cache
- `-e VAR` mode: exports the cache content as an environment variable instead of sourcing it (used for `LS_COLORS`)

Tools using this pattern: vivid, zoxide, atuin, starship, direnv. The `.zprofile` brew cache uses the same pattern inline since `_lazy_cache` isn't available at that point.

### SDKMAN — Proxy function lazy-loading

SDKMAN adds ~200ms to shell startup. Instead of sourcing it unconditionally, four proxy functions (`sdk`, `java`, `mvn`, `gradle`) load SDKMAN on first invocation:

```zsh
sdk() {
  unfunction sdk java mvn gradle   # remove ALL proxies at once
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk "$@"
}
java() { sdk > /dev/null 2>&1; java "$@"; }
mvn() { sdk > /dev/null 2>&1; mvn "$@"; }
gradle() { sdk > /dev/null 2>&1; gradle "$@"; }
```

All four must be `unfunction`'d together — if only `sdk` were removed, calling `java` would re-enter the still-active `java` function, which would call `sdk` (now a real binary), and then call `java` (still a function) → infinite recursion.

### `compinit` — Daily rebuild

Completion dump is rebuilt at most once per 24 hours; otherwise `compinit -C` skips security checks for speed:

```zsh
if [[ -n ~/.zcompdump(N.mh+24) ]]; then
  compinit        # full rebuild + security scan
else
  compinit -C     # fast skip
fi
```

The previous `for`-loop pattern had a bug where both `compinit` and `compinit -C` could execute in the same session.

### Plugin ordering

Order matters and is strict:

1. **zsh-vi-mode** — must come first because it接管s keymaps; its config is set before sourcing
2. **zsh-autosuggestions** — fish-style inline suggestions
3. **zsh-syntax-highlighting** — **must be last** — it needs the final keymap state

Keybindings that conflict with vi-mode are deferred to `zvm_after_init`, which runs after zsh-vi-mode has finished resetting bindings. This includes Atuin search keys (`^R`, `/`, `k`, Up) and Alt+Backspace.

### Zoxide and `cd`

`cd` is aliased to `z` (zoxide's smart cd). Code comment documents this. All shell functions that need the real `cd` use `builtin cd` explicitly (`mkcd`, `take`, `grt`, `y`).

### Auto-compile

At the end of `.zshrc`, if the file is newer than its compiled bytecode (`.zshrc.zwc`), zsh recompiles it. This makes subsequent loads parse the bytecode instead of the source.

### Startup timer

The very first line captures `EPOCHREALTIME`; the very last line prints the elapsed time:

```
── zsh loaded in 66ms ──
```

---

## Performance Budget

| Category | Approximate cost |
|----------|-----------------|
| zsh-vi-mode | ~15ms |
| zsh-autosuggestions | ~5ms |
| zsh-syntax-highlighting | ~10ms |
| Cached inits (zoxide/atuin/starship/direnv) | ~5ms total (cache hits) |
| compinit -C | ~3ms |
| Everything else | ~5ms |
| **Total (warm cache)** | **~60–70ms** |

SDKMAN, the heaviest single tool, costs 0ms until first use.

---

## Theme: Rose Pine

All color-sensitive tools use the Rose Pine palette for visual consistency:

| Tool | Config | Key Colors |
|------|--------|-----------|
| **Starship** | `~/.config/starship.toml` | Rose Pine palette (love=#eb6f92, gold=#f6c177, iris=#c4a7e7, foam=#9ccfd8) |
| **FZF** | `FZF_DEFAULT_OPTS` in `.zshrc` | bg=#191724, fg=#e0def4, hl=#eb6f92, prompt=#c4a7e7 |
| **LS_COLORS** | `vivid generate rose-pine` → cached to `~/.cache/vivid/rose-pine` | Pine, foam, love, gold, iris |
| **eza** | `--icons --group-directories-first` | Picks up `LS_COLORS` automatically |

Previous config used Catppuccin Mocha for some tools and Rose Pine for others — now unified to Rose Pine throughout.

---

## Plugin Inventory

| Plugin | Source | Location |
|--------|--------|----------|
| zsh-vi-mode | Homebrew | `/opt/homebrew/opt/zsh-vi-mode/` |
| zsh-autosuggestions | Manual git clone | `~/.config/zsh/plugins/zsh-autosuggestions/` |
| zsh-syntax-highlighting | Manual git clone | `~/.config/zsh/plugins/zsh-syntax-highlighting/` |
| Atuin | Homebrew + cached init | `~/.atuin/bin/atuin` |
| Starship | Homebrew + cached init | `/opt/homebrew/bin/starship` |
| Zoxide | Homebrew + cached init | `/opt/homebrew/bin/zoxide` |
| Direnv | Homebrew + cached init | `/opt/homebrew/bin/direnv` |
| FZF | Homebrew | `/opt/homebrew/opt/fzf/shell/` |
| Vivid | Homebrew | `LS_COLORS` generator |

No Oh-My-Zsh. It was removed during the migration to this setup.

---

## Key Bindings

| Binding | Mode | Action |
|---------|------|--------|
| `^R` | insert | Atuin search |
| `/` | normal | Atuin search |
| `k` | normal | Atuin up-search |
| `↑` | insert | Atuin up-search |
| `^[^?` / `^[^H` | insert | backward-kill-word (Alt+Backspace) |
| Default | — | zsh-vi-mode (vi editing with `KEYTIMEOUT=0.01`) |

All keybindings are set inside `zvm_after_init` to survive zsh-vi-mode's keymap reset.

---

## Aliases & Functions

### Navigation

| Alias | Expands to | Notes |
|-------|-----------|-------|
| `cd` | `z` | Zoxide smart cd; `builtin cd` available in functions |
| `ls` | `eza --icons --group-directories-first` | |
| `l` | `ls -lah` | |
| `ll` | `ls -lh` | |
| `la` | `ls -lAh` | |
| `-` | `cd -` | |
| `1`–`9` | `cd -1` … `cd -9` | Directory stack |
| `...` | `../..` | Global alias |
| `....` | `../../..` | Global alias |
| `md` | `mkdir -p` | |
| `rd` | `rmdir` | |

### Editor

| Alias | Expands to |
|-------|-----------|
| `v`, `nv`, `vi`, `vim` | `nvim` |

### Git

| Alias | Expands to |
|-------|-----------|
| `g` | `git` |
| `gst` | `git status` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gco` | `git checkout` |
| `gd` | `git diff` |
| `gf` | `git fetch` |
| `gl` | `git pull` |
| `gp` | `git push` |
| `glog` | pretty graph log |
| `gfb` | fzf branch checkout |

All git aliases have completion mapped via `compdef _git`.

### Functions

| Function | Description |
|----------|-------------|
| `y` | Yazi file manager — cds to last directory on exit |
| `mkcd` / `take` | `mkdir -p && cd` |
| `grt` | `cd` to git repo root |
| `git_current_branch` | Print current branch name |

---

## History

```zsh
HISTFILE=~/.zsh_history
HISTSIZE=50000    # in-memory limit
SAVEHIST=50000    # on-disk limit (equal to HISTSIZE to prevent loss with share_history)
```

Options: `extended_history` (timestamps), `hist_ignore_dups`, `hist_ignore_space` (prefix with space to hide), `hist_verify` (expand before executing), `share_history` (live sync across sessions), `hist_expire_dups_first` (trim dups first when hitting limits).

---

## Migration Notes

This config was migrated from an Oh-My-Zsh-based setup. The old `~/.zshrc` (still tracked in this repo) used OMZ plugins, `eval "$(tool init zsh)"` calls, and had no caching. Key changes:

1. **Oh-My-Zsh removed** — replaced by direct plugin sourcing for control over load order
2. **`eval` calls eliminated** — all replaced with `_lazy_cache`
3. **Split into `.zshenv` / `.zprofile` / `.zshrc`** — env vars visible to non-interactive shells, PATH setup in login shell only once
4. **PATH deduplication** — `typeset -U` is a safety net; identical entries are no longer listed in two files
5. **compinit bug fixed** — was calling both `compinit` and `compinit -C`; now uses `if/else`
6. **SDKMAN recursion fix** — `unfunction` now removes all four proxy functions (`sdk`, `java`, `mvn`, `gradle`) to prevent infinite recursion
7. **Theme unified** — was Catppuccin Mocha (LS_COLORS, FZF) + Rose Pine (Starship); now Rose Pine everywhere
8. **FZF migrated** — from `~/.fzf.zsh` (legacy install) to Homebrew's canonical `/opt/homebrew/opt/fzf/shell/`
9. **`SAVEHIST` equalized** — was 10000 (losing history with `share_history`), now matches `HISTSIZE` at 50000