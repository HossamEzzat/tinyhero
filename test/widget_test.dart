import 'package:flutter_test/flutter_test.dart';
import 'package:tinyhero/main.dart';

void main() {
  testWidgets('Tiny Hero boots to onboarding or home', (tester) async {
    await tester.pumpWidget(const TinyHeroApp());
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.textContaining('Tiny Hero'), findsWidgets);
  });
}
