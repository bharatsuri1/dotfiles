# Dotfiles macOS Tracker

This tracker governs the implementation of the turnkey macOS setup under `dotfiles-macos/`. It applies the repository-wide [setup contract](setup-contract.md), uses [dotfiles-legacy](../dotfiles-legacy/) and the current host only as reviewed references, and records progress before each implementation phase advances.

> [!IMPORTANT]
> Work proceeds through review gates. Complete and verify one phase, then stop for approval before starting the next phase.

## Status

- Current phase: **macOS experience review; Zsh deployment remains paused**
- Checkpoint before implementation: `131928b`
- Platform directory: `dotfiles-macos/` created; live deployment disabled
- First configuration package: Zsh
- Theme: [Vesper](vesper-palette.md)

## Approved approach

- [x] Provide one obvious, location-independent setup entry point.
- [x] Keep installation idempotent and safe to rerun.
- [x] Use an explicit Stow package allowlist; never infer packages from directories.
- [x] Protect existing files and never use `stow --adopt` as the normal path.
- [x] Require confirmation before backing up or replacing conflicts.
- [x] Keep authentication, secrets, caches, histories and application state outside Git.
- [x] Keep ordinary shell startup free of network access.
- [x] Include dry-run, verification and rollback behavior from the beginning.
- [x] Build and review macOS independently before extracting Linux commonality.

## Target structure

```text
dotfiles-macos/
├── README.md
├── setup
├── Brewfile
├── packages.txt
├── stow/
│   ├── zsh/
│   ├── git/
│   ├── starship/
│   └── ...
└── scripts/
    ├── lib.sh
    ├── doctor.sh
    └── macos-defaults.sh
```

Only files justified by an implemented phase should be created. Empty placeholders and speculative abstractions are avoided.

## Command contract

The intended interface is:

```sh
./dotfiles-macos/setup install
./dotfiles-macos/setup check
./dotfiles-macos/setup restow
./dotfiles-macos/setup uninstall
```

Planned options:

```text
--dry-run          Show intended actions without mutation
--yes              Accept safe non-conflict prompts
--skip-brew        Skip Homebrew installation and bundle execution
--package NAME     Operate on one reviewed Stow package
```

Exact commands and flags remain provisional until implemented and tested. Do not publish a remote one-line installer before the complete behavior is auditable.

## Installation phases

The eventual `install` flow should execute these ordered phases:

1. Preflight platform, architecture, repository and dependency checks.
2. Xcode Command Line Tools and Homebrew installation when absent.
3. Reviewed `Brewfile` installation.
4. Conflict discovery and confirmed timestamped backup.
5. Platform bootstrap, including required XDG directories and `/etc/zshenv`.
6. Explicit Stow package deployment.
7. Package and system verification.
8. Manual authentication, licensing and approval handoff.

## Backup and rollback policy

- Default conflict behavior is to stop and explain.
- Confirmed backups go under `$XDG_STATE_HOME/dotfiles-macos/backups/<timestamp>/`, falling back to `~/.local/state/dotfiles-macos/backups/<timestamp>/`.
- A manifest records each original path, backup path, package and timestamp.
- `uninstall` removes only symlinks owned by this repository.
- Restoring displaced real files is separately confirmed.
- Setup never silently deletes user data.

## Initial package policy

`packages.txt` is the sole default Stow allowlist. It starts with only implemented and reviewed packages.

The first entry will be:

```text
zsh
```

Later candidates are added one at a time after their audits and configurations are approved.

## Component delivery model

The macOS setup grows one reviewed component at a time. Scripting is extended only as each component needs installation, configuration, verification or handoff behavior.

Every component moves through these gates:

1. **Decision** — confirm its role, recommendation, overlaps and macOS disposition from the audit.
2. **Dependencies** — add only approved formulae, casks, extensions or manual prerequisites.
3. **Configuration** — create a Stow package, tracked manifest, documented policy or no configuration, according to the component's ownership model.
4. **Setup integration** — add the smallest idempotent script behavior required for that component.
5. **Verification** — test installation, configuration discovery, state separation, reruns and removal where applicable.
6. **Review** — stop for approval before marking the component complete or starting the next one.

A component does not need a Stow package merely because it is listed. Its approved macOS disposition may be:

- **Configured** — durable files are Stowed.
- **Install only** — package/app installation is declarative; defaults are sufficient.
- **Manifest** — track a reviewed extension, plugin or restore list.
- **Manual** — document licensed, authenticated, hardware-bound or App Store setup.
- **Optional** — exclude from the default setup unless explicitly selected.
- **Omit** — retain the audit and intentionally do not install it.

## Component queue

