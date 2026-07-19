# Ollama

## Role

Local model runtime and API for private/offline AI workflows.

## Recommendation

Retain as the local-model backend, with a small declared model catalog and loopback-only service by default.

## Modern baseline

Use the official macOS app/CLI, bind to localhost unless remote service is explicitly secured, pin model names/tags for reproducibility, and size context/concurrency to unified memory. Models are mutable large artifacts, not dotfiles. macOS service environment variables must reach the app/service process; shell-only exports may not.

## Host and legacy audit

Ollama is installed with its macOS application domain. No tracked model or service configuration exists.

## Configuration ownership

Bootstrap Ollama and track a declarative desired-model list plus non-secret `Modelfile`s/scripts. Keep model blobs, chat history, logs, credentials, machine tuning, and `~/.ollama` state local. Service variables belong in an intentional launch environment, not casually in interactive Zsh.

## Integration notes

Can back Pi, OpenCode, Herdr, Supacode, and other clients. Proton VPN should not affect loopback. Vesper applies in clients, not the API runtime.

## Open decisions

- Choose baseline models and whether Ollama starts at login; keep network exposure disabled unless justified.

## Sources

- [Ollama macOS documentation](https://docs.ollama.com/macos)
- [Ollama FAQ: environment variables](https://docs.ollama.com/faq)
- [Ollama Modelfile reference](https://docs.ollama.com/modelfile)
- [Ollama source](https://github.com/ollama/ollama)
- Research date: 2026-07-13.
