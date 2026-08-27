import 'package:flutter_test/flutter_test.dart';

import 'package:winnapp/app/app.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Field Visit Log'), findsWidgets);
  });
}