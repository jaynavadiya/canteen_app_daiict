import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen_app_daiict/assistantMethods/assistant_methods.dart';
import 'package:canteen_app_daiict/global/global.dart';
import 'package:canteen_app_daiict/widgets/design/order_card_design.dart';
import 'package:canteen_app_daiict/widgets/progress_bar.dart';
import 'package:canteen_app_daiict/widgets/simple_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "My Orders",
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(5.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("status", whereIn: ["normal", "cooked"])
              .where("orderBy", isEqualTo: sharedPreferences!.getString("uid"))
              .orderBy("orderTime", descending: true)
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("items")
                            .where("itemID",
                                whereIn: separateOrdesItemIDs(
                                    (snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>)["productIDs"]))
                            .where("orderBy",
                                whereIn: (snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>)["uid"])
                            .orderBy("publishedDate", descending: true)
                            .get(),
                        builder: (c, snap) {
                          return snap.hasData
                              ? OrderCard(
                                  orderStatus: (snapshot.data!.docs[index]
                                          .data()! as Map<String, dynamic>)
                                      ["status"],
                                  itemCount: snap.data!.docs.length,
                                  data: snap.data!.docs,
                                  orderID: snapshot.data!.docs[index].id,
                                  seperateQuantitiesList:
                                      separateOrderItemQuantities(
                                          (snapshot.data!.docs[index].data()!
                                                  as Map<String, dynamic>)[
                                              "productIDs"]),
                                )
                              : Center(
                                  child: circularProgress(),
                                );
                        },
                      );
                    },
                  )
                : Center(
                    child: circularProgress(),
                  );
          },
        ),
      ),
    );
  }
}
