import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../utils.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32 + getStatusBar(context)),
      child: const Row(
        children: [
          SizedBox(width: 25),
          CoinsCount(),
          SizedBox(width: 16),
          DiamonsCount(),
          Spacer(),
          Settings(),
          SizedBox(width: 25),
        ],
      ),
    );
  }
}

class CoinsCount extends StatelessWidget {
  const CoinsCount();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/coin2.svg'),
        Positioned(
          top: 3,
          left: 13,
          child: SvgPicture.asset('assets/coin.svg'),
        ),
        Positioned(
          top: 8,
          left: 55,
          child: ValueListenableBuilder(
            valueListenable: mycoins,
            builder: (context, value, child) => Text(
              value.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DiamonsCount extends StatelessWidget {
  const DiamonsCount();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Stack(
        children: [
          SvgPicture.asset('assets/diamond.svg'),
          Positioned(
            top: 4,
            left: 13,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(22 / 360),
              child: Image.asset(
                'assets/diamond.png',
                width: 20,
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 55,
            child: ValueListenableBuilder(
                valueListenable: mydiamonds,
                builder: (context, value, child) => Text(
                      value.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
          ),
          Positioned(
            right: 0,
            top: 8,
            child: CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              minSize: 13,
              child: SvgPicture.asset('assets/diamond2.svg'),
            ),
          ),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.push('/settings');
      },
      padding: EdgeInsets.zero,
      minSize: 28,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/settings2.svg',
          ),
          Positioned(
            top: 5,
            left: 17,
            child: SvgPicture.asset(
              'assets/settings1.svg',
              height: 18,
            ),
          ),
        ],
      ),
    );
  }
}
