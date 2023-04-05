import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    super.key,
    required RiveAnimationController btnAnimationColtroller,
    required this.press,
  }) : _btnAnimationColtroller = btnAnimationColtroller;

  final RiveAnimationController _btnAnimationColtroller;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
          height: 64,
          width: 260,
          child: Center(
            child: Stack(
              children: [
                RiveAnimation.asset(
                  "assets/RiveAssets/button.riv",
                  controllers: [_btnAnimationColtroller],
                ),
                Positioned.fill(
                  top: 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 45,
                      ),
                      Icon(CupertinoIcons.arrow_right),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Start ordering now",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
