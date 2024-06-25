import 'package:flutter/material.dart';
import 'package:text_highlighter/text_highlighter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('HighlightText Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: HighlightText(
                  query: "example",
                  source: 'This is an example of text highlighting.',
                  caseSensitive: false,
                  highlightColor: Colors.yellow.shade700,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: HighlightText.multiple(
                  queires: const ['highlight', 'text', 'example', 'multiple'],
                  source:
                      'This is an example of highlighting multiple queries in the text.',
                  caseSensitive: false,
                  highlightColor: Colors.yellow.shade700,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: HighlightText.regex(
                  regex: r'\b\d{4}\b',
                  source: 'The years 2023, 2024, and 2025 are important.',
                  caseSensitive: false,
                  highlightColor: Colors.yellow.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
