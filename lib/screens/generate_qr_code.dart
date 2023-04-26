import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String _userCartJson = '';

  Future<void> _getUserCart() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      final List<dynamic> userCart = userDoc.get('userCart');
      final Map<String, dynamic> userCartMap = {'userCart': userCart};
      _userCartJson = jsonEncode(userCartMap);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: QrImage(
          data: _userCartJson,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
