import 'package:flutter/material.dart';
import 'package:text_highlight_codespark/text_highlight_codespark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'text_highlight_codespark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ExamplesPage(),
    );
  }
}

class ExamplesPage extends StatefulWidget {
  const ExamplesPage({super.key});

  @override
  State<ExamplesPage> createState() => _ExamplesPageState();
}

class _ExamplesPageState extends State<ExamplesPage> {
  String? _lastTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('text_highlight_codespark'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _Section(
            title: 'Single Query',
            child: HighlightText(
              source: 'This is an example of Flutter text highlighting.',
              highlight: const HighlightQuery.single('example'),
              highlightColor: Colors.yellow.shade600,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          _Section(
            title: 'Single Query — Custom Color',
            child: HighlightText(
              source: 'Flutter makes beautiful cross-platform UIs.',
              highlight: HighlightQuery.single('Flutter',
                  color: Colors.blue.shade200),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          _Section(
            title: 'Multiple Queries — Per-Term Colors',
            child: HighlightText(
              source:
                  'Flutter and Dart are great technologies for building apps.',
              highlight: HighlightQuery.multiple(
                ['Flutter', 'Dart', 'apps'],
                colors: {
                  'Flutter': Colors.blue.shade200,
                  'Dart': Colors.teal.shade200,
                  'apps': Colors.orange.shade200,
                },
              ),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          _Section(
            title: 'Regex — 4-Digit Numbers',
            child: HighlightText(
              source: 'The years 2022, 2023, and 2024 are important.',
              highlight: const HighlightQuery.regex(r'\b\d{4}\b'),
              highlightColor: Colors.purple.shade200,
              matchedTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          _Section(
            title: 'Tappable Highlights',
            subtitle: _lastTapped != null ? 'Tapped: "$_lastTapped"' : null,
            child: HighlightText(
              source: 'Tap Flutter or Dart to see the callback fire.',
              highlight: const HighlightQuery.multiple(['Flutter', 'Dart']),
              highlightColor: Colors.amber.shade300,
              textStyle: const TextStyle(fontSize: 16),
              onTap: (word) => setState(() => _lastTapped = word),
            ),
          ),

          _Section(
            title: 'Rounded Corners',
            child: HighlightText(
              source: 'Rounded highlights look modern and clean.',
              highlight: const HighlightQuery.single('highlights'),
              highlightColor: Colors.green.shade300,
              borderRadius: BorderRadius.circular(6),
              matchedTextStyle: const TextStyle(fontWeight: FontWeight.w600),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          _Section(
            title: 'Case-Sensitive',
            child: HighlightText(
              source: 'Flutter FLUTTER flutter — only the exact case matches.',
              highlight: const HighlightQuery.single('Flutter'),
              highlightColor: Colors.red.shade200,
              caseSensitive: true,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),

          _Section(
            title: 'Layout — maxLines & overflow',
            child: HighlightText(
              source:
                  'A long sentence about Flutter text highlighting that will be '
                  'truncated after two lines because maxLines is set to 2 and '
                  'overflow is set to ellipsis in this example.',
              highlight: const HighlightQuery.single('Flutter'),
              highlightColor: Colors.yellow.shade600,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.grey.shade600)),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 4),
              child: Text(subtitle!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.blue)),
            ),
          const SizedBox(height: 6),
          child,
          const Divider(height: 32),
        ],
      ),
    );
  }
}
