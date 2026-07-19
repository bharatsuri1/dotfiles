# Dashlane

## Role

Password, passkey, and secure-item manager.

## Recommendation

Retain if it remains the chosen credential authority; explicitly avoid splitting credentials across browser and system stores without policy.

## Modern baseline

Use a strong unique master password, MFA, recovery setup, passkeys where supported, and periodic secure export/backup according to risk tolerance. Prefer the supported browser extension and current Dashlane macOS delivery model.

## Host and legacy audit

Dashlane is installed. No credential-manager material exists in legacy dotfiles, as expected.

## Configuration ownership

Bootstrap the official app/extension and document enrollment steps only. Vaults, recovery material, device keys, exports, identifiers, extension state, and sessions must never enter the repository.

## Integration notes

Chrome extension policy should list Dashlane if Chrome is retained. Coordinate autofill ownership with macOS Passwords to avoid duplicate prompts. Vesper is irrelevant.

## Open decisions

- Confirm Dashlane as the single credential authority and choose recovery/backup policy.

## Sources

- [Dashlane: security principles](https://www.dashlane.com/security)
- [Dashlane Help: protect your account](https://support.dashlane.com/hc/en-us/articles/202625042-Protect-your-Dashlane-account)
- [Dashlane Help: passkeys](https://support.dashlane.com/hc/en-us/articles/7888558064274-Passkeys-in-Dashlane)
- Research date: 2026-07-13.
