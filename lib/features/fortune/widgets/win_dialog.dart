import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mswm_test/core/utils.dart';

class RewardSlotDialog extends StatefulWidget {
  const RewardSlotDialog({super.key});

  @override
  State<RewardSlotDialog> createState() => _RewardSlotDialogState();
}

class _RewardSlotDialogState extends State<RewardSlotDialog> {
  bool tapped = false;
  bool luck = false;

  int getRandom() {
    Random random = Random();
    List<int> options = [1, 2, 3];
    return options[random.nextInt(options.length)];
  }

  void onRewardTap(int id) {
    int random = getRandom();
    tapped = true;
    if (random == id) {
      luck = true;
      addCoins(80);
    } else {
      luck = false;
    }
    setState(() {});
  }

  void onGet() {
    // save coins
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        print('POP');
        // save coins
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 364,
          width: 232,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      height: 306,
                      width: 228,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 3,
                            color: Color(0xff7ABBEB),
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff0077FF),
                            Color(0xffCC00FF),
                            Color(0xff7300FF),
                            Color(0xffFF00FB),
                            Color(0xff002BFF),
                          ],
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff374899),
                              Color(0xff0D014F),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(-22 / 360),
                              child: Image.asset(
                                'assets/daily1.png',
                                height: 96,
                              ),
                            ),
                            const Text(
                              'Daily Reward',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Choose one of the cards and\nfind out what bonus awaits you',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (tapped)
                              Container(
                                height: 45,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff2F3B8C),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (luck) ...[
                                      SvgPicture.asset('assets/coin.svg'),
                                      const SizedBox(width: 4),
                                      const Text(
                                        '80',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        'Better luck\nnext time',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _Reward(id: 1, onPressed: onRewardTap),
                                  const SizedBox(width: 20),
                                  _Reward(id: 2, onPressed: onRewardTap),
                                  const SizedBox(width: 20),
                                  _Reward(id: 3, onPressed: onRewardTap),
                                ],
                              ),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (tapped) ...[
                      if (luck) ...[
                        CupertinoButton(
                          onPressed: onGet,
                          padding: EdgeInsets.zero,
                          minSize: 40,
                          child: SvgPicture.asset(
                            'assets/reward2.svg',
                          ),
                        ),
                      ] else ...[
                        CupertinoButton(
                          onPressed: () {
                            context.pop();
                          },
                          padding: EdgeInsets.zero,
                          minSize: 40,
                          child: SvgPicture.asset(
                            'assets/reward3.svg',
                          ),
                        ),
                      ]
                    ] else ...[
                      Stack(
                        children: [
                          Image.asset(
                            'assets/okbuttonbg.png',
                            height: 40,
                          ),
                          SvgPicture.asset(
                            'assets/reward1.svg',
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 18,
                child: CupertinoButton(
                  onPressed: () {
                    context.pop();
                  },
                  padding: EdgeInsets.zero,
                  minSize: 25,
                  child: SvgPicture.asset('assets/close.svg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Reward extends StatelessWidget {
  const _Reward({
    required this.id,
    required this.onPressed,
  });

  final int id;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        onPressed(id);
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff2F3B8C),
        ),
        child: Center(
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(-22 / 360),
            child: Image.asset(
              'assets/daily1.png',
              height: 55,
            ),
          ),
        ),
      ),
    );
  }
}
