import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_highlight_codespark/text_highlight_codespark.dart';

void main() {
  const source = 'This is an example of text highlighting.';

  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('HighlightText', () {
    testWidgets('single query — preserves full text', (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: source,
          highlight: HighlightQuery.single('example'),
        ),
      ));
      expect(tester.takeException(), isNull);
      expect(
        find.byWidgetPredicate((w) =>
            w is Text && (w.textSpan?.toPlainText() == source)),
        findsOneWidget,
      );
    });

    testWidgets('single query — no match renders full text', (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: source,
          highlight: HighlightQuery.single('zzz'),
        ),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('multiple queries — preserves full text', (tester) async {
      const src =
          'This is an example of highlighting multiple queries in the text.';
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: src,
          highlight: HighlightQuery.multiple(['highlight', 'text']),
        ),
      ));
      expect(tester.takeException(), isNull);
      expect(
        find.byWidgetPredicate((w) =>
            w is Text && (w.textSpan?.toPlainText() == src)),
        findsOneWidget,
      );
    });

    testWidgets('multiple queries — per-query colors accepted', (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: 'flutter and dart are great',
          highlight: HighlightQuery.multiple(
            ['flutter', 'dart'],
            colors: {'flutter': Colors.blue, 'dart': Colors.teal},
          ),
        ),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('multiple queries — regex special chars escaped',
        (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: 'c++ is a language, so is c#',
          highlight: HighlightQuery.multiple(['c++', 'c#']),
        ),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('regex — preserves full text', (tester) async {
      const src = 'The years 2023, 2024, and 2025 are important.';
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: src,
          highlight: HighlightQuery.regex(r'\b\d{4}\b'),
        ),
      ));
      expect(tester.takeException(), isNull);
      expect(
        find.byWidgetPredicate((w) =>
            w is Text && (w.textSpan?.toPlainText() == src)),
        findsOneWidget,
      );
    });

    testWidgets('regex — matchedTextStyle applied', (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: 'The year 2024 matters.',
          highlight: HighlightQuery.regex(r'\d+'),
          matchedTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('onTap fires with matched text', (tester) async {
      String? tapped;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
            child: HighlightText(
              source: 'Tap flutter here.',
              highlight: const HighlightQuery.single('flutter'),
              highlightColor: Colors.yellow,
              // Use borderRadius so the match renders as a GestureDetector,
              // making it reliably tappable in widget tests.
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              onTap: (t) => tapped = t,
            ),
          ),
        ),
      ));
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();
      expect(tapped, 'flutter');
    });

    testWidgets('borderRadius renders without error', (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: 'Rounded highlight.',
          highlight: HighlightQuery.single('highlight'),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('caseSensitive false matches regardless of case',
        (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: 'Flutter FLUTTER flutter',
          highlight: HighlightQuery.single('flutter'),
          caseSensitive: false,
        ),
      ));
      expect(tester.takeException(), isNull);
    });

    testWidgets('empty query renders source unchanged', (tester) async {
      await tester.pumpWidget(wrap(
        const HighlightText(
          source: source,
          highlight: HighlightQuery.single(''),
        ),
      ));
      expect(tester.takeException(), isNull);
    });
  });
}
