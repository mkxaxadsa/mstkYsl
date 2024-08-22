import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'daily_reward_dialog.dart';

class DailyRewardButton extends StatelessWidget {
  const DailyRewardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const DailyRewardDialog();
          },
        );
      },
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          RotationTransition(
            turns: const AlwaysStoppedAnimation(-22 / 360),
            child: Image.asset(
              'assets/daily1.png',
              height: 55,
            ),
          ),
          SvgPicture.asset('assets/daily1.svg'),
        ],
      ),
    );
  }
}
