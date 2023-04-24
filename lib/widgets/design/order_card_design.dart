import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:canteen_app_daiict/screens/order_details_screen.dart';
import '../../models/items.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final String? orderStatus;
  final List<String>? seperateQuantitiesList;

  const OrderCard({
    Key? key,
    this.orderStatus,
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCooked = orderStatus == 'cooked';
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => OrderDetailsScreen(orderID: orderID)),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(bottom: 8),
              height: itemCount! * 90,
              child: ListView.builder(
                itemCount: itemCount,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Items model = Items.fromJson(
                      data![index].data()! as Map<String, dynamic>);
                  return placedOrderDesignWidget(
                      model, context, seperateQuantitiesList![index]);
                },
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isCooked ? Colors.lightGreen : Colors.yellow,
              ),
              child: Text(
                isCooked ? 'Cooked' : 'Cooking',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

Widget placedOrderDesignWidget(
    Items model, BuildContext context, seperateQuantitiesList) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3,
          offset: Offset(2, 2),
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    height: 80,
    child: Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          model.thumbnailUrl!,
          width: 120,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  model.title!,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "\₹ ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              Text(
                model.price.toString() + "   ",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          //total number
          Row(
            children: [
              const Text(
                "x ",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              Expanded(
                  child: Text(
                seperateQuantitiesList,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 30,
                  fontFamily: "Acme",
                ),
              ))
            ],
          )
        ],
      ))
    ]),
  );
}
