# Pi

## Role

Provide a minimal, highly extensible terminal coding-agent harness for workflows that benefit from explicit control over models, tools, prompts, and extensions.

## Recommendation

Retain for a focused trial, not as an automatic duplicate of OpenCode. Start with stock Pi and a tiny reviewed customization set. Promote it only if its minimal harness materially improves a recurring workflow.

## Modern baseline

Pi is intentionally small and extensible through packages, extensions, prompt templates, skills, and provider/model configuration. That flexibility makes third-party extensions part of the security boundary: pin and review code, and do not install community bundles wholesale. Provider credentials and model/account details are local secrets.

## Host and legacy audit

Pi 0.80.6 is installed through Homebrew. Host state exists under `~/.pi/agent`, including settings, models, trust decisions, run history, authentication, and a local SQLite lock database. These files were inventoried by name only; no contents were read. No legacy repo config exists.

## Configuration ownership

Track only intentionally authored prompts, skills, extensions, and non-sensitive settings after checking Pi's supported package layout. Bootstrap owns package installation and pinned extension packages. Authentication, model credentials, trust state, session/run history, local databases, caches, and machine-specific provider settings remain local.

## Integration notes

Avoid duplicating the same prompts/skills independently across Pi, OpenCode, and Codex when a neutral shared format is possible. Herdr may orchestrate Pi sessions. Vesper matters only if Pi exposes a stable theme surface.

## Open decisions

- Pi versus OpenCode as the primary non-Codex terminal agent.
- Which one or two reviewed packages prove Pi's value.
- Whether provider/model defaults are portable enough to track without identifiers.

## Sources

- [Pi Coding Agent](https://pi.dev/)
- [Pi monorepo](https://github.com/badlogic/pi-mono)
- [Pi package directory](https://pi.dev/packages)
- [Recent community setup discussion](https://www.reddit.com/r/PiCodingAgent/comments/1u4nr9k/sharing_my_pi_setup/)
- Researched 2026-07-13.
