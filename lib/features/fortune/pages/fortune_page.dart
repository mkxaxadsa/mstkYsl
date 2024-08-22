import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mswm_test/common/assets.dart';
import 'package:mswm_test/core/widgets/custom_appbar.dart';
import 'package:mswm_test/features/home/widgets/play_button.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';

class FortunePage extends StatefulWidget {
  const FortunePage({super.key});

  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  double turns = 0.0;
  double angle = 0;
  String asset = '';

  List<double> angles = [
    8, // Try again red
    12, // Try again red
    26, // 5
    30, // Try again yel
    16, // Try again red
    18, // 3
    26, // 5
    30, // Try again yel
    34, // Try again yel
    36, // Try again yel
    38, // Try again yel
    30, // Try again yel
    26, // 5
    44, // 1
    47, // 2
    48, // 1
    65, // 1
  ];

  int getCoins() {
    switch (angle) {
      case 8:
      case 12:
      case 16:
        return -1;
      case 30:
      case 34:
      case 36:
      case 38:
        return 0;
      case 26:
        return 5;
      case 18:
        return 3;
      case 44:
      case 48:
      case 65:
        return 1;
      case 47:
        return 2;
      default:
        return 0;
    }
  }

  void getRandom() {
    Random random = Random();
    int randomIndex = random.nextInt(angles.length);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        angle = angles[randomIndex];
        print(angle);
      });
    });
  }

  ValueNotifier<bool> isStop = ValueNotifier(false);

  void onSpin() async {
    if (isStop.value) isStop.value = false;
    setState(() {
      turns += 5 / 1;
    });
    getRandom();
    Future.delayed(const Duration(seconds: 7), () {
      isStop.value = true;
      var coins = getCoins();
      if (coins > 0) addDiamonds(coins);
      var iso = DateTime.now().add(const Duration(days: 1));
      setTimeDiamonds(time: iso.toIso8601String());
      // print(object)
      playButtonTime.value = iso.second;
      getTimer();
    });
  }

  ValueNotifier<int> playButtonTime = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    getTimer();
  }

  getTimer() async {
    DateTime? timeDiamonds = await getTimeDiamonds();

    if (timeDiamonds != null) {
      var time = DateTime.now().difference(timeDiamonds);
      var isAfter = DateTime.now().isAfter(timeDiamonds);
      if (!isAfter) {
        playButtonTime.value = time.inSeconds.abs();
        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (playButtonTime.value < 1) {
            timer.cancel();
          }
          playButtonTime.value--;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // isStop.value = false;
    return CustomScaffold(
      back: true,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10 + getStatusBar(context)),
              SizedBox(
                height: size.width * .18,
              ),
              DecoratedBox(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Color(0xFF61C7FF),
                  )
                ]),
                child: Image.asset(
                  Assets.componentsTitle,
                  fit: BoxFit.fill,
                  height: 40,
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    top: size.width * .88,
                    child: Image.asset(
                      Assets.componentsWheelBottom,
                      width: size.width * .5,
                      height: size.width * .25,
                      // height: 40,
                    ),
                  ),
                  Transform.rotate(
                    angle: angle,
                    child: AnimatedRotation(
                      turns: turns,
                      curve: Curves.easeInOutCirc,
                      duration: const Duration(seconds: 6),
                      child: Stack(
                        children: [
                          Image.asset(
                            Assets.componentsWheel,
                            height: size.width + (size.width * 0.2),
                            width: size.width,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: size.width * .165,
                    child: Image.asset(
                      Assets.componentsWheelPin,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: size.width * .4,
                    child: ValueListenableBuilder(
                        valueListenable: isStop,
                        builder: (context, value, child) {
                          int reward = getCoins();

                          return Visibility(
                            visible: value,
                            child: Container(
                              width: size.width * .7,
                              height: 130,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: size.width * .18),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color(0xFF7300FF)),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF374899),
                                      Color(0xFF0D014F),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.center,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                        color: Color(0xFF7ABBEB)),
                                  ]),
                              child: reward == -1 || reward == 0
                                  ? const Center(
                                      child: Text(
                                        "Oops..\nBetter luck next time",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        const Text(
                                          "Woow Good!",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                reward.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xFF3ECD4F),
                                                  fontSize: 36,
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              Assets.assetsDiamond,
                                              width: 40,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DiamonsCount(),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: playButtonTime,
                    builder: (context, value, child) {
                      if (value < 1) {
                        return PlayButton(
                          asset: 'play',
                          onPressed: () {
                            onSpin();
                          },
                        );
                      }
                      return CupertinoButton(
                        onPressed: null,
                        padding: EdgeInsets.zero,
                        child: SizedBox(
                          height: 90,
                          width: 75,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xff117EC1)),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff888888),
                                        Color(0xffb2b2b2),
                                        Color(0xff979797),
                                        Color(0xff979797),
                                        Color(0xffb0b0b0),
                                        Color(0xffA5a5a5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white),
                                      gradient: const LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color(0xff9F9F9F),
                                          Color(0xff9F9F9F),
                                          Color(0xffC3C3C3),
                                          Color(0xffD9D9D9),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Next\n${formatTime(playButtonTime.value)}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xFF171A2E)),
                                    ))),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr';
  }
}
