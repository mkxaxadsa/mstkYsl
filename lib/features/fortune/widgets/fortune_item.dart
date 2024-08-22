import 'package:flutter/material.dart';

class RouletteItem extends StatelessWidget {
  const RouletteItem({
    super.key,
    required this.item,
    required this.degree,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  final int item;
  final double degree;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(degree / 360),
      ),
    );
  }
}
