import 'package:canteen_app_daiict/assistantMethods/total_amount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TotalAmount', () {
    test('displayTotalAmount should update tAmount', () async {
      // Arrange
      // Create a new TotalAmount instance
      final totalAmount = TotalAmount();
      // Act
      // Call displayTotalAmount with a number
      await totalAmount.displayTotalAmount(10.0);
      // Assert
      // Verify that tAmount has been updated
      expect(totalAmount.tAmount, equals(10.0));
    });

    test('displayTotalAmount should notify listeners', () async {
      // Arrange
      // Create a new TotalAmount instance
      final totalAmount = TotalAmount();
      // Create a mock listener
      int notifiedCount = 0;
      final listener = () {
        notifiedCount++;
      };
      // Add the listener to the TotalAmount instance
      totalAmount.addListener(listener);
      // Act
      // Call displayTotalAmount with a number
      await totalAmount.displayTotalAmount(10.0);
      // Assert
      // Verify that the listener has been notified
      expect(notifiedCount, equals(1));
      // Remove the listener from the TotalAmount instance
      totalAmount.removeListener(listener);
    });
  });
}
