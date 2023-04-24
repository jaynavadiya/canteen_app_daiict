import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {
  final String userId;

  QRCodeGenerator({super.key, required this.userId});

  // String _cartData = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR Code"),
      ),
      body: Center(
        child: QrImage(
          data: userId,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
