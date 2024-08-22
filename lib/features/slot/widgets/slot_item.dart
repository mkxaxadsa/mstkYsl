import 'package:flutter/material.dart';

class SlotItem extends StatelessWidget {
  const SlotItem({super.key, required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Image.asset(
        'assets/$asset.png',
        width: 66,
      ),
    );
  }
}
