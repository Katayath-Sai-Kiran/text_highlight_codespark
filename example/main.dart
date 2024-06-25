import 'package:flutter/material.dart';
import 'package:text_highlight_codespark/text_highlighter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('HighlightText Example')), // App bar with title
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: HighlightText(
                  query: "example", // Single query to highlight
                  source:
                      'This is an example of text highlighting.', // Source text to search within
                  caseSensitive: false, // Case insensitivity option
                  highlightColor: Colors.yellow.shade700, // Highlight color
                ),
              ),
              const SizedBox(height: 24), // Spacer between examples
              Center(
                child: HighlightText.multiple(
                  queires: const [
                    'highlight',
                    'text',
                    'example',
                    'multiple'
                  ], // Multiple queries to highlight
                  source:
                      'This is an example of highlighting multiple queries in the text.', // Source text to search within
                  caseSensitive: false, // Case insensitivity option
                  highlightColor: Colors.yellow.shade700, // Highlight color
                ),
              ),
              const SizedBox(height: 24), // Spacer between examples
              Center(
                child: HighlightText.regex(
                  regex:
                      r'\b\d{4}\b', // Regular expression pattern to highlight four-digit numbers
                  source:
                      'The years 2023, 2024, and 2025 are important.', // Source text to search within
                  caseSensitive: false, // Case insensitivity option
                  highlightColor: Colors.yellow.shade700, // Highlight color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
