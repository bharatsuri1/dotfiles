# gh-dash

## Role

Provide a focused terminal dashboard for GitHub pull requests, issues, and notifications.

## Recommendation

Retain. Preserve the useful role-based sections, simplify presentation, and replace Catppuccin colors with Vesper.

## Modern baseline

gh-dash is a GitHub CLI extension and relies on `gh` authentication. Its YAML config supports search-based sections, previews, keybindings, repo paths, and themes. Keep filters generic and use `@me`; avoid repository-specific paths in a public setup.

## Host and legacy audit

A substantial legacy config defines PR, issue, and notification sections, sensible refresh intervals, preview layout, and Catppuccin colors. The workflow is portable and worth retaining after review. The host has gh-dash installed as a `gh` extension rather than a Homebrew formula.

## Configuration ownership

Bootstrap should install the extension. Stow owns `~/.config/gh-dash/config.yml`. GitHub tokens, authentication state, host data, caches, and private repository paths remain local.

## Integration notes

Requires `gh`; overlaps with GitHub web UI and Lazygit only partially. Use Vesper colors while keeping success, warning, and error semantic. Pager/diff behavior should align with the Git audit.

## Open decisions

- Whether notifications belong in this dashboard or should remain in Raycast/browser.
- Whether author icons are worth terminal rendering and network overhead.

## Sources

- [gh-dash repository and configuration](https://github.com/dlvhdr/gh-dash)
- [GitHub CLI extension documentation](https://docs.github.com/en/github-cli/github-cli/using-github-cli-extensions)
- [GitHub search syntax](https://docs.github.com/en/search-github/searching-on-github/searching-issues-and-pull-requests)
- Researched 2026-07-13.
