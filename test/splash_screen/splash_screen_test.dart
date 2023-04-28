import 'package:canteen_app_daiict/authentication/login.dart';
import 'package:canteen_app_daiict/splash_screen/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:canteen_app_daiict/screens/home_screen.dart';

// import 'package:my_app/authentication/login.dart';
// import 'package:my_app/screens/splash_screen.dart';

// Mock FirebaseAuth instance for testing purposes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late SplashScreen splashScreen;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    splashScreen = const SplashScreen();
  });

  group('SplashScreen Widget', () {
    testWidgets('renders without exploding', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: splashScreen));
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('navigates to HomeScreen if user is authenticated',
        (WidgetTester tester) async {
      when(mockFirebaseAuth.currentUser).thenReturn(User(uid: '123'));
      await tester.pumpWidget(MaterialApp(
        home: SplashScreen(),
      ));
      // Wait for the animation to complete
      await tester.pumpAndSettle(const Duration(seconds: 6));
      // Verify that the navigator pushed to the HomeScreen
      verify(mockFirebaseAuth.currentUser).called(1);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('navigates to LoginScreen if user is not authenticated',
        (WidgetTester tester) async {
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      await tester.pumpWidget(MaterialApp(
        home: SplashScreen(),
      ));
      // Wait for the animation to complete
      await tester.pumpAndSettle(const Duration(seconds: 6));
      // Verify that the navigator pushed to the LoginScreen
      verify(mockFirebaseAuth.currentUser).called(1);
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
