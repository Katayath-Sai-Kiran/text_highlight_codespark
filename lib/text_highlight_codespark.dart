import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Describes what and how to highlight inside a [HighlightText] widget.
///
/// Use one of the three named constructors:
///
/// ```dart
/// // Highlight a single word
/// HighlightQuery.single('flutter')
///
/// // Highlight several words, each with its own color
/// HighlightQuery.multiple(['flutter', 'dart'], colors: {'flutter': Colors.blue})
///
/// // Highlight every 4-digit number
/// HighlightQuery.regex(r'\b\d{4}\b')
/// ```
sealed class HighlightQuery {
  const HighlightQuery();

  /// Highlights every occurrence of [query] in the source text.
  ///
  /// Supply [color] to override [HighlightText.highlightColor] for this query only.
  ///
  /// Example:
  /// ```dart
  /// HighlightQuery.single('example')
  /// HighlightQuery.single('example', color: Colors.blue)
  /// ```
  const factory HighlightQuery.single(String query, {Color? color}) =
      _SingleQuery;

  /// Highlights every occurrence of each string in [queries].
  ///
  /// Supply [colors] — a `Map<String, Color>` keyed by query string — to give
  /// each term its own highlight color. Terms absent from [colors] fall back to
  /// [HighlightText.highlightColor].
  ///
  /// Query strings are regex-escaped automatically, so special characters like
  /// `c++` or `(text)` are matched literally and never cause regex errors.
  ///
  /// Example:
  /// ```dart
  /// HighlightQuery.multiple(['flutter', 'dart'])
  /// HighlightQuery.multiple(
  ///   ['flutter', 'dart'],
  ///   colors: {'flutter': Colors.blue, 'dart': Colors.teal},
  /// )
  /// ```
  const factory HighlightQuery.multiple(
    List<String> queries, {
    Map<String, Color>? colors,
  }) = _MultipleQuery;

  /// Highlights every match of the regular expression [pattern] in the source text.
  ///
  /// The pattern is passed directly to [RegExp]. Use raw strings (`r'...'`) to
  /// avoid double-escaping backslashes. Case sensitivity is controlled by
  /// [HighlightText.caseSensitive].
  ///
  /// Example:
  /// ```dart
  /// HighlightQuery.regex(r'\b\d{4}\b')   // matches 4-digit year numbers
  /// HighlightQuery.regex(r'\b[A-Z]\w+')  // matches capitalized words
  /// ```
  const factory HighlightQuery.regex(String pattern) = _RegexQuery;
}

final class _SingleQuery extends HighlightQuery {
  final String query;
  final Color? color;
  const _SingleQuery(this.query, {this.color});
}

final class _MultipleQuery extends HighlightQuery {
  final List<String> queries;
  final Map<String, Color>? colors;
  const _MultipleQuery(this.queries, {this.colors});
}

final class _RegexQuery extends HighlightQuery {
  final String pattern;
  const _RegexQuery(this.pattern);
}

/// A Flutter widget that highlights parts of a text string.
///
/// Wrap any piece of text with [HighlightText] and pass a [HighlightQuery]
/// to describe what to highlight and how. All three modes — single query,
/// multiple queries, and regex — share the same widget and parameters.
///
/// **Basic usage:**
/// ```dart
/// HighlightText(
///   source: 'Flutter makes beautiful UIs.',
///   highlight: HighlightQuery.single('Flutter'),
///   highlightColor: Colors.yellow,
/// )
/// ```
///
/// **Multiple queries with per-term colors:**
/// ```dart
/// HighlightText(
///   source: 'Flutter and Dart are great.',
///   highlight: HighlightQuery.multiple(
///     ['Flutter', 'Dart'],
///     colors: {'Flutter': Colors.blue, 'Dart': Colors.teal},
///   ),
/// )
/// ```
///
/// **Tappable highlights:**
/// ```dart
/// HighlightText(
///   source: 'Tap the word flutter to react.',
///   highlight: HighlightQuery.single('flutter'),
///   onTap: (word) => print('Tapped: $word'),
/// )
/// ```
class HighlightText extends StatefulWidget {
  /// The full text to display. Highlighted spans are rendered inline within it.
  final String source;

