import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app.dart';

void main() {
  testWidgets('blood test upload flow uses fake local state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BloodLensApp());

    expect(find.text('BloodLens'), findsOneWidget);
    expect(find.text('Upload blood test'), findsOneWidget);
    expect(find.text('Waiting for a report'), findsOneWidget);
    expect(find.text('AI analysis'), findsNothing);

    await tester.tap(find.text('Upload blood test'));
    await tester.pump();

    expect(find.text('File attached'), findsOneWidget);
    expect(find.text('Ready to analyze'), findsOneWidget);

    await tester.tap(find.text('Analyze result'));
    await tester.pump();

    expect(find.text('Reading biomarkers'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
    await tester.pump();

    expect(find.text('Analysis ready'), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('AI analysis'), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -900));
    await tester.pumpAndSettle();

    expect(find.text('Recommendations'), findsOneWidget);
  });
}
