# Changelog

All notable changes to this project will be documented in this file.

## [2.1.0] - 2026-06-10

### Added
- Comprehensive `///` dartdoc comments on all public classes, constructors, and fields — visible on hover in VS Code and rendered on pub.dev.
- `repository` and `issue_tracker` fields in `pubspec.yaml` for better pub.dev discoverability.
- `topics` field (`text`, `search`, `ui`, `widget`, `regex`) for pub.dev topic search.
- Platform declarations (`android`, `ios`, `linux`, `macos`, `web`, `windows`) for full platform support scoring.
- Overhauled `README.md` with author attribution, pub.dev badges, comprehensive code examples for all modes, and an API reference table.
- Updated example app showcasing all eight usage scenarios with a sectioned `ListView`.

---

## [2.0.0] - 2026-06-10

### Breaking Changes
- Replaced the three-constructor API (`HighlightText`, `HighlightText.multiple`, `HighlightText.regex`) with a single `HighlightText` widget that takes a `HighlightQuery` parameter.
- `caseSensitive` is now `bool` (non-nullable, defaults to `false`) instead of `bool?`.

### Added
- `HighlightQuery` sealed class with `.single`, `.multiple`, and `.regex` constructors — clean, type-safe, no unused fields.
- Per-query colors in `.multiple` mode via `Map<String, Color>? colors` on `HighlightQuery.multiple`.
- `onTap` callback — fires with the matched string when a highlighted span is tapped.
- `borderRadius` — renders highlighted spans with rounded corners using a `WidgetSpan` + `Container`.
- `textAlign`, `maxLines`, `overflow`, `softWrap` — passed through to the underlying `Text.rich`.
- Proper disposal of `TapGestureRecognizer` instances via `StatefulWidget`.

### Fixed
- `matchedTextStyle` was silently ignored in `.regex` mode — now correctly applied.
- Queries in `.multiple` mode are now regex-escaped, preventing crashes on inputs like `"c++"` or `"(text)"`.

---

## [1.0.1] - 2024-06-25
### Fixed
- Updated homepage URL to GitHub repository.
- Documentation: Included comprehensive examples, comments and usage instructions in the `README.md` file.

## [1.0.0] - 2024-06-25
### Added
- Initial release of `HighlightText` package.
- Feature to highlight single query within the source text.
- Support for case-sensitive search for single query.
- Support for custom text styles for matched and unmatched text.
- Multiple queries highlighting with the `HighlightText.multiple` constructor.
- Regex highlighting with the `HighlightText.regex` constructor.
- `caseSensitive` parameter for both single and multiple queries.
- Examples and usage instructions in the `README.md`.
