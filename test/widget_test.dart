import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktest/main.dart';
import 'package:tasktest/presentation/screens/task_screen.dart';

void main() {
  testWidgets('Smoke test for Task Manager app', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));

    expect(find.byType(TaskScreen), findsOneWidget);
  });
}
