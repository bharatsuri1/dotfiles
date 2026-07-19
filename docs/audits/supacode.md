# Supacode

## Role

Native macOS workspace for coordinating AI coding sessions.

## Recommendation

Retain provisionally and evaluate against the simpler Pi/OpenCode/Herdr workflow before making it baseline.

## Modern baseline

Keep repositories under normal Git ownership, require review before agent changes land, and avoid granting broader filesystem or credential access than required. Treat rapidly evolving agent products as replaceable clients.

## Host and legacy audit

Supacode is installed with a standard preference domain. No legacy tracked configuration was found.

## Configuration ownership

Bootstrap the app if retained. Accounts, API keys, transcripts, sessions, repository metadata, caches, and app preferences remain local/private. Track only a provider/tool policy if a supported export emerges.

## Integration notes

Directly overlaps with Herdr, Pi, OpenCode, ChatGPT, and terminal multiplexer workflows. Vesper should use native theme support only.

## Open decisions

- Decide whether Supacode provides a unique orchestration role after the CLI agent stack is implemented.

## Sources

- [Supacode](https://supacode.sh/)
- [Supacode documentation](https://docs.supacode.sh/)
- Research date: 2026-07-13. Public configuration and migration documentation remains limited; recommendation is intentionally provisional.
