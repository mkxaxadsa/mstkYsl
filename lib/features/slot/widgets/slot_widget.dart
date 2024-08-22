import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';

class SlotWidget extends StatelessWidget {
  const SlotWidget({
    super.key,
    required this.childrens,
    required this.seconds,
    required this.top,
    this.left = false,
    this.right = false,
  });

  final List<Widget> childrens;
  final int seconds;
  final double top;
  final bool left;
  final bool right;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 224,
      width: 144,
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(left ? 16 : 0),
          bottomLeft: Radius.circular(left ? 16 : 0),
          topRight: Radius.circular(right ? 16 : 0),
          bottomRight: Radius.circular(right ? 16 : 0),
        ),
        border: Border.all(
          width: 2,
          color: AppColors.main50,
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: seconds),
            curve: Curves.easeInOutCirc,
            bottom: top,
            left: 0,
            right: 0,
            child: Column(children: childrens),
          ),
        ],
      ),
    );
  }
}
