# Vesper Palette

Vesper is the visual baseline for new and rebuilt configuration. Existing Rosé Pine and Catppuccin files remain reference material only and should be converted when a package is reviewed or migrated, not through unrelated theme-only churn.

## Sources

- [Cross-application Vesper ports](https://github.com/vladzima/vesper-theme)
- [Original Vesper VS Code theme](https://github.com/raunofreiberg/vesper)
- [Alacritty Vesper port](https://github.com/alacritty/alacritty-theme/blob/master/themes/vesper.toml)

## Semantic palette

Use these semantic roles for application chrome, prompts, status lines and TUIs:

| Role | Value |
|---|---:|
| Background | `#101010` |
| Foreground / primary text | `#FFFFFF` |
| Accent / warning / modified / functions | `#FFC799` |
| Accent hover | `#FFCFA8` |
| Success / added / strings | `#99FFE4` |
| Error / deleted | `#FF8080` |
| Debug orange | `#FF7300` |
| Muted text / keywords / icons | `#A0A0A0` |
| Dim text | `#7E7E7E` |
| Line numbers | `#505050` |
| Active tab background | `#161616` |
| Input / hint background | `#1C1C1C` |
| Active list / selection background | `#232323` |
| Hover / document highlight | `#282828` |
| Scrollbar | `#343434` / `#34343480` |
| Selection overlay | `#FFFFFF25` |
| Comment | `#8B8B8B94` |

## Terminal palette

Use the complete Alacritty port as the canonical ANSI palette for Ghostty, Alacritty, Tmux and terminal applications:

```toml
[colors.primary]
background = '#101010'
foreground = '#ffffff'

[colors.normal]
black   = '#101010'
red     = '#f5a191'
green   = '#90b99f'
yellow  = '#e6b99d'
blue    = '#aca1cf'
magenta = '#e29eca'
cyan    = '#ea83a5'
white   = '#a0a0a0'

[colors.bright]
black   = '#7e7e7e'
red     = '#ff8080'
green   = '#99ffe4'
yellow  = '#ffc799'
blue    = '#b9aeda'
magenta = '#ecaad6'
cyan    = '#f591b2'
white   = '#ffffff'
```

When a tool accepts only a reduced palette, use:

```yaml
accent: "#FFC799"
background: "#101010"
foreground: "#FFFFFF"
normal:
  black: "#101010"
  red: "#FF8080"
  green: "#99FFE4"
  yellow: "#FFC799"
  blue: "#A0A0A0"
  magenta: "#FF7300"
  cyan: "#99FFE4"
  white: "#FFFFFF"
bright:
  black: "#505050"
  red: "#FF8080"
  green: "#99FFE4"
  yellow: "#FFCFA8"
  blue: "#A0A0A0"
  magenta: "#FF8080"
  cyan: "#99FFE4"
  white: "#FFFFFF"
```

## Application rules

- Prefer semantic roles over copying arbitrary hex values between tools.
- Preserve readable contrast before exact visual uniformity.
- Use the complete terminal palette when ANSI colors are supported.
- Use the reduced palette only when a tool exposes a smaller color surface.
- Keep generated theme artifacts out of Git when they can be reproduced from a tracked source.
- Record intentional deviations in the owning package rather than silently introducing another palette.

Research promoted from local planning material on 2026-07-18.
