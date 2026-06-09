import 'package:flutter/material.dart';
import 'package:text_highlight_codespark/text_highlight_codespark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HighlightText Examples',
      home: ExamplesPage(),
    );
  }
}

class ExamplesPage extends StatelessWidget {
  const ExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HighlightText Examples')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Single query
            HighlightText(
              source: 'This is an example of text highlighting.',
              highlight: HighlightQuery.single('example'),
              highlightColor: Colors.yellow,
              textStyle: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Multiple queries with per-query colors
            HighlightText(
              source: 'Highlight multiple words like flutter and dart at once.',
              highlight: HighlightQuery.multiple(
                ['flutter', 'dart', 'multiple'],
                colors: {
                  'flutter': Colors.blue,
                  'dart': Colors.teal,
                  'multiple': Colors.orange,
                },
              ),
              textStyle: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Regex query
            HighlightText(
              source: 'The years 2023, 2024, and 2025 are important.',
              highlight: HighlightQuery.regex(r'\b\d{4}\b'),
              highlightColor: Colors.purple,
              matchedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textStyle: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Rounded corners with borderRadius
            HighlightText(
              source: 'Rounded highlight looks modern and clean.',
              highlight: HighlightQuery.single('highlight'),
              highlightColor: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              textStyle: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
