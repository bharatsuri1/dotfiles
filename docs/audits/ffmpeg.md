# FFmpeg

## Role

Provide the common command-line foundation for inspecting, converting, encoding, filtering, and streaming audio/video.

## Recommendation

Retain. Prefer the official Homebrew core formula unless a documented workflow requires codecs or filters available only in `ffmpeg-full` or a specialist tap.

## Modern baseline

FFmpeg's command surface is large and version-sensitive. Keep repeatable recipes in scripts or task runners, preserve metadata intentionally, and use explicit codecs and quality settings. On macOS, VideoToolbox can provide hardware acceleration, but output/quality tradeoffs should be tested per workflow.

## Host and legacy audit

The host inventory previously showed `ffmpeg-full`, not the core `ffmpeg` formula. No FFmpeg dotfile or recipe library was found. The expanded build should be justified against actual Capture One/DaVinci/photo/video workflows.

## Configuration ownership

Homebrew owns installation and codec selection. Dotfiles may own generic public helper functions or scripts. Media, presets tied to clients/projects, caches, temporary frames, and private paths remain local.

## Integration notes

Overlaps with DaVinci Resolve for interactive editing and can support image/video automation. Ensure helpers are shell-safe and do not silently overwrite. Vesper is not applicable.

## Open decisions

- Core `ffmpeg` versus `ffmpeg-full` based on a concrete codec/filter matrix.
- Whether reusable recipes belong in dotfiles or a separate media toolkit.

## Sources

- [FFmpeg documentation](https://ffmpeg.org/documentation.html)
- [FFmpeg macOS platform guidance](https://ffmpeg.org/platform.html)
- [Homebrew core formula](https://formulae.brew.sh/formula/ffmpeg)
- [Expanded Homebrew FFmpeg tap](https://github.com/homebrew-ffmpeg/homebrew-ffmpeg)
- Researched 2026-07-13.