Status legend: `active`, `pending`, `optional`, `provisional`, or `omit candidate`. Final disposition is confirmed at the component's decision gate.

### macOS experience and system baseline

These areas are reviewed in order. Each decision should capture the desired
experience, whether it is safely scriptable, its reversal path, and a concrete
verification step. We will commit one approved area at a time.

| Order | Area | Expected treatment | Status |
|---:|---|---|---|
| 1 | System baseline, identity, locale and time | Document supported macOS/architecture assumptions; script only non-sensitive stable settings | **active discussion** |
| 2 | Appearance | Review light/dark mode, accent, contrast, scroll bars and visual-motion preferences | pending |
| 3 | Keyboard | Review key repeat, initial delay, function-key behavior, shortcuts and input sources | pending |
| 4 | Text input | Review autocorrect, capitalization, smart quotes/dashes, spelling and substitutions | pending |
| 5 | Trackpad and mouse | Review tracking speed, tap/click, gestures, secondary click and scrolling | pending |
| 6 | Dock | Review size, magnification, auto-hide, recent apps, indicators and position | pending |
| 7 | Mission Control, Spaces and windows | Review Spaces behavior, window tiling, Stage Manager and desktop-reveal behavior | pending |
| 8 | Finder and Desktop | Review view defaults, path/status bars, extensions, search scope, hidden files and desktop items | pending |
| 9 | Menu bar and Control Center | Review clock, battery, control visibility and menu-bar organization | pending |
| 10 | Screenshots and screen recording | Review destination, format, naming, shadows and capture workflow | pending |
| 11 | Displays, sound and power | Document preferred behavior; keep hardware-specific layouts and device choices manual | pending |
| 12 | Default applications and file associations | Record intentional defaults and use idempotent tooling only where reliable | pending |
| 13 | Notifications and Focus | Document desired policy; prefer manual configuration where identifiers are unstable | pending |
| 14 | Login items and background services | Track an explicit reviewed list; do not copy opaque application state | pending |
| 15 | Privacy, security and accessibility approvals | Manual handoff for TCC, FileVault, Touch ID, extensions and privileged approvals | pending |
| 16 | Software updates and maintenance | Review automatic-update policy and document safe maintenance expectations | pending |

Review rules:

- Define the desired new-machine behavior rather than cloning every current value.
- Inspect the current host only as reference evidence.
- Classify each decision as scripted, documented manual step, or intentionally omitted.
- For scripted defaults, record the domain, key, value, reversal and verification.
- Do not automate credentials, iCloud enrollment, FileVault recovery material or
  macOS privacy-database modifications.
- Prefer supported UI configuration when a private or unstable defaults key would
  make the setup brittle.

### Shell and terminal foundation

| Component | Expected macOS treatment | Status |
|---|---|---|
| [Zsh](audits/zsh.md) | Configured package plus system bootstrap | **active** |
| [Antidote](audits/antidote.md) | Homebrew dependency, tracked plugin manifest, generated bundle | active with Zsh |
| [Eza](audits/eza.md) | Homebrew dependency and reviewed Zsh aliases | active with Zsh |
| [Zoxide](audits/zoxide.md) | Homebrew dependency and Zsh integration | active with Zsh |
| [Vivid](audits/vivid.md) | Homebrew dependency and generated Vesper `LS_COLORS` | active with Zsh |
| [Zsh Vi Mode](audits/zsh-vi-mode.md) | Antidote plugin if retained over native `bindkey -v` | active decision |
| [FZF](audits/fzf.md) | Configured package and shared selector integration | active with Zsh |
| [Starship](audits/starship.md) | Configured package and Vesper prompt | active with Zsh |
| [Ghostty](audits/ghostty.md) | Configured primary terminal package | pending |
| [Alacritty](audits/alacritty.md) | Optional configured fallback terminal | optional |
| [Tmux](audits/tmux.md) | Configured package | pending |
| [Sesh](audits/sesh.md) | Configured Tmux integration | pending |
| [Atuin](audits/atuin.md) | Configured shell integration; authentication remains local | pending |

### Editors, navigation and Git

| Component | Expected macOS treatment | Status |
|---|---|---|
| [Neovim](audits/neovim.md) | Configured package | pending |
| [Visual Studio Code](audits/visual-studio-code.md) | Configured files plus extension manifest | pending |
| [Git](audits/git.md) | Configured package with local identity include | pending |
| [GitHub CLI](audits/github-cli.md) | Sanitized config/extension manifest; authentication handoff | pending |
| [Lazygit](audits/lazygit.md) | Configured package | pending |
| [gh-dash](audits/gh-dash.md) | GitHub CLI extension plus configured package | pending |
| [Yazi](audits/yazi.md) | Configured package | pending |
| [Direnv](audits/direnv.md) | Minimal configured package | pending |
| [Bat](audits/bat.md) | Configured package with Vesper theme if justified | pending |
| [Ripgrep](audits/ripgrep.md) | Install only unless shared defaults are approved | pending |
| [fd](audits/fd.md) | Install only | pending |
| [Glow](audits/glow.md) | Configured package | pending |
| [Vimium](audits/vimium.md) | Sanitized import/extension manifest | pending |
| [Raycast](audits/raycast.md) | App install plus reviewed extension/restore manifest | pending |

