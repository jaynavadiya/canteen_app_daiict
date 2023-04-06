import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'components/animated_btn.dart';
import 'components/sign_in_form.dart';

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
                    showGeneralDialog(
                      barrierDismissible: true,
                      barrierLabel: "Sign In",
                      context: context,
                      pageBuilder: (context, _, __) => Center(
                        child: Container(
                          height: 620,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.symmetric(
                            vertical: 32,
                            horizontal: 24,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Column(
                              children: [
                                const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 34, fontFamily: "Poppins"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "Order food from your favourite canteen and get it by when you reach the canteen!",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SignInForm(),
                                Row(
                                  children: const [
                                    Expanded(child: Divider()),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Text(
                                        "OR",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Expanded(child: Divider())
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "Sign up with Email, Apple or Google",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/icons/email_black_2.png",
                                        height: 64,
                                        width: 64,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/icons/apple_black.png",
                                        height: 64,
                                        width: 64,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/icons/google_black.png",
                                        height: 64,
                                        width: 64,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: Text(
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
