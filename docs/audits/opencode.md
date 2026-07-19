# OpenCode

## Role

Provide a full-featured open-source terminal coding agent with multiple providers, permission controls, commands, agents, skills, plugins, and project-aware configuration.

## Recommendation

Retain as the primary candidate for a configurable non-Codex agent, but rebuild its global config around least privilege. Keep global agents/commands minimal and place project-specific instructions in each project. Treat plugins and MCP servers as executable/trusted integrations.

## Modern baseline

OpenCode supports global XDG config and project config, JSON schema validation, separate TUI themes, Markdown agents, commands, skills, plugins, and granular `allow`/`ask`/`deny` permissions including external-directory access. Sharing is manual by default. Global config should hold user-wide runtime and permission policy; repository config should hold project behavior.

## Host and legacy audit

OpenCode 1.17.7 is installed in `~/.opencode/bin`. Current XDG config contains an `opencode.jsonc`, custom commands, a Supacode presence plugin, and an npm package tree/lockfile. File names were inspected, but credentials and config values were not reproduced. There is no legacy repo package.

## Configuration ownership

Track reviewed `opencode.jsonc`, `tui.json`, user agents/commands/skills, and source-level plugins only. Bootstrap installs OpenCode and deterministic plugin dependencies. Provider credentials, authentication, sessions, shares, logs, caches, node_modules, machine-specific models, MCP secrets, and project state remain local.

## Integration notes

Coordinate shared prompts/skills with Pi and Codex, orchestration with Herdr, local models with Ollama, and presence behavior with Supacode. Default external-directory and shell permissions should require approval. Use Vesper through the supported TUI theme mechanism.

## Open decisions

- Exact default permission matrix.
- Whether Supacode presence remains enabled globally.
- Pi versus OpenCode role boundary and shared instruction format.

## Sources

- [OpenCode configuration](https://opencode.ai/docs/config/)
- [OpenCode agents and permissions](https://opencode.ai/docs/agents/)
- [OpenCode themes](https://opencode.ai/docs/themes/)
- [OpenCode plugins](https://opencode.ai/docs/plugins/)
- Researched 2026-07-13.
