import 'package:flutter_test/flutter_test.dart';
import 'package:winnapp/app/app.dart';
import 'package:winnapp/app/di/injection.dart';

void main() {
  setUp(() {
    configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('App loads successfully', (tester) async {
    await tester.pumpWidget(
      const App(),
    );

    await tester.pump();

    expect(find.text('Visits'), findsOneWidget);
  });
}