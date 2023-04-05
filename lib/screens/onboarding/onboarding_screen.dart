import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'components/animated_btn.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late RiveAnimationController _btnAnimationColtroller;

  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //for adding blur on the whole screen
          Positioned(
              // height: 100,
              width: MediaQuery.of(context).size.width * 1.7,
              bottom: 100,
              left: 100,
              child: Image.asset("assets/Backgrounds/Spline.png")),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          )),
          RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: SizedBox(),
          )),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                SizedBox(
                  width: 300,
                  child: Column(
                    children: const [
                      Text(
                        "DA-IICT Canteen Service",
                        style: TextStyle(
                            fontSize: 60, fontFamily: "Poppins", height: 1.2),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Order food from your favourite canteen and get it by when you reach the canteen!",
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                AnimatedBtn(
                  btnAnimationColtroller: _btnAnimationColtroller,
                  press: () {
                    _btnAnimationColtroller.isActive = true;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: const Text(
                      "Satisfy your cravings and manage your meals with ease. Get started now and taste the difference!"),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
