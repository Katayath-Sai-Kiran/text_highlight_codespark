
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/banner.png" alt="text_highlight_codespark — Flutter Text Highlighting Widget"/>

# text_highlight_codespark

**A Flutter widget for highlighting text** — search terms, keywords, and regex patterns — with per-term colors, tappable spans, rounded corners, and full layout control.

<p align="center">
  Built by <a href="https://ksaikiran.dev">Katayath Sai Kiran</a> · <a href="https://github.com/Katayath-Sai-Kiran">@Katayath-Sai-Kiran</a>
</p>

<p align="center">
  <a href="https://pub.dev/packages/text_highlight_codespark"><img src="https://img.shields.io/pub/v/text_highlight_codespark.svg" alt="pub version"/></a>
  <a href="https://pub.dev/packages/text_highlight_codespark/score"><img src="https://img.shields.io/pub/points/text_highlight_codespark" alt="pub points"/></a>
  <a href="https://pub.dev/packages/text_highlight_codespark"><img src="https://img.shields.io/pub/likes/text_highlight_codespark" alt="pub likes"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"/></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/platform-flutter-02569B?logo=flutter" alt="platform: flutter"/></a>
  <a href="https://pub.dev/packages/text_highlight_codespark"><img src="https://img.shields.io/badge/Text-Highlight-orange" alt="Text Highlight"/></a>
</p>

---

## Screenshots

<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/single_query.png" alt="Single Query Highlighting" width="160"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/multiple_query.png" alt="Multiple Queries Highlighting" width="160"/>
<img src="https://raw.githubusercontent.com/Katayath-Sai-Kiran/text_highlight_codespark/main/assets/regex_query.png" alt="Regex Highlighting" width="160"/>

---

## Features

- **Single query** — highlight every occurrence of one search term
- **Multiple queries** — highlight several terms simultaneously, each with its own color
- **Regex highlighting** — match any pattern using standard Dart [RegExp](https://api.dart.dev/dart-core/RegExp-class.html)
- **Per-term colors** — `Map<String, Color>` lets each keyword have a distinct background
- **Tappable highlights** — `onTap` callback delivers the matched string on tap
- **Rounded corners** — `borderRadius` gives highlights a pill or badge look
- **Layout passthrough** — `textAlign`, `maxLines`, `overflow`, `softWrap`
- **Case-insensitive by default** — opt into case-sensitive matching per widget
- **Regex-safe multiple mode** — special characters like `c++` are escaped automatically

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  text_highlight_codespark: ^2.1.0
```

Then run:

```bash
flutter pub get
```

Import in your Dart file:

```dart
import 'package:text_highlight_codespark/text_highlight_codespark.dart';
```

---

## Usage

### Single query

Highlight every occurrence of one search term:

```dart
HighlightText(
  source: 'This is an example of Flutter text highlighting.',
  highlight: HighlightQuery.single('example'),
  highlightColor: Colors.yellow,
  textStyle: TextStyle(fontSize: 16),
  matchedTextStyle: TextStyle(fontWeight: FontWeight.bold),
)
```

Override the color for just this query:

```dart
HighlightText(
  source: 'Flutter makes beautiful UIs.',
  highlight: HighlightQuery.single('Flutter', color: Colors.blue.shade200),
)
```

---

### Multiple queries with per-term colors

Highlight several keywords at once, each in a different color:

```dart
HighlightText(
  source: 'Flutter and Dart are great technologies for building apps.',
  highlight: HighlightQuery.multiple(
    ['Flutter', 'Dart', 'apps'],
    colors: {
      'Flutter': Colors.blue.shade200,
      'Dart':    Colors.teal.shade200,
      'apps':    Colors.orange.shade200,
    },
  ),
  textStyle: TextStyle(fontSize: 16),
)
```

Special characters in query strings (e.g. `c++`, `(text)`) are escaped automatically and always match literally.

---

### Regex highlighting

Highlight any pattern supported by Dart's [RegExp](https://api.dart.dev/dart-core/RegExp-class.html):

```dart
// Highlight 4-digit year numbers
HighlightText(
  source: 'The years 2022, 2023, and 2024 are important.',
  highlight: HighlightQuery.regex(r'\b\d{4}\b'),
  highlightColor: Colors.purple.shade200,
  matchedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
)
```

```dart
// Highlight email addresses
HighlightText(
  source: 'Contact us at hello@example.com or support@example.com.',
  highlight: HighlightQuery.regex(r'[\w.]+@[\w.]+\.\w+'),
  highlightColor: Colors.green.shade200,
)
```

---

### Tappable highlights

Fire a callback with the matched string when the user taps a highlight:

```dart
HighlightText(
  source: 'Tap any highlighted word to learn more about Flutter or Dart.',
  highlight: HighlightQuery.multiple(['Flutter', 'Dart']),
  highlightColor: Colors.amber.shade200,
  onTap: (word) {
    // word is the exact string the user tapped
    showBottomSheet(...);
  },
)
```

---

### Rounded-corner highlights

Give highlights a badge or pill appearance:

```dart
HighlightText(
  source: 'Rounded highlights look modern and clean in Flutter UIs.',
  highlight: HighlightQuery.single('highlights'),
  highlightColor: Colors.green.shade300,
  borderRadius: BorderRadius.circular(6),
  matchedTextStyle: TextStyle(fontWeight: FontWeight.w600),
)
```

---

### Layout control

All standard `Text` layout parameters are supported:

```dart
HighlightText(
  source: 'A very long string that might overflow on smaller screens in Flutter.',
  highlight: HighlightQuery.single('Flutter'),
  highlightColor: Colors.yellow,
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  softWrap: true,
)
```

---

## API Reference

### `HighlightText` parameters

| Parameter          | Type                     | Default         | Description                                                      |
|--------------------|--------------------------|-----------------|------------------------------------------------------------------|
| `source`           | `String`                 | required        | The full text to display.                                        |
| `highlight`        | `HighlightQuery`         | required        | What to highlight — `.single`, `.multiple`, or `.regex`.         |
| `highlightColor`   | `Color`                  | `Colors.yellow` | Fallback background color for matched spans.                     |
| `textStyle`        | `TextStyle?`             | `null`          | Style for the entire source text.                                |
| `matchedTextStyle` | `TextStyle?`             | `null`          | Extra style merged onto matched spans (`backgroundColor` ignored).|
| `caseSensitive`    | `bool`                   | `false`         | Whether matching is case-sensitive.                              |
| `onTap`            | `void Function(String)?` | `null`          | Callback fired with the matched text on tap.                     |
| `borderRadius`     | `BorderRadius?`          | `null`          | Rounds the corners of matched spans.                             |
| `textAlign`        | `TextAlign?`             | `null`          | Text alignment — passed to `Text.rich`.                          |
| `maxLines`         | `int?`                   | `null`          | Max line count — passed to `Text.rich`.                          |
| `overflow`         | `TextOverflow?`          | `null`          | Overflow behavior — passed to `Text.rich`.                       |
| `softWrap`         | `bool?`                  | `null`          | Soft wrap — passed to `Text.rich`.                               |

---

### `HighlightQuery` constructors

| Constructor | Parameters | Description |
|---|---|---|
| `HighlightQuery.single(query, {color})` | `String`, optional `Color` | Highlight one term. |
| `HighlightQuery.multiple(queries, {colors})` | `List<String>`, optional `Map<String, Color>` | Highlight multiple terms with optional per-term colors. |
| `HighlightQuery.regex(pattern)` | `String` | Highlight all regex matches. |

---

## License

[MIT License](LICENSE)
