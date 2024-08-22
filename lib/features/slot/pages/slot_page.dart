import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/assets.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/arrow_back_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../home/pages/home_page.dart';

class SlotPage extends StatefulWidget {
  const SlotPage({super.key, required this.page});

  final Pages page;

  @override
  State<SlotPage> createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  List<List<String>> slots = [[], [], [], [], []];
  List<ScrollController> scrolls = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  ValueNotifier<int> spinCount = ValueNotifier(5);
  ValueNotifier<int> timeSecond = ValueNotifier(60);

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeSecond.value < 2) timer.cancel();
      timeSecond.value--;
    });
    getReady();
  }

  int ran = 0;

  getReady() {
    int count = 0;
    while (count < 5) {
      List<String> slotItems = widget.page.items.toList();
      slotItems.shuffle();
      slots[count].addAll(slotItems.toList());
      count++;
    }
    ran = Random().nextInt(8);
    print("RAN: $ran");
    var length = slots[0].length - 1;

    if (ran < 4) {
      int id = Random().nextInt(widget.page.items.length - 1);
      for (int i = 0; i < 5; i++) {
        slots[i][length - ran] = widget.page.items[id];
      }
    }
    setState(() {});
  }

  void spin() async {
    if (spinCount.value < 1) {
      return;
    }
    spinCount.value--;
    int time = 0;
    for (var item in scrolls) {
      int sec = Random().nextInt(4) + 2;
      time = sec < time ? time : sec;
      item.animateTo(
        scrolls[0].position.maxScrollExtent,
        duration: Duration(seconds: sec),
        curve: Curves.easeInOut,
      );
    }

    Future.delayed(Duration(seconds: time), () {
      if (spinCount.value == 0) {
        showDialog(
          context: context,
          builder: (context) {
            return RewardSlotDialog(
              page: widget.page,
              spinCount: spinCount,
              text: 'GAME OVER',
            );
          },
        );
        return;
      }
      if (ran < 4) {
        gift.value = (ran + 1) * 40;
        addCoins(gift.value!);
        print(gift.value);
        print("----Yutuq----");
      } else {
        gift.value = -1;
        minusCoins(50);
      }
      getReady();
    });
  }

  ValueNotifier<int?> gift = ValueNotifier(null);

  @override
  void dispose() {
    scrolls[0].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScaffold(
      bg: widget.page.bg,
      body: Stack(
        children: [
          Positioned(
            top: 32 + getStatusBar(context),
            left: 0,
            right: 0,
            child: Column(
              children: [
                topItems(),
                Container(
                  height: size.width * .842,
                  width: size.width * .842,
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: widget.page.color, width: 4),
                    gradient: widget.page.gradient,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 3,
                        color: Color(0xFF7ABBEB),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => Expanded(
                          child: ListView.builder(
                            itemCount: slots[index].length,
                            shrinkWrap: true,
                            controller: scrolls[index],
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context, i) {
                              var itemSize = (size.width * .835) / 5 - 6;
                              return Stack(
                                children: [
                                  Container(
                                    height: itemSize,
                                    width: itemSize,
                                    padding: const EdgeInsets.all(10),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Assets.slotsBack),
                                      ),
                                    ),
                                    child: Image.asset(slots[index][i]),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    spin();
                  },
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
                                color: const Color(0xff117EC1),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff7AD2FF),
                                  Color(0xff6FCCFD),
                                  Color(0xff58BFFA),
                                  Color(0xff4AB7F8),
                                  Color(0xff7AD2FF),
                                  Color(0xff5BC3FF),
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
                                  Color(0xff44B4F8),
                                  Color(0xffB4EFFF),
                                  Color(0xffD3FEFF),
                                ],
                              ),
                            ),
                            child: Center(
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return widget.page.gradient
                                      .createShader(bounds);
                                },
                                child: const Text(
                                  "SPIN",
                                  style: TextStyle(
                                    color: Color(0xFFFF172D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topItems() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ArrowBackButton(),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 5,
                ),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Color(0xFF61C7FF),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage(Assets.componentsTitleBack),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.page.title,
                      style: const TextStyle(
                        height: 1,
                        color: Color(0xFFFF172D),
                      ),
                    ),
                  ],
                ),
              ),
              const Settings(),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CoinsCount(),
            const DiamonsCount(),
            SizedBox(
              width: 60,
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    child: Image.asset(
                      Assets.componentsTimerBack,
                      fit: BoxFit.contain,
                      width: 60,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.componentsTimer,
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 2),
                        child: ValueListenableBuilder(
                          valueListenable: timeSecond,
                          builder: (context, value, child) => Text(
                            formatTime(value),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Image.asset(
                      Assets.componentsTimerBack,
                      fit: BoxFit.contain,
                      width: 60,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.componentsCubePart,
                        width: 20,
                      ),
                      const SizedBox(width: 4),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: ValueListenableBuilder(
                            valueListenable: spinCount,
                            builder: (context, value, child) => Text(
                              "$value/5",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Badge(
                    alignment: Alignment.bottomRight,
                    label: Padding(
                      padding: const EdgeInsets.only(bottom: 4, right: 4),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF0B9128),
                          border: Border.all(
                            color: const Color(0xFF86C5B6),
                          ),
                        ),
                        child: const Text(
                          "0",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    child: CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: SizedBox(
                        height: 70,
                        width: 60,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xff117EC1),
                                  ),
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xff7AD2FF),
                                      Color(0xff6FCCFD),
                                      Color(0xff58BFFA),
                                      Color(0xff4AB7F8),
                                      Color(0xff7AD2FF),
                                      Color(0xff5BC3FF),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff44B4F8),
                                      Color(0xffB4EFFF),
                                      Color(0xffD3FEFF),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    Assets.componentsUndo,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Extra Move",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF7300FF)),
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
                        color: Color(0xFF7ABBEB),
                      ),
                    ],
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: gift,
                    builder: (context, value, child) {
                      if (value == null) {
                        return const Text(
                          "Press Spin to start",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      } else {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.assetsCoin),
                            Text(
                              value != -1 ? "  +$value" : "  -50",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      height: 70,
                      width: 60,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xff117EC1),
                                ),
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
                            bottom: 0,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff9F9F9F),
                                    Color(0xff9F9F9F),
                                    Color(0xffC3C3C3),
                                    Color(0xffD9D9D9),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Color(0xff9F9F9F),
                                        Color(0xff9F9F9F),
                                        Color(0xffC3C3C3),
                                        Color(0xffD9D9D9),
                                      ],
                                    ).createShader(bounds);
                                  },
                                  child: Image.asset(Assets.componentsTimer),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Extra Time",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatTime(int seconds) {
    int minutes = (seconds % 3600) ~/ 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = "${seconds % 60}".padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}

