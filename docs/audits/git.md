# Git

## Role

Own source-control defaults, identity routing, signing policy, diff behavior, global ignores, and safe command-line ergonomics.

## Recommendation

Retain and make Homebrew Git the intentional implementation so features do not depend on the macOS Command Line Tools release. Build a minimal XDG global config with safe defaults and conditional includes for identities; never commit identity values.

## Modern baseline

Git supports XDG global config at `$XDG_CONFIG_HOME/git/config` and global ignore files through `core.excludesFile`. Conditional includes (`includeIf`) cleanly separate personal/work identities by repository path. Prefer `init.defaultBranch`, `pull.ff`/`pull.rebase` as an explicit policy, `fetch.prune`, `push.autoSetupRemote`, `rerere`, modern diff coloring, and a credential helper backed by macOS Keychain. Avoid aliases that hide destructive behavior.

## Host and legacy audit

The active global Git config contains only identity keys. Legacy dotfiles track a useful global ignore file but no global config. Identity values were intentionally not inspected or reproduced. Apple Git 2.50.1 is active even though Homebrew is the intended package manager.

## Configuration ownership

Track `git/.config/git/config` without identity and `git/.config/git/ignore`. Track conditional-include structure only if it uses generic paths; place identity/signing material in ignored local include files or bootstrap prompts. Credentials, SSH keys, signing private keys, and repository-local config remain local.

## Integration notes

Lazygit and `gh` inherit Git editor, pager, credential, and protocol decisions. Delta/difftastic, signing, and SSH policy should be decided inside this audit rather than independently. Vesper affects pager colors, not core Git.

## Open decisions

- Rebase versus fast-forward-only pull policy.
- SSH versus HTTPS transport and commit-signing method.
- Whether to adopt Delta as the shared pager.

## Sources

- [Git configuration](https://git-scm.com/docs/git-config)
- [Conditional includes](https://git-scm.com/docs/git-config#_conditional_includes)
- [Git ignore patterns](https://git-scm.com/docs/gitignore)
- [Git credential storage](https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage)
- Researched 2026-07-13.
