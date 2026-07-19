# Gum

## Role

Supply polished, composable prompts, filters, confirmations, spinners, and formatting for human-facing bootstrap and dotfiles helper scripts.

## Recommendation

Retain as a script dependency, not an always-loaded shell framework. Use it where interaction materially improves safety or clarity, especially selection and confirmation; scripts must still handle cancellation and noninteractive execution correctly.

## Modern baseline

Gum commands write selections to stdout and signal confirmation through exit status, making them easy to compose. Styles are controllable through flags/environment variables. Interactive UI should never be required for unattended bootstrap/CI paths, and destructive actions need explicit validation beyond attractive presentation.

## Host and legacy audit

Homebrew Gum 0.17.0 is installed. No dedicated config exists. Legacy Tmux uses Gum for Markdown selection and window naming; these are legitimate call-site integrations but do not justify global shell configuration.

## Configuration ownership

Track no standalone Gum config initially. Track uses and any shared Vesper environment tokens in the scripts that consume Gum. Bootstrap installs the formula. Inputs, selections, temporary files, command outputs, and secrets entered through prompts are never tracked or logged.

## Integration notes

FZF is the high-performance fuzzy engine; Gum is the simpler polished scripting UI. Avoid using both for the same picker without a reason. Use Vesper colors sparingly and preserve terminal accessibility/contrast.

## Open decisions

- Whether shared Gum styling warrants one sourced script after multiple real consumers exist.

## Sources

- [Gum repository and tutorial](https://github.com/charmbracelet/gum)
- [Gum Homebrew formula](https://formulae.brew.sh/formula/gum)
- [Gum author community introduction](https://www.reddit.com/r/unixporn/comments/wa9kl5/oc_gum_a_tool_for_glamorous_shell_scripts/)
- Researched 2026-07-13.
