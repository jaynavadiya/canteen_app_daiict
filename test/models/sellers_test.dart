import 'package:flutter_test/flutter_test.dart';
import 'package:canteen_app_daiict/models/sellers.dart';

void main() {
  group('Sellers model', () {
    test('fromJson() should return a valid model', () {
      // Arrange
      final data = <String, dynamic>{
        'sellerUID': 'seller_uid',
        'sellerName': 'Seller name',
        'sellerAvatarUrl': 'https://example.com/avatar.jpg',
        'sellerEmail': 'seller@example.com',
      };

      // Act
      final model = Sellers.fromJson(data);

      // Assert
      expect(model.sellerUID, data['sellerUID']);
      expect(model.sellerName, data['sellerName']);
      expect(model.sellerAvatarUrl, data['sellerAvatarUrl']);
      expect(model.sellerEmail, data['sellerEmail']);
    });

    test('toJson() should return a valid map', () {
      // Arrange
      final model = Sellers(
        sellerUID: 'seller_uid',
        sellerName: 'Seller name',
        sellerAvatarUrl: 'https://example.com/avatar.jpg',
        sellerEmail: 'seller@example.com',
      );

      // Act
      final data = model.toJson();

      // Assert
      expect(data['sellerUID'], model.sellerUID);
      expect(data['sellerName'], model.sellerName);
      expect(data['sellerAvatarUrl'], model.sellerAvatarUrl);
      expect(data['sellerEmail'], model.sellerEmail);
    });
  });
}