  /// Determines what to highlight and which mode to use.
  ///
  /// Use [HighlightQuery.single], [HighlightQuery.multiple], or
  /// [HighlightQuery.regex] to describe the desired highlighting.
  final HighlightQuery highlight;

  /// The background color applied to matched spans when no per-query color is set.
  ///
  /// Defaults to [Colors.yellow]. Override per-term colors via
  /// [HighlightQuery.single]'s `color` or [HighlightQuery.multiple]'s `colors`.
  final Color highlightColor;

  /// Style applied to the entire [source] text, including non-highlighted portions.
  ///
  /// Passed as the `style` argument to the underlying [Text.rich] widget.
  final TextStyle? textStyle;

  /// Additional style merged onto highlighted spans on top of [textStyle].
  ///
  /// `backgroundColor` within this style is overridden by [highlightColor] or
  /// the per-query color. Use it to set `fontWeight`, `fontStyle`, `color`, etc.
  ///
  /// Example:
  /// ```dart
  /// matchedTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
  /// ```
  final TextStyle? matchedTextStyle;

  /// Whether the match is case-sensitive. Defaults to `false`.
  ///
  /// When `false`, searching for `'flutter'` also matches `'Flutter'` and `'FLUTTER'`.
  final bool caseSensitive;

  /// Callback fired with the matched string when the user taps a highlighted span.
  ///
  /// When [borderRadius] is set the tap target is a [GestureDetector] wrapping
  /// a [Container]; otherwise a [TapGestureRecognizer] is attached to the span.
  ///
  /// Example:
  /// ```dart
  /// onTap: (word) => showDialog(context, builder: (_) => Text('You tapped: $word')),
  /// ```
  final void Function(String matchedText)? onTap;

  /// When non-null, highlighted spans are rendered with rounded corners.
  ///
  /// Uses a [WidgetSpan] with a [Container] so the background fills the rounded
  /// shape. Pairs well with [onTap] for badge-style interactive highlights.
  ///
  /// Example:
  /// ```dart
  /// borderRadius: BorderRadius.circular(6)
  /// ```
  final BorderRadius? borderRadius;

  /// Text alignment passed through to the underlying [Text.rich] widget.
  final TextAlign? textAlign;

  /// Maximum number of lines passed through to the underlying [Text.rich] widget.
  final int? maxLines;

  /// Overflow behavior passed through to the underlying [Text.rich] widget.
  final TextOverflow? overflow;

  /// Whether the text should wrap passed through to the underlying [Text.rich] widget.
  final bool? softWrap;

