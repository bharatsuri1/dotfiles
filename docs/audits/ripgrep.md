# Ripgrep (`rg`)

## Role

Provide the default recursive text-search engine for the shell, FZF, Neovim, Yazi, and scripts.

## Recommendation

Retain. Prefer its excellent defaults and initially omit a global config. Add an XDG config only for universal, unsurprising behavior; never globally enable hidden, follow-symlink, or ignore-bypassing searches.

## Modern baseline

Ripgrep respects Git ignore rules by default and skips hidden/binary files. It does not automatically discover a config file: `RIPGREP_CONFIG_PATH` must point to one, and explicit CLI arguments are applied after config defaults. `--no-config` provides deterministic script behavior. Global ignore policy is better expressed through Git's global ignore file when it should apply consistently.

## Host and legacy audit

Homebrew Ripgrep 15.1.0 is installed. No legacy Ripgrep config exists, which is already close to the ideal baseline. Existing consumers in Yazi and other tools validate its role.

## Configuration ownership

Track nothing initially. If needed later, track `ripgrep/.config/ripgrep/config` and set `RIPGREP_CONFIG_PATH` from Zsh. Search histories, outputs, indexes, and project-specific ignore rules remain outside this package.

## Integration notes

Neovim, FZF, Yazi, and editor search should rely on normal ignore semantics. Use explicit flags at the call site for hidden files or special preprocessors so those costs and semantics are visible.

## Open decisions

- Whether any universal override survives a defaults-first trial.

## Sources

- [Official Ripgrep guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
- [Ripgrep repository](https://github.com/BurntSushi/ripgrep)
- [Ripgrep configuration discussion](https://www.reddit.com/r/commandline/comments/uja9kl/ripgrep_grep_but_better/)
- Researched 2026-07-13.
