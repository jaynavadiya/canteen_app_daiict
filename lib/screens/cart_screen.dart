import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:canteen_app_daiict/assistantMethods/assistant_methods.dart';
import 'package:canteen_app_daiict/assistantMethods/total_amount.dart';
import 'package:canteen_app_daiict/splash_screen/splash_screen.dart';
import 'package:canteen_app_daiict/widgets/design/cart_item_design.dart';
import 'package:canteen_app_daiict/widgets/progress_bar.dart';
import '../assistantMethods/cart_item_counter.dart';
import '../models/items.dart';
import '../widgets/text_widget_header.dart';
import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  final String? sellerUID;

  const CartScreen({Key? key, this.sellerUID}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;

  num totalAmount = 0;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);

    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ),
              Positioned(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 3,
                      right: 4,
                      child: Center(
                        child: Consumer<CartItemCounter>(
                            builder: (context, counter, c) {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.clear_all),
          onPressed: () {
            clearCartNow(context);
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text(
                "Clear Cart",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.amber,
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                clearCartNow(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const SplashScreen()));

                Fluttertoast.showToast(msg: "Cart has been cleared.");
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text(
                "Check Out",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.amber,
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                // ====================== CHECKOUT ====================== //
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-1.0, 0.0),
            end: FractionalOffset(2.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            //overall total price
            SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(title: "My Cart List"),
            ),

            SliverToBoxAdapter(
              child: Consumer2<TotalAmount, CartItemCounter>(
                  builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total Price: ${"\₹" + amountProvider.tAmount.toString()}",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                  ),
                );
              }),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("items").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: circularProgress(),
                    ),
                  );
                }

                final docs = snapshot.data!.docs
                    .where((doc) => separateItemIDs().contains(doc.id))
                    .toList();
                final itemCount = docs.length;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Items model = Items.fromJson(
                        docs[index].data()! as Map<String, dynamic>,
                      );

                      if (index == 0) {
                        totalAmount = 0;
                        totalAmount = totalAmount +
                            (model.price! * separateItemQuantityList![index]);
                      } else {
                        totalAmount = totalAmount +
                            (model.price! * separateItemQuantityList![index]);
                        print("Index is $index");
                      }

                      if (index == itemCount - 1) {
                        print("In the last item of the list with index $index");
                        WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            Provider.of<TotalAmount>(context, listen: false)
                                .displayTotalAmount(totalAmount.toDouble());

                            print("Total amount is $totalAmount");
                          },
                        );
                      }

                      return CartItemDesign(
                        model: model,
                        context: context,
                        quanNumber: separateItemQuantityList![index],
                      );
                    },
                    childCount: itemCount,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
