import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canteen_app_daiict/assistantMethods/address_changer.dart';
import 'package:canteen_app_daiict/assistantMethods/cart_item_counter.dart';
import 'package:canteen_app_daiict/assistantMethods/total_amount.dart';

import 'global/global.dart';
import 'splash_screen/splash_screen.dart';
import 'package:canteen_app_daiict/screens/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: ((c) => CartItemCounter()),
//         ),
//         ChangeNotifierProvider(
//           create: ((c) => TotalAmount()),
//         ),
//         ChangeNotifierProvider(
//           create: ((c) => AddressChanger()),
//         )
//       ],
//       child: MaterialApp(
//         title: 'DAIICT Canteen Application',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.amber,
//         ),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((c) => CartItemCounter()),
        ),
        ChangeNotifierProvider(
          create: ((c) => TotalAmount()),
        ),

      ],
      child: MaterialApp(
        title: 'DAIICT Canteen Application',
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFEEF1F8),
            primarySwatch: Colors.blue,
            fontFamily: "Inter",
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              errorStyle: TextStyle(height: 0),
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
              errorBorder: defaultInputBorder,
            )),
        home: const OnBoardingScreen(),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
