import 'package:flutter_test/flutter_test.dart';
import 'package:smartcart/main.dart';

void main() {
  testWidgets('Login screen is shown by default', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartMartApp());
    await tester.pumpAndSettle();

    expect(find.text('SmartMart'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('user@smartmart.com'), findsWidgets);
  });
}
