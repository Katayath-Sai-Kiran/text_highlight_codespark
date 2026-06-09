import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Describes what to highlight and how. Use the named constructors:
/// - [HighlightQuery.single] — one query string, optional per-query color
/// - [HighlightQuery.multiple] — several query strings, optional per-query color map
/// - [HighlightQuery.regex] — a regex pattern
sealed class HighlightQuery {
  const HighlightQuery();

  const factory HighlightQuery.single(String query, {Color? color}) =
      _SingleQuery;

  const factory HighlightQuery.multiple(
    List<String> queries, {
    Map<String, Color>? colors,
  }) = _MultipleQuery;

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

/// A widget that highlights parts of [source] text according to [highlight].
///
/// ```dart
/// HighlightText(
///   source: 'Flutter is awesome',
///   highlight: HighlightQuery.single('Flutter', color: Colors.yellow),
/// )
/// ```
class HighlightText extends StatefulWidget {
  final String source;
  final HighlightQuery highlight;

  /// Fallback highlight color when no per-query color is provided.
  final Color highlightColor;

  /// Style applied to the entire [source] text.
  final TextStyle? textStyle;

  /// Style applied to matched text (merged on top of [textStyle]).
  /// `backgroundColor` is overridden by [highlightColor] or per-query color.
  final TextStyle? matchedTextStyle;

  /// Whether the search is case-sensitive. Defaults to `false`.
  final bool caseSensitive;

  /// Called with the matched string when the user taps a highlighted span.
  final void Function(String matchedText)? onTap;

  /// When set, highlighted spans are rendered with rounded corners.
  final BorderRadius? borderRadius;

  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

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
