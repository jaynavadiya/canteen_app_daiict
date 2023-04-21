import 'package:flutter/material.dart';
import 'package:canteen_app_daiict/screens/home_screen.dart';

class StatusBanner extends StatelessWidget {
  final bool? status;
  final String? orderStatus;

  StatusBanner({this.status, this.orderStatus});
  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "Unsuccessful";

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(3.0, -1.0),
          colors: [
            Color(0xFF004B8D),
            Color(0xFFffffff),
          ],
        ),
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => HomeScreen())));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            orderStatus == "ended"
                ? "Parcel Delivered $message"
                : "Order Placed $message",
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