### Development, AI and operations

| Component | Expected macOS treatment | Status |
|---|---|---|
| [Homebrew](audits/homebrew.md) | Platform package manifest and bootstrap foundation | pending foundation |
| [GNU Stow](audits/gnu-stow.md) | Install-only deployment dependency | pending foundation |
| [Pi](audits/pi.md) | Install plus sanitized authored configuration | pending |
| [OpenCode](audits/opencode.md) | Install plus sanitized configured package | pending |
| [Herdr](audits/herdr.md) | Install/configure after public portability review | provisional |
| [Supacode](audits/supacode.md) | Install/configure only after overlap and secret review | provisional |
| [Ollama](audits/ollama.md) | App/service install plus model handoff; models remain local | pending |
| [Lazydocker](audits/lazydocker.md) | Optional configured container TUI | provisional |
| [Btop](audits/btop.md) | Configured package | pending |
| [K9s](audits/k9s.md) | Configured package; cluster state remains local | pending |
| [lnav](audits/lnav.md) | Minimal configured package if needed | pending |
| [Logdy](audits/logdy.md) | Install/configure only if retained | provisional |
| [uv](audits/uv.md) | Install only as default Python workflow | pending |
| [pnpm](audits/pnpm.md) | Install only; project versions remain project-owned | pending |
| [jq](audits/jq.md) | Install only | pending |
| [fx](audits/fx.md) | Install only | pending |
| [xh](audits/xh.md) | Install only | pending |
| [FFmpeg](audits/ffmpeg.md) | Install only with reviewed formula variant | pending |
| [Wget](audits/wget.md) | Install only | pending |
| [Gum](audits/gum.md) | Install only when setup UX uses it | pending |
| [Speedtest](audits/speedtest.md) | Exclude unless Ookla-compatible results are required | omit candidate |

### Browsers, productivity and communication

| Component | Expected macOS treatment | Status |
|---|---|---|
| [Google Chrome](audits/google-chrome.md) | App install plus minimal extension manifest | pending |
| [Obsidian](audits/obsidian.md) | App install and vault/config ownership policy | pending |
| [Stats](audits/stats.md) | App install; preferences only if portable | pending |
| [CleanShot X](audits/cleanshot-x.md) | Licensed/manual setup with Raycast integration | pending |
| [Homerow](audits/homerow.md) | App install and accessibility handoff | pending |
| [Discord](audits/discord.md) | App install and authentication handoff | pending |
| [Dashlane](audits/dashlane.md) | App/extension install and secure enrollment handoff | pending |
| [Proton VPN](audits/proton-vpn.md) | App install and network-extension/auth handoff | pending |
| [ChatGPT](audits/chatgpt.md) | App install and authentication handoff | pending |
| [Alcove](audits/alcove.md) | Install only if utility survives review | provisional |
| [Antinote](audits/antinote.md) | App install/manual restore | pending |
| [FluidVoice](audits/fluidvoice.md) | App install and permissions handoff | pending |
| [Plaud](audits/plaud.md) | App install and authenticated service handoff | pending |

### Hardware, photography and media

| Component | Expected macOS treatment | Status |
|---|---|---|
| [Orca](audits/orca.md) | Optional future-machine install | optional |
| [Bazecor](audits/bazecor.md) | Hardware-bound app install/manual setup | pending |
| [Vial](audits/vial.md) | Hardware-bound app install/manual setup | pending |
| [Logi Options+](audits/logi-options-plus.md) | Hardware driver/app install and permissions handoff | pending |
| [Capture One](audits/capture-one.md) | Licensed manual install and catalog/session policy | pending |
| [DaVinci Resolve](audits/davinci-resolve.md) | App install and licensed/manual setup | pending |
| [Darkroom](audits/darkroom.md) | Optional App Store install pending editor-role decision | optional |
| [Photomator](audits/photomator.md) | Optional App Store install pending editor-role decision | optional |
| [ON1 Photo RAW](audits/on1-photo-raw.md) | Licensed manual install pending unique-role decision | optional |

## Implementation plan

### Phase 0 — Tracker and architecture

