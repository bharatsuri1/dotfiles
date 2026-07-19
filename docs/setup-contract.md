# Setup Contract

This document defines the safety and ownership rules for the reproducible macOS and Linux setups. The goal is a focused, intentional environment that makes a new machine productive quickly without mirroring an entire home directory.

## Repository boundary

- The repository is public; every tracked file must be safe to publish.
- Track durable configuration, bootstrap policy and human-readable restore manifests.
- Never track credentials, tokens, private keys, identity material, application databases, histories, sessions, caches, logs, generated state or machine identifiers.
- Keep local and machine-specific overrides ignored and explicitly sourced only where required.
- Treat `dotfiles-legacy/` and the current host as evidence, not as automatic sources of truth.

## Platform layout

- Platform-specific packages will live under `dotfiles-macos/` and `dotfiles-linux/`.
- Each platform tree should contain a complete, independently understandable setup for that operating system.
- Share policy and documentation at the repository level; duplicate a small configuration intentionally when that keeps each platform setup reproducible and clear.
- Do not introduce cross-platform abstraction until actual duplication proves it useful.

## Configuration ownership

Every audited component must distinguish among:

1. **Tracked configuration** — portable, durable files deployed from the repository.
2. **Bootstrap ownership** — packages, directories, generated bundles and explicit installation steps.
3. **Local state** — authentication, history, caches, databases, runtime files and machine-specific values that remain outside Git.

Application-managed directories must not be linked wholesale when they mix durable preferences with mutable or private state.

## GNU Stow rules

- Use tree-mirror package layouts targeting `$HOME`.
- Packages must be independently installable and removable.
- Use an explicit reviewed package allowlist; never run `stow */`.
- Preview changes before mutation.
- Do not use `stow --adopt` as a routine migration shortcut.
- Do not overwrite existing real files without backup and explicit confirmation.
- Use file-level links inside application-managed directories when owning the directory would capture unrelated state.
- Add platform-specific Stow defaults only when the first real package is ready and their target is unambiguous.

## Bootstrap rules

- Bootstrap must be boring, readable, idempotent and safe to rerun.
- Verify platform and architecture assumptions before installation.
- Install prerequisites and package managers before consuming manifests.
- Install only an explicit reviewed set of packages.
- Keep shell startup network-free; plugin downloads and generated bundles belong to bootstrap or explicit maintenance commands.
- Stop or ask before replacing existing user files.
- Print manual steps for authentication, licenses, SSH keys, security approvals and application-specific imports.
- Do not promise a one-line installer until its complete behavior is reviewable in the repository.

## Local overrides

Portable configuration may support guarded local includes such as:

- `~/.zshenv.local`
- `~/.zprofile.local`
- `~/.zshrc.local`
- `~/.gitconfig.local`
- Project-specific `.envrc.local`

Local includes must remain optional, quiet when absent and ignored by Git. Secrets should use an appropriate credential manager rather than being collected into a generic dotfiles secrets file.

## Change workflow

- Migrate and verify one package or cohesive subsystem at a time.
- Review live and legacy configuration before carrying anything forward.
- Favor modern defaults and small override-only files.
- Record meaningful policy and decisions; defer low-level implementation details until implementation.
- Give visual packages the canonical Vesper palette.
- Verify installation, startup, configuration discovery, state separation and removal/rollback.
- Commit coherent checkpoints so the setup always has a recoverable history.

## Authentication and restore boundary

Authentication is restored through supported login flows, not copied state. Examples include GitHub CLI login, password-manager enrollment, VPN approval, application licenses, cloud synchronization and local-model downloads. Human-readable checklists may be tracked; exported secrets and session files may not.

## Completion criteria

A platform setup is complete when it can:

- Explain prerequisites and supported assumptions.
- Install its reviewed package manifest.
- Deploy an explicit package allowlist without overwriting user data.
- Identify every manual authentication or approval step.
- Pass package-specific smoke tests.
- Remove or restow packages cleanly.
- Explain how to recover from a partial bootstrap.

Promoted from local planning material on 2026-07-18.
