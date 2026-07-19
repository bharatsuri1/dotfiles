# pnpm

## Role

Provide fast, disk-efficient JavaScript package and workspace management.

## Recommendation

Retain for projects that declare pnpm. Respect each project's `packageManager` field and lockfile; do not force pnpm onto npm/bun/yarn projects.

## Modern baseline

pnpm supports content-addressed storage, workspaces, strict dependency layouts, and version selection through Corepack or pnpm's own tooling. Modern projects should pin the package-manager version and commit `pnpm-lock.yaml`. Global package installation should be rare.

## Host and legacy audit

pnpm is installed through Homebrew. No global pnpm configuration or durable legacy files were found.

## Configuration ownership

Bootstrap owns the executable/version mechanism. Projects own `package.json`, `pnpm-workspace.yaml`, `.npmrc`, and lockfiles. Dotfiles may own only neutral global policy. Store data, global packages, credentials, auth-bearing npmrc files, and project caches remain local.

## Integration notes

Coordinate PATH with Zsh and avoid duplicate Node version managers. Direnv may select project runtimes. pnpm overlaps with npm, Bun, and Corepack; repository metadata decides. Vesper is not applicable.

## Open decisions

- Homebrew pnpm versus Corepack/package-manager version management.
- Which Node runtime/version manager, if any, owns Node itself.

## Sources

- [pnpm installation](https://pnpm.io/installation)
- [pnpm settings](https://pnpm.io/settings)
- [Node Corepack documentation](https://nodejs.org/api/corepack.html)
- [package.json `packageManager`](https://nodejs.org/api/packages.html#packagemanager)
- Researched 2026-07-13.
