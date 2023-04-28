// Import necessary packages and files
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:canteen_app_daiict/assistantMethods/assistant_methods.dart';
import 'package:canteen_app_daiict/widgets/items_avatar_carousel.dart';
import 'package:canteen_app_daiict/widgets/my_drawer.dart';
import 'package:canteen_app_daiict/widgets/progress_bar.dart';

import '../authentication/login.dart';
import '../models/sellers.dart';
import '../widgets/seller_avatar_carousel.dart';
import '../widgets/design/sellers_design.dart';
import '../widgets/user_info.dart';

// Define a stateful widget for the HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Define a state for the HomeScreen widget
class _HomeScreenState extends State<HomeScreen> {
  // Create instances of necessary classes
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _controller = TextEditingController();

  // Execute this function when the state is first created
  @override
  void initState() {
    super.initState();

    // Clear the cart when the screen is first loaded
    clearCartNow(context);
  }

  // Build the HomeScreen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(), // Create a drawer for the screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Set a gradient background for the container
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(5.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Set the appbar for the screen
            SliverAppBar(
              elevation: 1,
              pinned: true,
              backgroundColor: const Color(0xFFFAC898),
              foregroundColor: Colors.black,
              expandedHeight: 50,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset(-1.0, 0.0),
                    end: FractionalOffset(4.0, -1.0),
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFAC898),
                    ],
                  ),
                ),
                child: FlexibleSpaceBar(
                  title: Text(
                    'Canteen',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  centerTitle: false,
                ),
              ),
              actions: [
                // Create a button for logging out
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                      ),
                      child: const Icon(Icons.exit_to_app),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Warning'),
                          content:
                              const Text('Are you sure you want to log out?'),
                          actions: [
                            // Define two buttons for the alert dialog
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                firebaseAuth.signOut().then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => const LoginScreen(),
                                    ),
                                  );
                                  _controller.clear();
                                });
                              },
                              child: const Text('Log Out'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Display user information widget //Carausel
            const SliverToBoxAdapter(
              child: UserInformation(),
            ),

            // Display sellers' information in a staggered grid view
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("sellers").snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                        crossAxisCount: 1,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        itemBuilder: (context, index) {
                          // Convert seller's information from JSON to object model
                          Sellers smodel = Sellers.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: SellersDesignWidget(
                              model: smodel,
                              context: context,
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
