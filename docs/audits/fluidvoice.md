# FluidVoice

## Role

Fast local/offline macOS dictation and voice-command input.

## Recommendation

Retain as the privacy-first dictation default if recognition quality is sufficient; prefer it over overlapping cloud transcription for everyday input.

## Modern baseline

Use local models, grant microphone and Accessibility permissions deliberately, choose push-to-talk or a conflict-free hotkey, and review telemetry settings. Keep dictated history short or disabled when it may contain sensitive text.

## Host and legacy audit

FluidVoice is installed with preference domain `com.FluidApp.app`. No legacy configuration exists.

## Configuration ownership

Bootstrap the signed app/build. Models, audio buffers, transcripts/history, analytics identifiers, permissions, and preferences remain local. Track only selected model class, shortcut, privacy/retention policy, and any supported non-sensitive export.

## Integration notes

Overlaps with ChatGPT voice, Plaud, and macOS Dictation. Vesper may apply to overlay colors only. Avoid shortcut conflicts with Raycast/Homerow.

## Open decisions

- Decide whether FluidVoice fully replaces other live-dictation tools and whether history is retained.

## Sources

- [FluidVoice source](https://github.com/altic-dev/FluidVoice)
- [FluidVoice releases](https://github.com/altic-dev/FluidVoice/releases)
- [Apple: microphone permissions](https://support.apple.com/guide/mac-help/control-access-to-the-microphone-on-mac-mchla1b1e1fe/mac)
- Research date: 2026-07-13.
