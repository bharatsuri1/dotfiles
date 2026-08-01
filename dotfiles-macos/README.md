# dotfiles-macos

Turnkey, review-gated macOS setup. The current milestone implements the Zsh
subsystem as an isolated, inspectable artifact; it does not yet modify the live
host.

## Review commands

Run these from any directory:

```sh
./dotfiles-macos/setup check
./dotfiles-macos/setup install --dry-run
./dotfiles-macos/setup install --dry-run --package zsh
```

`install`, `restow`, and `uninstall` currently require `--dry-run`. Mutating
deployment remains disabled until the Zsh package and its intended host changes
have been reviewed.

## Zsh design

- macOS `/etc/zshenv` sets `ZDOTDIR`; the proposed file is tracked at
  `system/etc/zshenv` for review.
- Durable shell configuration lives in `stow/zsh/.config/zsh/`.
- History and generated integration files live under XDG state/cache paths.
- Antidote clones and bundle generation happen only during explicit preparation,
  never during shell startup.
- FZF, Starship, Vivid and Zoxide configuration is included in this cohesive
  shell milestone while remaining independently Stowable.
- Optional machine-local overrides may be placed at `~/.zshenv.local`,
  `~/.zprofile.local`, and `~/.zshrc.local`.

The later mutating installer will create XDG directories, prepare generated
files, discover conflicts, back up confirmed files, install `/etc/zshenv`, and
Stow only the packages listed in `packages.txt`.
