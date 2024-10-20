import 'package:flutter_test/flutter_test.dart';
import 'package:hogastos/configurations/routes.dart';

import 'package:hogastos/main.dart';

// Tap the '+' icon and trigger a frame.
//await tester.tap(find.byIcon(Icons.add));
//await tester.pump();

void main() {
  testWidgets('Render appbar with title', (WidgetTester tester) async {
    await tester.pumpWidget(AppContainer(routes: Routes()));

    expect(find.text('Hogastos'), findsOneWidget);
  });
}
