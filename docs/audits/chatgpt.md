# ChatGPT

## Role

General AI assistant with native macOS launcher, voice, and app integrations.

## Recommendation

Retain if native capture/voice provides value beyond the browser; keep integrations opt-in and avoid duplicate global shortcuts with Raycast.

## Modern baseline

Review Data Controls, Temporary Chat, memory, microphone/screen permissions, and connected-app access. Use the official signed app and maintain a clear boundary between personal and work accounts.

## Host and legacy audit

Current and classic ChatGPT applications are present, with helper preferences. No durable legacy configuration exists; the duplicate/legacy application should be cleaned up during implementation after confirming which is current.

## Configuration ownership

Bootstrap the official app. Accounts, conversations, memory, tokens, recordings, caches, and Library state remain local/service-owned. Track only shortcut and permission policy.

## Integration notes

Overlaps with Raycast AI, Ollama, Pi, and OpenCode. Vesper is limited to native dark appearance.

## Open decisions

- Decide whether the native app earns a place over web use and assign its launcher shortcut.

## Sources

- [OpenAI: ChatGPT macOS app](https://openai.com/chatgpt/desktop/)
- [OpenAI Help: Data Controls](https://help.openai.com/en/articles/7730893-data-controls-faq)
- [OpenAI Help: macOS app release notes](https://help.openai.com/en/articles/9703738-macos-app-release-notes)
- Research date: 2026-07-13.