- [x] Approve the turnkey scripted approach.
- [x] Record directory, command, safety and rollback contracts.
- [x] Define phased review gates.
- [x] Add the per-component delivery model and complete macOS component queue.
- [x] Review and approve the component-oriented tracker.

**Review gate:** Approve the component-oriented tracker before creating `dotfiles-macos/`.

### Phase 1 — Minimal platform skeleton

- [x] Create `dotfiles-macos/README.md` with scope and current usage.
- [x] Create the executable `dotfiles-macos/setup` entry point.
- [x] Create `dotfiles-macos/packages.txt` without speculative packages.
- [x] Create `dotfiles-macos/Brewfile` with only Zsh-subsystem prerequisites.
- [x] Create `dotfiles-macos/stow/` only when the first package is added.
- [x] Avoid empty helper scripts until logic needs extraction.
- [x] Verify paths are derived from the script location.

**Review gate:** Review the structure and public interface before adding installer behavior.

### Phase 2 — Safe setup foundation

- [x] Implement `help` and invalid-command behavior.
- [x] Implement macOS and architecture preflight.
- [x] Implement location-independent repository-root discovery.
- [x] Implement explicit package-list parsing and validation.
- [x] Implement `--dry-run` without mutation.
- [x] Implement single-package selection.
- [ ] Implement Stow simulation with explicit `--dir`, `--target` and `--no-folding`.
- [x] Implement readable pass, warning and failure output.
- [x] Add non-mutating shell syntax checks.

**Review gate:** Run only non-mutating checks and review results before enabling installation or backups.

### Phase 3 — Zsh package

- [x] Re-review [Zsh audit](audits/zsh.md) and legacy/live references.
- [x] Create the approved XDG file layout under `stow/zsh/.config/zsh/`.
- [x] Implement `.zshenv`, `.zprofile` and `.zshrc` responsibilities.
- [x] Implement reviewed aliases, functions, bindings, FZF and prompt modules.
- [x] Add Antidote manifest and static loading policy.
- [x] Finalize the initial three-plugin inventory and load order.
- [x] Apply Vesper to shell-visible integrations.
- [x] Keep history, caches, completion dumps, plugins and generated bundles outside Git.
- [ ] Validate interactive, login, non-interactive and non-TTY behavior.
- [ ] Benchmark against the approximately 47–57 ms live warm-start reference.

**Review gate:** Review every Zsh file and test result before connecting it to mutating setup behavior.

### Phase 4 — Zsh bootstrap and deployment

- [ ] Add required Zsh, Antidote, FZF and integration dependencies to the Brewfile.
- [ ] Implement XDG directory creation.
- [ ] Implement the minimal `/etc/zshenv` bootstrap with explicit privilege escalation.
- [ ] Implement explicit Antidote plugin installation and static bundle generation.
- [ ] Implement conflict detection and confirmed backup for Zsh-owned paths.
- [ ] Enable `install`, `restow` and `uninstall` for the Zsh package.
- [ ] Record backup manifests.
- [ ] Ensure reruns are idempotent.

**Review gate:** Review all intended mutations and rollback behavior before running installation on the current host.

### Phase 5 — Current-host verification

- [ ] Run complete dry-run against the current host.
- [ ] Explain every detected conflict and proposed backup.
- [ ] Verify no private or mutable paths would enter Git.
- [ ] Install only after explicit approval.
- [ ] Verify all repository-owned symlinks.
- [ ] Test fresh login, interactive shell, command shell and terminal behavior.
- [ ] Verify rollback without data loss.
- [ ] Record results and remaining manual steps.

**Review gate:** Approve Zsh as the first completed macOS package before expanding the allowlist.

### Phase 6 — Turnkey completion

- [ ] Repeat the decision-to-review delivery model for every retained component.
- [ ] Grow the Brewfile only as approved components require dependencies.
- [ ] Grow `packages.txt` only as reviewed Stow packages are completed.
- [ ] Complete the macOS experience review queue one approved area at a time.
- [ ] Add approved macOS defaults with reversible documentation.
- [ ] Implement the final doctor and handoff report.
- [ ] Document authentication, licenses, security approvals and manual imports.
- [ ] Test from a clean macOS environment.
- [ ] Publish the final clone-and-install command only after clean-machine verification.

**Review gate:** Approve the complete macOS setup before beginning Linux implementation or extracting shared components.

## Non-goals for the first Zsh milestone

- Reproducing every application installed on the current host.
- Applying every macOS preference.
- Building the Linux setup concurrently.
- Abstracting shared macOS/Linux configuration prematurely.
- Automatically restoring authentication or application databases.
- Deleting legacy host files or backups.
