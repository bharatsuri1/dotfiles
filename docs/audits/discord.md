# Discord

## Role

Community messaging and voice/video client.

## Recommendation

Retain only if required by active communities; keep it outside the core productivity path and disable unnecessary startup/overlay behavior.

## Modern baseline

Use passkeys or MFA, review privacy/data settings, restrict direct messages by server where appropriate, and do not auto-start unless voice availability is intentional. macOS microphone, camera, notification, and screen-capture permissions should remain least-privilege.

## Host and legacy audit

Discord is installed with local Electron preferences. No legacy dotfile configuration exists.

## Configuration ownership

Bootstrap the app. Accounts, tokens, server membership, message/cache databases, permissions, and preferences remain local/private. Do not copy its Application Support directory.

## Integration notes

Raycast may launch it, but no deeper integration is needed. Vesper is optional via Discord's native dark appearance; third-party client modification should be omitted.

## Open decisions

- Decide launch-at-login and notification policy.

## Sources

- [Discord Safety Center: account security](https://discord.com/safety/securing-your-discord-account)
- [Discord support: data privacy controls](https://support.discord.com/hc/en-us/articles/360004109911-Data-Privacy-Controls)
- [Apple: control microphone access](https://support.apple.com/guide/mac-help/control-access-to-the-microphone-on-mac-mchla1b1e1fe/mac)
- Research date: 2026-07-13.
