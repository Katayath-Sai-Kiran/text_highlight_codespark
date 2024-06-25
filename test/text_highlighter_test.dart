import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_highlight_codespark/text_highlighter.dart';

void main() {
  group('HighlightText', () {
    test('Single Query Highlighting', () {
      final highlighter = HighlightText(
        query: 'example', // Provide the required 'query' parameter
        source:
            'This is an example of text highlighting.', // Provide the required 'source' parameter
        highlightColor: Colors.yellow.shade700,
      );

      // Test case 1: Single query highlighting
      final highlightedText1 = highlighter.highlightQueryInString(
        query: 'example',
        target: 'This is an example of text highlighting.',
        highlightColor: Colors.yellow.shade700,
      );

      // Extract text from TextSpan for verification
      final List<String> textSpans =
          highlightedText1.children!.map((span) => span.toPlainText()).toList();

      // Assert statements
      expect(textSpans.join(), 'This is an example of text highlighting.');
    });

    test('Multiple Queries Highlighting', () {
      final highlighter = HighlightText.multiple(
        queires: const [
          'highlight',
          'text'
        ], // Provide the required 'queires' parameter (intentional typo in 'queires' to match the original code)
        source:
            'This is an example of highlighting multiple queries in the text.', // Provide the required 'source' parameter
        highlightColor: Colors.yellow.shade700,
      );

      // Test case 2: Multiple queries highlighting
      final highlightedText2 = highlighter.highlightQueriesInString(
        queries: ['highlight', 'text'],
        target:
            'This is an example of highlighting multiple queries in the text.',
        highlightColor: Colors.yellow.shade700,
      );

      // Extract text from TextSpan for verification
      final List<String> textSpans =
          highlightedText2.children!.map((span) => span.toPlainText()).toList();

      // Assert statements
      expect(textSpans.join(),
          'This is an example of highlighting multiple queries in the text.');
    });

    test('Regex Highlighting', () {
      final highlighter = HighlightText.regex(
        regex: r'\b\d{4}\b', // Provide the required 'regex' parameter
        source:
            'The years 2023, 2024, and 2025 are important.', // Provide the required 'source' parameter
        highlightColor: Colors.yellow.shade700,
      );

      // Test case 3: Regex highlighting
      final highlightedText3 = highlighter.highlightRegexMatches(
        source: 'The years 2023, 2024, and 2025 are important.',
        highlightColor: Colors.yellow.shade700,
      );

      // Extract text from TextSpan for verification
      final List<String> textSpans =
          highlightedText3.children!.map((span) => span.toPlainText()).toList();

      // Assert statements
      expect(textSpans.join(), 'The years 2023, 2024, and 2025 are important.');
    });
  });
}
