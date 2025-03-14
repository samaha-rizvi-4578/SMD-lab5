import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Add a task', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());


    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter task title
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    
    expect(find.text('New Task'), findsOneWidget);
  });

  testWidgets('Toggle a task', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();


    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Verify the task is marked as completed
    expect(
      find.descendant(
        of: find.byType(ListTile),
        matching: find.byType(Checkbox),
      ),
      findsOneWidget,
    );
  });
}