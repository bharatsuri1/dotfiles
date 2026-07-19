# K9s

## Role

Provide a keyboard-driven operational interface for inspecting and troubleshooting Kubernetes clusters.

## Recommendation

Retain for Kubernetes work. Rebuild a conservative global config, aliases, and Vesper skin; exclude every cluster-specific artifact and credential.

## Modern baseline

K9s uses XDG-derived locations, but macOS defaults can resolve to Application Support; `k9s info` is authoritative and `K9S_CONFIG_DIR` can make ownership explicit. Keep destructive actions confirmed, prefer context-aware safety, and use `readOnly` when inspecting sensitive environments.

## Host and legacy audit

K9s is installed. Legacy config sets refresh/retry/log preferences, `noExitOnCtrlC`, resource thresholds, a shell pod, useful resource aliases, and Catppuccin. Carry forward aliases and reviewed interaction/log settings, replace Catppuccin with Vesper, and reconsider mutable shell-pod defaults.

## Configuration ownership

Homebrew owns installation. Stow may own global `config.yaml`, `aliases.yaml`, and `skins/vesper.yaml`. Kubeconfigs, contexts, cluster configs, screen dumps, plugins that expose infrastructure, and credentials stay local.

## Integration notes

Depends on `kubectl` authentication and valid contexts. Vesper should preserve Kubernetes status semantics: warning, success, and error colors must remain distinct. Avoid shortcut collisions with terminal and Zsh Vi Mode.

## Open decisions

- Whether the global default should be read-only.
- Whether to force `K9S_CONFIG_DIR` on macOS or accept the native Application Support path.

## Sources

- [K9s configuration](https://github.com/derailed/k9s/blob/master/README.md#k9s-configuration)
- [K9s documentation](https://k9scli.io/)
- [XDG Base Directory specification](https://specifications.freedesktop.org/basedir-spec/latest/)
- [Community operational discussion](https://www.reddit.com/r/kubernetes/comments/gt2iyl/k9s_is_a_must_have_in_your_kubernetes_tooling/)
- Researched 2026-07-13.
