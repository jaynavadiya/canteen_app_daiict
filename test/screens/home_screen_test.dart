// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:canteen_app_daiict/screens/home_screen.dart';

void main() {

    testWidgets('Widget testing of appbar title of Home Screen', (WidgetTester tester) async {
     await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));

      // Verify that the appbar title is displayed
      final canteenManagementApp = find.byKey(const Key('canteenManagementApp'));
      expect(canteenManagementApp, findsOneWidget);
    
    });

      testWidgets('Widget testing of add menu button of Home Screen', (WidgetTester tester) async {
     await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));

      // Verify that the add menu button is displayed
      final icon = find.byIcon(Icons.add);
      expect(icon, findsOneWidget);
    
    });

      testWidgets('Widget testing of seller info of Home Screen', (WidgetTester tester) async {
     await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));

      // Verify that the seller info is displayed
      Type SellerInfo = Null;
      final sellerInfo = find.byType(SellerInfo);
      expect(sellerInfo, findsOneWidget);
    
    });

      testWidgets('Widget testing of menus of Home Screen', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));

      // Verify that the menus are displayed
      Type InfoDesignWidget = Null;
      final infoDesignWidget = find.byType(InfoDesignWidget);
      expect(InfoDesignWidget, findsWidgets);

    });

      testWidgets('Widget testing of progress bar of Home Screen', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen(),));

      // Verify that the progress bar is not displayed
      final circularProgressIndicator = find.byType(CircularProgressIndicator);
      expect(CircularProgressIndicator, findsNothing);

    });

}