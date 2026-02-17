import 'package:flutter_test/flutter_test.dart';
import 'package:sentra_pay/main.dart';

void main() {
  testWidgets('App launches without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const SentraPayApp());
    expect(find.text('Sentra'), findsOneWidget);
  });
}
