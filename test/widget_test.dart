import 'package:flutter_test/flutter_test.dart';
import 'package:shiksha_setu/main.dart'; // 👈 adjust if your project folder name differs

void main() {
  testWidgets('App loads ShikshaSetu without crashing',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ShikshaSetuApp());

    // Verify that splash screen shows.
    expect(find.text('Login with Google'), findsOneWidget);
  });
}
