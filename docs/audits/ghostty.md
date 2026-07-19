# Ghostty

## Role

Be the primary macOS terminal, supplying native windows/tabs, fast rendering, shell integration, and a consistent visual foundation.

## Recommendation

Adopt as primary. Start from defaults and carry forward only verified ergonomics: Vesper, Nerd Font, modest padding, Option-as-Alt, non-blinking block cursor, safe clipboard behavior, working-directory inheritance, and Shift-Enter. Reconsider extreme scrollback and disabled close confirmation.

## Modern baseline

Ghostty supports XDG configuration, live reload, built-in themes, `+show-config`, and `+validate-config`. On macOS, the Application Support config may take precedence over XDG and can make Command-, open a different file; bootstrap must remove or neutralize that competing file. Effective config should be verified rather than inferred.

## Host and legacy audit

Ghostty is installed with `~/.config/ghostty/config`. The legacy config has good macOS integration but a 50-million-byte scrollback, automatic downloads, and `confirm-close-surface = false`; these are policy choices, not safe defaults. Rosé Pine must be replaced by Vesper.

## Configuration ownership

Track `ghostty/.config/ghostty/config` plus a Vesper theme only if needed. Install the signed app and font through bootstrap. Keep window/session state, update state, logs, and macOS-generated Application Support data local.

## Integration notes

Tmux remains the durable multiplexer; avoid duplicating its navigation model in Ghostty. Validate terminfo over SSH and preserve OSC 52/clipboard safety. Coordinate font and key protocol behavior with Neovim and Tmux.

## Open decisions

- Ghostty native tabs/splits versus using Tmux for all multiplexing.
- App-managed stable updates versus Homebrew-cask-managed updates.

## Sources

- [Ghostty quick start](https://ghostty.org/docs/install/binary#macos)
- [Ghostty configuration reference](https://ghostty.org/docs/config/reference)
- [Ghostty `show-config`](https://ghostty-org-ghostty.mintlify.app/cli/show-config)
- [macOS XDG precedence discussion](https://github.com/ghostty-org/ghostty/discussions/5516)
- Researched 2026-07-13.
