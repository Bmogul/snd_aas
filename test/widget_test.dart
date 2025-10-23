// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:snd_aas/app.dart';
import 'package:snd_aas/providers/theme_provider.dart';

void main() {
  testWidgets('App loads greeting page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
        child: const SNDApp(),
      ),
    );

    // Verify that the greeting page loads with SND text
    expect(find.text('SND'), findsOneWidget);
  });
}
