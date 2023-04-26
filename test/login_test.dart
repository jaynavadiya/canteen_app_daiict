import 'package:canteen_app_daiict/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login screen has login form', (WidgetTester tester) async {
    // Build the login screen widget.
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Verify that the login form exists.
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Login form requires email and password',
      (WidgetTester tester) async {
    // Build the login screen widget.
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Tap the login button without entering email and password.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that an error dialog is shown.
    expect(find.text('Please enter email/password.'), findsOneWidget);
  });

  testWidgets('Login form submits valid credentials',
      (WidgetTester tester) async {
    // Build the login screen widget.
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Enter valid email and password.
    await tester.enterText(
        find.byType(TextFormField).first, 'user@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'password123');

    // Tap the login button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that the home screen is shown.
    expect(find.text('Welcome to the Canteen App!'), findsOneWidget);
  });
}
