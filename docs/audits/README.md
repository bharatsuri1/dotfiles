# Audit Drafts

These files are isolated research drafts for entries in the Dotfiles Tracker. They are reviewed and consolidated into `docs/dotfiles-tracker.md` later; they are not approved configuration by themselves.

Each entry should use this structure:

```markdown
# Name

## Role

What job the tool or application should perform in the new setup.

## Recommendation

The proposed intentional default, including whether to adopt, retain, replace, or omit it.

## Modern baseline

Current platform conventions, official guidance, and community-supported practices that matter for a clean setup.

## Host and legacy audit

What is installed or configured on the current Mac and what, if anything, is worth carrying forward. Do not reproduce secrets or private data.

## Configuration ownership

Which durable files or settings belong in dotfiles, which belong in bootstrap automation, and which must remain local or mutable.

## Integration notes

Dependencies, overlaps, load order, theme requirements, or interactions with other audited entries.

## Open decisions

Only decisions that materially affect the intended setup; omit low-level implementation details.

## Sources

Primary documentation first, followed by high-signal community sources. Include direct links and a research date.
```

Research rules:

- Prefer official documentation, repositories, specifications, and vendor guidance.
- Use current community recommendations to validate real-world practices, not as the sole authority.
- Inspect the current host and `dotfiles-legacy/` only where relevant.
- Favor a clean, modern, minimal and intentional setup over preserving historical configuration.
- Keep secrets, identifiers, histories, caches, logs, sessions and machine-specific state out of drafts.
- Record durable policy and meaningful choices; defer low-level implementation details to the implementation pass.
- Respect the Vesper theme direction where the tool has a visual configuration surface.
