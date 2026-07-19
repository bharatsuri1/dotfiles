# Zsh Vi Mode

## Role

Provide consistent Vim-style command-line editing, text objects and mode-aware widgets in interactive Zsh.

## Recommendation

Retain Zsh Vi Mode, but let Antidote manage it with the other Zsh plugins rather than Homebrew managing this single plugin separately. Start in insert mode, use a deliberately chosen escape timeout, and place all dependent key bindings in the plugin's post-initialization hook.

## Modern baseline

Zsh includes native `bindkey -v`, so the plugin must justify itself through better operators, text objects, surround behavior, visual mode and predictable hooks. Plugin initialization changes keymaps; ordering and hook usage are therefore correctness requirements, not micro-optimizations. Clipboard integration should be reviewed against macOS privacy and terminal behavior rather than enabled automatically.

## Host and legacy audit

Zsh Vi Mode 0.12.0 is installed through Homebrew. Legacy settings used insert mode, a `0.01` second key timeout and system clipboard integration, then restored Atuin and custom bindings in `zvm_after_init`. Preserve the hook pattern. Reassess the extremely short timeout and clipboard behavior. Avoid retaining two package-management paths once Antidote is adopted.

## Configuration ownership

Track the plugin declaration in `.zsh_plugins.txt`, configuration variables before plugin loading, and post-init bindings in `bindings.zsh`. The plugin clone and generated load bundle remain outside Git. No runtime state should be tracked.

## Integration notes

Load before autosuggestions and final syntax highlighting. Atuin's `Ctrl-R`, search and up-line bindings must be applied after Vi Mode creates its keymaps. FZF widgets need the same review. Prompt mode indicators, if desired, belong to the Starship/Zsh integration and should use Vesper colors.

## Open decisions

- Confirm that the plugin adds enough value over native `bindkey -v`.
- Final `KEYTIMEOUT`, initial mode and system clipboard policy.
- Whether a mode indicator is useful or visual noise.

## Sources

- [Zsh Vi Mode repository and configuration hooks](https://github.com/jeffreytse/zsh-vi-mode)
- [Zsh line editor documentation](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html)
- [Homebrew Zsh Vi Mode formula](https://formulae.brew.sh/formula/zsh-vi-mode)
- Local host and legacy Zsh audit, 2026-07-13.
