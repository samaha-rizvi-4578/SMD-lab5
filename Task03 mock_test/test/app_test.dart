import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mock_test/main.dart'; 

void main() {
  testWidgets('Displays stored value from SharedPreferences', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'saved_text': 'Mocked Value'});
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Mocked Value'), findsOneWidget);
  });
}
