import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_btn.dart';
import 'components/sign_in_form.dart';
import 'constants/constants.dart';

class Contents extends StatelessWidget {
  const Contents({
    super.key,
    required RiveAnimationController btnAnimationColtroller,
  }) : _btnAnimationColtroller = btnAnimationColtroller;

  final RiveAnimationController _btnAnimationColtroller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              customGeneralDialog(context);
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
    ));
  }

  Future<Object?> customGeneralDialog(BuildContext context) {
    return showGeneralDialog(
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
                  style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Image.asset(
                        Constants.emailLogoPath2,
                        height: 64,
                        width: 64,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        Constants.appleLogoPath,
                        height: 64,
                        width: 64,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        Constants.googleLogoPath,
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
  }
}
