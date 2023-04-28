import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen_app_daiict/widgets/design/sellers_design.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import '../models/sellers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<QueryDocumentSnapshot<Object?>> restaurantsDocumentsList = [];
  String sellerNameText = "";

  @override
  void initState() {
    super.initState();
    initSearchingRestaurant("");
  }

initSearchingRestaurant(String textEntered) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('sellers').get();
    List<Map<String, dynamic>> filteredDocuments = snapshot.docs
        .map((doc) {
          int score = tokenSortRatio(textEntered, doc['sellerName']);
          // print score of each document
          print(textEntered +
              " : " +
              doc['sellerName'] +
              " : " +
              score.toString());
          return {'doc': doc, 'score': score};
        })
        .where((element) =>
            element['score'] != null && (element['score'] as int) > 30)
        .toList()
        .cast<Map<String, dynamic>>()
      ..sort((a, b) => b['score'].compareTo(a['score']));
    if (filteredDocuments.isEmpty && textEntered.isNotEmpty) {
      filteredDocuments = snapshot.docs
          .map((doc) => {
                'doc': doc,
                'score': tokenSortRatio(textEntered, doc['sellerName'])
              })
          .toList()
          .cast<Map<String, dynamic>>()
        ..sort((a, b) => b['score'].compareTo(a['score']))
        ..take(5);
    }
    setState(() {
      restaurantsDocumentsList = filteredDocuments
          .map((e) => e['doc'] as QueryDocumentSnapshot<Object?>)
          .toList();
    });
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
        title: TextField(
          onChanged: (textEntered) {
            setState(() {
              sellerNameText = textEntered;
            });
            //init search
            initSearchingRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: "Search Restaurant here",
            hintStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                initSearchingRestaurant(sellerNameText);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: restaurantsDocumentsList.length,
        itemBuilder: (context, index) {
          Sellers model = Sellers.fromJson(
              restaurantsDocumentsList[index].data()! as Map<String, dynamic>);
          return SellersDesignWidget(
            model: model,
            context: context,
          );
        },
      ),
    );
  }
}
