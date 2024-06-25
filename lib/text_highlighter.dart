import 'dart:developer';
import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String query;
  final String source;
  final Color highlightColor;
  final TextStyle? textStyle;
  final TextStyle? matchedTextStyle;
  final bool? caseSensitive;
  final bool isMultiple;
  final bool isRegex;
  final String regex;
  final List<String> queires;

  // Constructor for single query highlighting
  HighlightText({
    super.key,
    required this.query,
    required this.source,
    this.textStyle,
    this.matchedTextStyle,
    this.highlightColor = Colors.red,
    this.caseSensitive = false,
  })  : isMultiple = false,
        isRegex = false,
        regex = '',
        queires = [];

  // Constructor for multiple queries highlighting
  const HighlightText.multiple({
    super.key,
    required this.queires,
    required this.source,
    this.textStyle,
    this.matchedTextStyle,
    this.highlightColor = Colors.red,
    this.caseSensitive = false,
  })  : isMultiple = true,
        isRegex = false,
        regex = '',
        query = '';

  // Constructor for regex highlighting
  HighlightText.regex({
    super.key,
    required this.source,
    required this.regex,
    this.textStyle,
    this.matchedTextStyle,
    this.highlightColor = Colors.red,
    this.caseSensitive = false,
  })  : isMultiple = false,
        isRegex = true,
        queires = [],
        query = '';

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: textStyle,
      isRegex
          ? highlightRegexMatches(
              source: source, highlightColor: highlightColor)
          : isMultiple
              ? highlightQueriesInString(
                  highlightColor: highlightColor,
                  queries: queires,
                  target: source,
                  matchedTextStyle: matchedTextStyle,
                )
              : highlightQueryInString(
                  highlightColor: highlightColor,
                  query: query,
                  target: source,
                  matchedTextStyle: matchedTextStyle,
                ),
    );
  }

  // Highlights a single query in the source text
  TextSpan highlightQueryInString({
    required String query,
    required String target,
    required Color highlightColor,
    TextStyle? matchedTextStyle,
  }) {
    List<TextSpan> spans = [];
    int startIndex = 0;

    while (startIndex < target.length) {
      int index;
      if (caseSensitive == true) {
        index = target.indexOf(query, startIndex);
      } else {
        index = target.toLowerCase().indexOf(query.toLowerCase(), startIndex);
      }
      if (index == -1) {
        spans.add(TextSpan(text: target.substring(startIndex)));
        break;
      }
      if (index > startIndex) {
        spans.add(TextSpan(text: target.substring(startIndex, index)));
      }
      spans.add(TextSpan(
        text: target.substring(index, index + query.length),
        style: matchedTextStyle?.copyWith(backgroundColor: highlightColor) ??
            TextStyle(
              backgroundColor: highlightColor,
            ),
      ));
      startIndex = index + query.length;
    }
    return TextSpan(children: spans);
  }

  // Highlights multiple queries in the source text
  TextSpan highlightQueriesInString({
    required List<String> queries,
    required String target,
    required Color highlightColor,
    TextStyle? matchedTextStyle,
  }) {
    List<TextSpan> spans = [];
    int startIndex = 0;
    String regexPattern = queries.join('|');
    RegExp regExp = RegExp(regexPattern, caseSensitive: caseSensitive ?? false);
    Iterable<RegExpMatch> matches = regExp.allMatches(target);

    for (RegExpMatch match in matches) {
      if (match.start > startIndex) {
        spans.add(TextSpan(text: target.substring(startIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(0)!,
        style: matchedTextStyle?.copyWith(backgroundColor: highlightColor) ??
            TextStyle(backgroundColor: highlightColor),
      ));
      startIndex = match.end;
    }
    if (startIndex < target.length) {
      spans.add(TextSpan(text: target.substring(startIndex)));
    }
    return TextSpan(children: spans);
  }

  // Highlights matches based on the given regex
  TextSpan highlightRegexMatches({
    required String source,
    required Color highlightColor,
    TextStyle? matchedTextStyle,
  }) {
    List<TextSpan> spans = [];
    Iterable<RegExpMatch> matches = RegExp(regex).allMatches(source);

    int startIndex = 0;
    for (RegExpMatch match in matches) {
      if (match.start > startIndex) {
        spans.add(TextSpan(text: source.substring(startIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(0)!,
        style: matchedTextStyle?.copyWith(backgroundColor: highlightColor) ??
            TextStyle(backgroundColor: highlightColor),
      ));
      startIndex = match.end;
    }
    if (startIndex < source.length) {
      spans.add(TextSpan(text: source.substring(startIndex)));
    }
    return TextSpan(children: spans);
  }
}