class RewardSlotDialog extends StatefulWidget {
  const RewardSlotDialog({
    super.key,
    required this.page,
    required this.spinCount,
    required this.text,
  });

  final String text;
  final ValueNotifier<int> spinCount;
  final Pages page;

  @override
  State<RewardSlotDialog> createState() => _RewardSlotDialogState();
}

class _RewardSlotDialogState extends State<RewardSlotDialog> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) {},
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: size.width * .9,
          width: size.width * .75,
          child: Stack(
            children: [
              Image.asset(
                widget.page.image,
                height: size.width * .9,
                width: size.width * .72,
                fit: BoxFit.fill,
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 30,
                bottom: 30,
                child: Column(
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Color(0xFFFFB956),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: Image.asset(
                                Assets.componentsTimerBack,
                                fit: BoxFit.contain,
                                width: 60,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.componentsCubePart,
                                  width: 20,
                                ),
                                const SizedBox(width: 4),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: ValueListenableBuilder(
                                      valueListenable: widget.spinCount,
                                      builder: (context, value, child) => Text(
                                        "$value/5",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CoinsCount(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                left: size.width * .15,
                right: size.width * .15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF2F3B8C).withOpacity(.9),
                      child: const Text(
                        "Home",
                        style: TextStyle(
                          height: 1,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                        context.pop();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
