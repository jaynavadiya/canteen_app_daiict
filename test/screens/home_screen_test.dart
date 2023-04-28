import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canteen_app_daiict/screens/home_screen.dart';
import 'package:canteen_app_daiict/widgets/my_drawer.dart';
import 'package:canteen_app_daiict/widgets/user_info.dart';
import 'package:mockito/mockito.dart';

abstract class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  // group('HomeScreen Widget Tests', () {
  testWidgets('Renders a Scaffold', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final scaffoldFinder = find.byType(Scaffold);
    expect(scaffoldFinder, findsOneWidget);
  });

  testWidgets('Renders a Drawer', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final drawerFinder = find.byType(MyDrawer);
    expect(drawerFinder, findsOneWidget);
  });

  testWidgets('Renders a SliverAppBar', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final appBarFinder = find.byType(SliverAppBar);
    expect(appBarFinder, findsOneWidget);
  });

  testWidgets('Renders a UserInformation widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final userInformationFinder = find.byType(UserInformation);
    expect(userInformationFinder, findsOneWidget);
  });

  testWidgets('Renders a StreamBuilder', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final streamBuilderFinder = find.byType(StreamBuilder);
    expect(streamBuilderFinder, findsOneWidget);
  });
  // });
}
