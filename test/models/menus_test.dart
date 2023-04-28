import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen_app_daiict/models/menus.dart';

void main() {
  group('Menus model', () {
    test('fromJson() should return a valid model', () {
      // Arrange
      final data = <String, dynamic>{
        'menuID': 'menu_id',
        'sellerUID': 'seller_uid',
        'menuTitle': 'Menu title',
        'menuInfo': 'Menu info',
        'publishDate': Timestamp.fromDate(DateTime.now()),
        'thumbnailUrl': 'https://example.com/menu.jpg',
        'status': 'available',
      };

      // Act
      final model = Menus.fromJson(data);

      // Assert
      expect(model.menuID, data['menuID']);
      expect(model.sellerUID, data['sellerUID']);
      expect(model.menuTitle, data['menuTitle']);
      expect(model.menuInfo, data['menuInfo']);
      expect(model.publishDate, data['publishDate']);
      expect(model.thumbnailUrl, data['thumbnailUrl']);
      expect(model.status, data['status']);
    });

    test('toJson() should return a valid map', () {
      // Arrange
      final model = Menus(
        menuID: 'menu_id',
        sellerUID: 'seller_uid',
        menuTitle: 'Menu title',
        menuInfo: 'Menu info',
        publishDate: Timestamp.fromDate(DateTime.now()),
        thumbnailUrl: 'https://example.com/menu.jpg',
        status: 'available',
      );

      // Act
      final data = model.toJson();

      // Assert
      expect(data['menuID'], model.menuID);
      expect(data['sellerUID'], model.sellerUID);
      expect(data['menuTitle'], model.menuTitle);
      expect(data['menuInfo'], model.menuInfo);
      expect(data['publishDate'], model.publishDate);
      expect(data['thumbnailUrl'], model.thumbnailUrl);
      expect(data['status'], model.status);
    });
  });
}
