# Zsh

## Role

Provide the interactive shell and the small, durable integration layer that connects command-line tools on macOS.

## Recommendation

Retain the approved XDG-oriented design: use Apple's `/bin/zsh`, set `ZDOTDIR` once in `/etc/zshenv`, keep durable files under `~/.config/zsh`, and deploy them from `zsh/.config/zsh/` with GNU Stow. Keep the shell modular, quiet for non-interactive invocations, and measurable. Do not carry Oh My Zsh forward.

## Modern baseline

Zsh reads `/etc/zshenv` before `$ZDOTDIR/.zshenv`; login shells then read `.zprofile`, and interactive shells read `.zshrc`. The system bootstrap therefore contains only the `ZDOTDIR` export. Portable XDG variables belong in `.zshenv`, login environment and path setup in `.zprofile`, and interactive plugins, completion, bindings and prompt initialization in `.zshrc` modules.

Use native Zsh features before plugins. Keep startup network-free, generate expensive integration code during bootstrap or explicit maintenance, and benchmark warm and cold starts with Hyperfine before optimizing with caches or `zcompile`.

## Host and legacy audit

The host uses Apple's Zsh 5.9. Warm startup samples from the live tuned shell were approximately 47–57 ms and provide a useful regression baseline. The legacy tree contains both an older Oh My Zsh configuration and a later modular design document. Useful intent includes modular files, explicit plugin ordering, Atuin-aware bindings, XDG state separation, Cargo/Rustup completions and startup measurement. Historical Catppuccin/Rose Pine values, automatic cache machinery, the `cd=z` alias, duplicate `compinit` logic and unconditional shell-start output are references only, not defaults. Non-TTY interactive checks also exposed FZF scripts attempting to restore ZLE options; the clean setup must guard widget initialization appropriately.

## Configuration ownership

Track `.zshenv`, `.zprofile`, `.zshrc`, aliases, bindings, functions, FZF integration, plugin manifest/loading and prompt initialization. Bootstrap owns `/etc/zshenv`, Homebrew packages and generated plugin bundles. History, completion dumps, bytecode, plugin clones, caches, logs, secrets and machine-specific paths remain outside Git under XDG state/cache/data locations as appropriate.

## Integration notes

Antidote should generate a static load file outside the repository. Zsh Vi Mode must initialize before bindings that depend on its keymaps; syntax highlighting must load after widgets and keymaps are final. Starship remains the prompt owner. Eza and Zoxide should be exposed through explicit aliases/functions rather than surprising replacement of core commands. Visual shell surfaces should use Vesper.

## Open decisions

- Final plugin inventory and exact load order.
- Whether compiled Zsh files measurably improve startup enough to justify invalidation logic.
- Whether Zoxide should receive a dedicated command or replace interactive `cd`.
- Whether existing Cargo and Rustup completions remain necessary and portable.
- Post-migration cleanup of unused Oh My Zsh, legacy FZF bootstrap, compiled files and old backups only after the new shell passes verification.

## Sources

- [Zsh startup files](https://zsh.sourceforge.io/Doc/Release/Files.html)
- [Zsh options](https://zsh.sourceforge.io/Doc/Release/Options.html)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/)
- Local host and `dotfiles-legacy/zsh` audit, 2026-07-13.
