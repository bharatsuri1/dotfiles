# Antidote

## Role

Install and assemble a small, explicit set of Zsh plugins without turning shell startup into a package-management operation.

## Recommendation

Adopt Antidote as already selected, installed through Homebrew and used in static-bundle mode. Track the plugin manifest; generate the sourceable bundle explicitly during bootstrap or maintenance. Normal shell startup must only source the generated file and must never clone, update or regenerate plugins.

## Modern baseline

Antidote is a Zsh-native, MIT-licensed manager whose `.zsh_plugins.txt` manifest preserves source and order. Its documented static mode produces a `.zsh` load file, which is the right performance and reliability model here. Pinning every plugin commit is optional initially, but upgrades should remain intentional and reviewable.

## Host and legacy audit

Antidote is not currently installed. The legacy setup used a mix of Homebrew-managed and manually cloned plugins and documented strict ordering. Carry forward the ordering requirement, not the mixed installation strategy or plugin clones inside configuration directories.

## Configuration ownership

Track `.zsh_plugins.txt` and minimal loader/update functions. Homebrew owns Antidote itself. Put plugin clones under `$XDG_CACHE_HOME/antidote` as the selected disposable model and the generated static bundle under `$XDG_CACHE_HOME/zsh`. Neither belongs in Stow or Git.

## Integration notes

The manifest should remain short. Zsh Vi Mode loads before dependent bindings, autosuggestions before final syntax highlighting, and prompt ownership stays with Starship. Plugin updates should be a documented maintenance command, potentially exposed through the future bootstrap task runner.

## Open decisions

- Final plugin list and whether any entry needs an explicit revision pin.
- Exact update/regeneration command and failure behavior when the generated bundle is absent.

## Sources

- [Antidote repository and static loading guidance](https://github.com/mattmc3/antidote)
- [Antidote documentation](https://antidote.sh/)
- [Homebrew Antidote formula](https://formulae.brew.sh/formula/antidote)
- Local host and legacy Zsh audit, 2026-07-13.
