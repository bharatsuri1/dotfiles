# Homebrew

## Role

Be the primary declarative installer for command-line tools, GUI casks, fonts, and selected application integrations on a new Mac.

## Recommendation

Retain and replace the legacy flat package dump with a curated `Brewfile` organized by purpose. Include only intentional packages from the tracker; avoid blindly reproducing every leaf, tap, or application found on the current host.

## Modern baseline

`brew bundle` is Homebrew's declarative interface and is idempotent. A Brewfile can manage formulae, casks, Mac App Store apps, VS Code extensions, and other supported ecosystems. Homebrew is rolling-release and Brewfile has no lockfile, so it describes desired packages, not exact versions. `brew bundle check` and `brew bundle cleanup` support audit, but cleanup must remain explicitly reviewed.

## Host and legacy audit

Homebrew 6.0.9 is installed at the Apple Silicon prefix. The legacy `brew/list.txt` is a large inventory that includes many assigned tools but lacks type/context and should only be used as evidence. Several tools are installed outside Homebrew (Atuin, OpenCode, Herdr), which should be normalized only when an official/reliable formula exists.

## Configuration ownership

Track a repo-root or `homebrew/Brewfile` plus optional bootstrap scripts. Do not track `brew bundle dump` output without review, analytics IDs, caches, cellar state, receipts, credentials, or service runtime state. The bootstrap must install Command Line Tools/Homebrew before invoking Bundle.

## Integration notes

Homebrew is installation ownership, not runtime configuration ownership. Each app's audit decides config. Prefer casks/formulae over app self-updaters when that avoids two competing update mechanisms; document deliberate exceptions.

## Open decisions

- One Brewfile versus small platform/role includes.
- Whether Mac App Store applications and VS Code extensions belong in Brewfile or their own reviewed manifests.

## Sources

- [Homebrew Bundle and Brewfile](https://github.com/Homebrew/brew/blob/main/docs/Brew-Bundle-and-Brewfile.md)
- [Homebrew installation](https://docs.brew.sh/Installation)
- [Homebrew FAQ](https://docs.brew.sh/FAQ)
- [Homebrew analytics](https://docs.brew.sh/Analytics)
- Researched 2026-07-13.
