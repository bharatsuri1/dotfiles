# Neovim

## Role

Provide the primary terminal editor and code-review surface with strong language tooling while remaining understandable and recoverable.

## Recommendation

Retain Neovim and retain LazyVim as a curated baseline, but rebuild from the current LazyVim starter rather than copying the old tree. Add only languages actively used and a Vesper theme integration. Keep custom Lua small.

## Modern baseline

Neovim follows XDG paths: configuration in `$XDG_CONFIG_HOME/nvim`, plugins/data in XDG data, logs/state in XDG state, and caches in XDG cache. Lua is the native configuration language. LazyVim expects a starter configuration and lazy.nvim lockfile; generated plugin data must stay outside Git.

## Host and legacy audit

Homebrew Neovim 0.12.4 is installed. Legacy config is a mostly stock LazyVim v8 setup with JSON, Markdown, Python, TOML and Yanky extras, a Rosé Pine override, and a checked-in `lazy-lock.json`. This is a useful inventory, not a clean base. No meaningful custom options were found.

## Configuration ownership

Track the intentional Lua config, `lazyvim.json`, formatter config, and plugin lockfile if reproducibility is desired. Bootstrap installs Neovim and external CLI/LSP dependencies through their owning package managers. Never track plugin downloads, undo/swap files, logs, sessions, provider credentials, or local project state.

## Integration notes

Use Vesper consistently and verify true color in both terminals and Tmux. Reuse system tools (`rg`, `fd`, `fzf`, `lazygit`, `bat`) instead of redundant plugins where practical. Keep Git operations and terminal navigation bindings coherent with Lazygit and Zsh vi mode.

## Open decisions

- Commit the plugin lockfile for exact reproducibility or accept rolling plugin updates.
- Final language extras based on actual work, not historical availability.

## Sources

- [Neovim startup and standard paths](https://neovim.io/doc/user/starting/)
- [Neovim Lua guide](https://neovim.io/doc/user/lua-guide/)
- [LazyVim installation](https://www.lazyvim.org/installation)
- [LazyVim configuration](https://www.lazyvim.org/configuration)
- Researched 2026-07-13.
