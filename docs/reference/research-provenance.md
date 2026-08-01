# Research Provenance

This document records the upstream repositories consulted during the dotfiles
rebuild. The local research clones remain disposable and ignored; only their
source, reviewed revision and purpose are durable project records.

Snapshot date: 2026-07-18

| Project | Source | Reviewed revision | Purpose |
|---|---|---|---|
| Alacritty themes | <https://github.com/alacritty/alacritty-theme> | `03cce642656759f440c97bb99ce65fc1c5b064a1` | Canonical Vesper terminal palette reference |
| Radley Lewis dotfiles | <https://github.com/radleylewis/dotfiles> | `f4d020277e3b2621ba509e6232885d3c6b2cc952` | Home-tree ownership and setup-flow reference |
| Radley Lewis Zsh | <https://github.com/radleylewis/zsh> | `2edf9f4c271ae1bee91e6e4e30db5ce580810d27` | XDG Zsh layout, modular shell organization and documentation reference |
| Original Vesper | <https://github.com/raunofreiberg/vesper> | `9043f3849b776949445f0cd4990365959cca35a3` | Original editor theme and semantic color reference |
| Cross-application Vesper | <https://github.com/vladzima/vesper-theme> | `b60c51b1de89bde934c6c09541e7fec8996a900a` | Cross-application ports and reduced terminal palette reference |

## Use policy

- These repositories are references, not vendored dependencies.
- Their licenses and histories remain with their upstream projects.
- Configuration is carried forward only after review and adaptation to this
  repository's setup contract.
- Repeating research should record a new snapshot date and revision instead of
  silently changing the historical record.
