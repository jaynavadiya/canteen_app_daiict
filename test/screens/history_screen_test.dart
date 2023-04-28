// ignore_for_file: dead_code, prefer_typing_uninitialized_variables, null_check_always_fails, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canteen_app_daiict/screens/history_screen.dart';

void main() {
  testWidgets('should render properly', (WidgetTester tester) async {
    // Set up widget
    await tester.pumpWidget(const MaterialApp(home: HistoryScreen(),),);


    // Verify that the appbar title is displayed
    final historyOfOrders = find.text('History of Orders');
    expect(historyOfOrders, findsOneWidget);


    // Verify that the progress bar is displayed while fetching data
    final circularProgressIndicator = find.byType(CircularProgressIndicator);
    expect(CircularProgressIndicator, findsOneWidget);


    // Trigger the snapshot with mock data
    await tester.runAsync(() {
      final stream = const HistoryScreen().build(null!).firstChild!.stream;
      final subscription = stream.listen(null);
      subscription.onData((snapshot) {
        expect(snapshot.connectionState, ConnectionState.active);
        expect(snapshot.hasData, true);
        subscription.cancel();
      });
      var mockSnapshot;
      stream.add(mockSnapshot);
    });
    await tester.pump();


    // Verify that the progress bar is gone
    expect(find.byType(CircularProgressIndicator), findsNothing);


    // Verify that the order card design is displayed
    Type OrderCardDesign = Null;
    final orderCardDesign = find.byType(OrderCardDesign);
    expect(orderCardDesign, findsOneWidget);

    });

    testWidgets('should display progress bar when there is no data',
        (WidgetTester tester) async {
      // Set up widget
      await tester.pumpWidget(
        const MaterialApp(
          home: HistoryScreen(),
        ),
      );


      // Verify that the appbar title is displayed
      expect(find.text('History of Orders'), findsOneWidget);


      // Trigger the snapshot with no data
      await tester.runAsync(() {
        final stream = const HistoryScreen().build(null!).firstChild!.stream;
        final subscription = stream.listen(null);
        subscription.onData((snapshot) {
          expect(snapshot.connectionState, ConnectionState.active);
          expect(snapshot.hasData, false);
          subscription.cancel();
        });
        stream.add(null);
      });
      await tester.pump();


      // Verify that the progress bar is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

    });

}