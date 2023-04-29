import 'package:flutter_test/flutter_test.dart';
import 'package:canteen_app_daiict/assistantMethods/address_changer.dart';

void main() {
  group('AddressChanger', () {
    test('displayResult updates _counter', () {
      //Arrange
      final addressChanger = AddressChanger();
      //Act
      addressChanger.displayResult(5);
      //Assert
      expect(addressChanger.count, 5);
    });
  });
}
