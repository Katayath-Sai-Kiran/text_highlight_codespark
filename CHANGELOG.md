# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1] - 2024-06-25
### Fixed
- Updated homepage URL to GitHub repository.
- Documentation: Included comprehensive examples, Comments and usage instructions in the `README.md` file.


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

## Upcoming Changes

### [1.1.0] 
#### Added
- Support for custom regex patterns in `HighlightText.regex`.
- Improved documentation and added more usage examples.
- Performance optimizations for multiple queries highlighting.

### [1.2.0] 
#### Added
- Introduced `wholeWord` parameter to highlight only whole word matches.
- Animation support for highlighting with `HighlightText.animation`.
- Tooltip feature for highlighted text.

### [1.3.0]
#### Added
- Option to return the count of highlights.
- Support for nested highlights and better handling of overlapping queries.
- More customization options for highlight animations.
