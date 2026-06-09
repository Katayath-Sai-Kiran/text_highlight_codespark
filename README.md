
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/banner.png" alt="Banner"/>

# HighlightText

A Flutter widget that highlights specific parts of a given text. Supports single queries, multiple queries with per-term colors, regex patterns, tappable highlights, and rounded-corner styling.

## Screenshots

<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/single_query.png" alt="Single Query" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/multiple_query.png" alt="Multiple Queries" width="150"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/regex_query.png" alt="Regex" width="150"/>

## Features

- **Single query** — highlight one term in the source text
- **Multiple queries** — highlight several terms at once, each with its own color
- **Regex** — highlight using any regular expression pattern
- **Per-query colors** — assign a different `Color` to each term in multi-query mode
- **Tappable highlights** — `onTap` callback fires with the matched string
- **Rounded corners** — `borderRadius` gives highlights a pill/badge look
- **Layout passthrough** — `textAlign`, `maxLines`, `overflow`, `softWrap`
- **Case sensitivity** — opt in or out per widget

## Installation

```yaml
dependencies:
  text_highlight_codespark: ^2.0.0
```

Then run `flutter pub get`.

## Usage

### Single query

```dart
HighlightText(
  source: 'This is an example of text highlighting.',
  highlight: HighlightQuery.single('example'),
  highlightColor: Colors.yellow,
  textStyle: TextStyle(fontSize: 16),
  matchedTextStyle: TextStyle(fontWeight: FontWeight.bold),
)
```

### Multiple queries with per-query colors

```dart
HighlightText(
  source: 'Flutter and Dart are great technologies.',
  highlight: HighlightQuery.multiple(
    ['flutter', 'dart'],
    colors: {
      'flutter': Colors.blue,
      'dart': Colors.teal,
    },
  ),
  textStyle: TextStyle(fontSize: 16),
)
```

### Regex

```dart
HighlightText(
  source: 'The years 2023, 2024, and 2025 are important.',
  highlight: HighlightQuery.regex(r'\b\d{4}\b'),
  highlightColor: Colors.purple,
  matchedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
)
```

### Tappable highlights

```dart
HighlightText(
  source: 'Tap the word flutter to see it fire.',
  highlight: HighlightQuery.single('flutter'),
  highlightColor: Colors.amber,
  onTap: (matchedText) => print('Tapped: $matchedText'),
)
```

### Rounded corners

```dart
HighlightText(
  source: 'Rounded highlight looks clean.',
  highlight: HighlightQuery.single('highlight'),
  highlightColor: Colors.green,
  borderRadius: BorderRadius.circular(6),
)
```

## Parameters

| Parameter          | Type                    | Default        | Description                                                  |
|--------------------|-------------------------|----------------|--------------------------------------------------------------|
| `source`           | `String`                | required       | The text to display and search within.                       |
| `highlight`        | `HighlightQuery`        | required       | What to highlight — use `.single`, `.multiple`, or `.regex`. |
| `highlightColor`   | `Color`                 | `Colors.yellow`| Fallback highlight color.                                    |
| `textStyle`        | `TextStyle?`            | `null`         | Style for the full text.                                     |
| `matchedTextStyle` | `TextStyle?`            | `null`         | Additional style merged onto matched spans.                  |
| `caseSensitive`    | `bool`                  | `false`        | Whether matching is case-sensitive.                          |
| `onTap`            | `void Function(String)?`| `null`         | Callback fired with the matched string on tap.               |
| `borderRadius`     | `BorderRadius?`         | `null`         | Rounds the corners of highlighted spans.                     |
| `textAlign`        | `TextAlign?`            | `null`         | Passed through to `Text.rich`.                               |
| `maxLines`         | `int?`                  | `null`         | Passed through to `Text.rich`.                               |
| `overflow`         | `TextOverflow?`         | `null`         | Passed through to `Text.rich`.                               |
| `softWrap`         | `bool?`                 | `null`         | Passed through to `Text.rich`.                               |

## HighlightQuery

| Constructor                         | Description                                              |
|-------------------------------------|----------------------------------------------------------|
| `HighlightQuery.single(query, {color})` | Highlight one string. Optional `color` overrides `highlightColor`. |
| `HighlightQuery.multiple(queries, {colors})` | Highlight a list of strings. `colors` is a `Map<String, Color>` keyed by query. |
| `HighlightQuery.regex(pattern)`     | Highlight all regex matches.                             |

## License

[MIT License](LICENSE)
