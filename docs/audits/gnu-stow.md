# GNU Stow

## Role

Deploy independently selectable dotfile packages into `$HOME` as transparent symlinks while keeping the repository layout obvious.

## Recommendation

Retain as the dotfiles deployment mechanism. Use one package per audited tool, mirror final target paths directly, run from the repository with explicit `--target="$HOME"`, and preview changes before mutating. Do not use `--adopt` as a routine migration shortcut.

## Modern baseline

Stow treats each directory under the stow directory as a package and the parent directory as the default target; explicit directory/target arguments make automation safer. It detects conflicts rather than overwriting normal files. `--restow` repairs/refreshes packages and `--delete` removes links. The `--dotfiles` name translation is optional; mirrored `.config` trees are clearer here.

## Host and legacy audit

Homebrew GNU Stow 2.4.1 is installed. The repo's legacy migration plan and current tracker already establish package-shaped XDG paths. The staged legacy tree must remain reference-only and never become a Stow package accidentally.

## Configuration ownership

Track package directory structure and a reviewed bootstrap/helper command, not user-level `.stowrc` unless it is genuinely portable. Stow creates symlinks only; it must not own generated state. Backups of preexisting files stay outside the repository and should be handled explicitly during migration.

## Integration notes

Homebrew installs Stow before any package deployment. Packages should be independently stowable and deletable. macOS paths outside `$HOME/.config` (notably VS Code) can still be mirrored, but directories containing application-managed state require file-level links to avoid owning the whole tree.

## Open decisions

- Exact bootstrap interface for dry-run, install, restow, and uninstall.
- Whether macOS GUI app preferences that cannot be safely symlinked are handled by `defaults` commands instead.

## Sources

- [GNU Stow 2.4.1 manual](https://www.gnu.org/software/stow/manual/stow.html)
- [GNU Stow project](https://www.gnu.org/software/stow/)
- [Current community package-layout discussion](https://www.reddit.com/r/linux/comments/1jrf8c4/how_do_you_use_gnu_stow_entire_config_folder_stow/)
- Researched 2026-07-13.
