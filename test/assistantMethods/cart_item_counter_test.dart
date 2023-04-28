import 'package:canteen_app_daiict/global/global.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canteen_app_daiict/assistantMethods/cart_item_counter.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final mockSharedPreferences = MockSharedPreferences();

  group('CartItemCounter', () {
    test('displayCartListItemsNumber updates cartListItemCounter', () async {
      //Arrange
      when(mockSharedPreferences.getStringList("userCart"))
          .thenReturn(["item1", "item2", "item3"]);
      sharedPreferences = mockSharedPreferences;
      final cartItemCounter = CartItemCounter();
      //Act
      await cartItemCounter.displayCartListItemsNumber();
      //Assert
      expect(cartItemCounter.count, 2);
    });
  });
}
