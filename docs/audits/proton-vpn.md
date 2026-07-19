# Proton VPN

## Role

Trusted VPN client for untrusted networks and deliberate network-location changes.

## Recommendation

Retain; default to protocol automation and least-surprising connection behavior rather than always-on complexity unless the threat model requires it.

## Modern baseline

Use the signed open-source client, automatic protocol selection, kill switch when session leakage matters, and Secure Core only when the added latency is justified. Treat VPN use as a threat-model choice, not blanket anonymity.

## Host and legacy audit

ProtonVPN is installed. No legacy tracked configuration exists.

## Configuration ownership

Bootstrap the app and document desired behavior. Account sessions, WireGuard material, connection history, server choices, network-extension approvals, and local preferences remain private/mutable.

## Integration notes

May affect Homebrew, GitHub, Ollama remote access, and latency-sensitive apps. Vesper is irrelevant.

## Open decisions

- Decide auto-connect networks and kill-switch default.

## Sources

- [Proton VPN macOS documentation](https://protonvpn.com/support/protonvpn-mac-vpn-application/)
- [Proton VPN macOS source](https://github.com/ProtonVPN/ios-mac-app)
- [Proton VPN: kill switch](https://protonvpn.com/support/what-is-kill-switch/)
- Research date: 2026-07-13.
