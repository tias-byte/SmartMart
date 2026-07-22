import 'package:flutter_test/flutter_test.dart';
import 'package:smartmart/main.dart';

void main() {
  testWidgets('SmartMart app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartMartApp());
    expect(find.text('SmartMart Quick Commerce Platform'), findsOneWidget);
  });
}