  /// Creates a [HighlightText] widget.
  ///
  /// [source] and [highlight] are required. All other parameters are optional
  /// and fall back to sensible defaults.
  ///
  /// Example:
  /// ```dart
  /// HighlightText(
  ///   source: 'Search and highlight text in Flutter.',
  ///   highlight: HighlightQuery.single('highlight'),
  ///   highlightColor: Colors.amber,
  ///   matchedTextStyle: TextStyle(fontWeight: FontWeight.bold),
  ///   onTap: (word) => print(word),
  ///   borderRadius: BorderRadius.circular(4),
  /// )
  /// ```
  const HighlightText({
    super.key,
    required this.source,
    required this.highlight,
    this.highlightColor = Colors.yellow,
    this.textStyle,
    this.matchedTextStyle,
    this.caseSensitive = false,
    this.onTap,
    this.borderRadius,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  @override
  State<HighlightText> createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  InlineSpan _matchedSpan(String text, Color color) {
    if (widget.borderRadius != null) {
      final effectiveStyle = (widget.textStyle ?? const TextStyle())
          .merge(widget.matchedTextStyle?.copyWith(backgroundColor: null));
      return WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: GestureDetector(
          onTap: widget.onTap != null ? () => widget.onTap!(text) : null,
          child: Container(
            decoration:
                BoxDecoration(color: color, borderRadius: widget.borderRadius),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(text, style: effectiveStyle),
          ),
        ),
      );
    }

    final style = widget.matchedTextStyle?.copyWith(backgroundColor: color) ??
        TextStyle(backgroundColor: color);

    if (widget.onTap != null) {
      final recognizer = TapGestureRecognizer()
        ..onTap = () => widget.onTap!(text);
      _recognizers.add(recognizer);
      return TextSpan(text: text, style: style, recognizer: recognizer);
    }

    return TextSpan(text: text, style: style);
  }

  TextSpan _buildSingle(String query, Color color) {
    if (query.isEmpty) return TextSpan(text: widget.source);

    final List<InlineSpan> spans = [];
    int startIndex = 0;
    final src =
        widget.caseSensitive ? widget.source : widget.source.toLowerCase();
    final q = widget.caseSensitive ? query : query.toLowerCase();

    while (startIndex < widget.source.length) {
      final index = src.indexOf(q, startIndex);
      if (index == -1) {
        spans.add(TextSpan(text: widget.source.substring(startIndex)));
        break;
      }
      if (index > startIndex) {
        spans.add(TextSpan(text: widget.source.substring(startIndex, index)));
      }
      spans.add(_matchedSpan(
          widget.source.substring(index, index + query.length), color));
      startIndex = index + query.length;
    }

    return TextSpan(children: spans);
  }

  TextSpan _buildMultiple(List<String> queries, Map<String, Color>? colors) {
    if (queries.isEmpty) return TextSpan(text: widget.source);

    final List<InlineSpan> spans = [];
    int startIndex = 0;

    // Capture groups let us know exactly which query matched for color lookup.
    final groupedPattern =
        queries.map((q) => '(${RegExp.escape(q)})').join('|');
    final regExp =
        RegExp(groupedPattern, caseSensitive: widget.caseSensitive);

    for (final match in regExp.allMatches(widget.source)) {
      if (match.start > startIndex) {
        spans.add(
            TextSpan(text: widget.source.substring(startIndex, match.start)));
      }

      String? matchedQuery;
      for (int i = 0; i < queries.length; i++) {
        if (match.group(i + 1) != null) {
          matchedQuery = queries[i];
          break;
        }
      }

      // Split from ternary to avoid ?[ parsing ambiguity inside a ternary.
      Color color = widget.highlightColor;
      if (matchedQuery != null) {
        color = colors?[matchedQuery] ?? widget.highlightColor;
      }

      spans.add(_matchedSpan(match.group(0)!, color));
      startIndex = match.end;
    }

    if (startIndex < widget.source.length) {
      spans.add(TextSpan(text: widget.source.substring(startIndex)));
    }

    return TextSpan(children: spans);
  }

  TextSpan _buildRegex(String pattern) {
    if (pattern.isEmpty) return TextSpan(text: widget.source);

    final List<InlineSpan> spans = [];
    int startIndex = 0;
    final regExp = RegExp(pattern, caseSensitive: widget.caseSensitive);

    for (final match in regExp.allMatches(widget.source)) {
      if (match.start > startIndex) {
        spans.add(
            TextSpan(text: widget.source.substring(startIndex, match.start)));
      }
      spans.add(_matchedSpan(match.group(0)!, widget.highlightColor));
      startIndex = match.end;
    }

    if (startIndex < widget.source.length) {
      spans.add(TextSpan(text: widget.source.substring(startIndex)));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final spans = switch (widget.highlight) {
      _SingleQuery q => _buildSingle(q.query, q.color ?? widget.highlightColor),
      _MultipleQuery q => _buildMultiple(q.queries, q.colors),
      _RegexQuery q => _buildRegex(q.pattern),
    };

    return Text.rich(
      spans,
      style: widget.textStyle,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      softWrap: widget.softWrap,
    );
  }
}
