import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../home/pages/home_page.dart';

class OnboardPage2 extends StatefulWidget {
  const OnboardPage2({super.key, required this.page});

  final Pages page;

  @override
  State<OnboardPage2> createState() => _OnboardPage2State();
}

class _OnboardPage2State extends State<OnboardPage2> {
  int index = 0;

  int bg = 10;

  String title =
      '“Ancient Greece” takes\nplayers to an ancient\ncivilization filled with gods\nand ancient magical artifacts.';

  void onTap() {
    index++;
    if (index == 1) {
      title =
          'The main character is an\nancient Greek god who\ndecides to unravel the\nmystery of powerful magic,\nusing his skills to collect rows\nof three or more identical\nelements.';
      bg = 11;
    } else if (index == 2) {
      title =
          'For each successful\ncombination, the player\nreceives coins, which help to\npass difficult levels and open\nnew, even more intricate\nareas of the ancient\ncivilization.';
      bg = 12;
    } else if (index == 3) {
      title =
          'Time is limited, and if the\nplayer does not have time to\ncollect the required number of\ncombinations, it leads to\ndefeat, which is reflected in\nthe frustration of the\nprotagonist.';
      bg = 13;
    } else if (index == 4) {
      title =
          'Each failure forces you to return\nto the exploration of the ancient\nGreek world with new strength\nand strategies, striving to uncover\nall its secrets.';
      bg = 14;
    } else {
      context.pop(); // go to slot page

      context.push("/slot", extra: widget.page); // go t
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    try {
      precacheImage(const AssetImage('assets/bg3.png'), context);
      precacheImage(const AssetImage('assets/bg10.png'), context);
      precacheImage(const AssetImage('assets/bg11.png'), context);
      precacheImage(const AssetImage('assets/bg12.png'), context);
      precacheImage(const AssetImage('assets/bg13.png'), context);
      precacheImage(const AssetImage('assets/bg14.png'), context);
    } catch (e) {
      return;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bg: bg,
      onTap: onTap,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 70 + getStatusBar(context)),
                if (index == 1 || index == 3) ...[
                  _ImageCard(index: index),
                  const Spacer(),
                ],
                const SizedBox(height: 44),
                _TitleCard(title),
                const Spacer(),
                const _TapAnywhereText(),
                SizedBox(height: 10 + getBottom(context)),
              ],
            ),
          ),
          _SkipButton(widget.page),
        ],
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton(this.page);

  final Pages page;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20 + getStatusBar(context),
      right: 24,
      child: CupertinoButton(
        onPressed: () {
          context.pop(); // go to slot page
          context.push("/slot", extra: page); // go t
        },
        padding: EdgeInsets.zero,
        minSize: 36,
        child: SvgPicture.asset('assets/skip.svg'),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.85,
      child: Container(
        height: 228,
        width: 306,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xff0077FF),
              Color(0xffCC00FF),
              Color(0xff7300FF),
              Color(0xffFF00FB),
              Color(0xff002BFF),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff7ABBEB),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color(0xff374899),
                  Color(0xff0D014F),
                ],
              ),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TapAnywhereText extends StatelessWidget {
  const _TapAnywhereText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Tap anywhere to continue',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        height: 1.8,
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({
    this.index = 0,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 306,
      width: 228,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xffDD6AFF).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Transform.scale(
                    scaleX: index == 3 ? -1 : 1,
                    child: Image.asset(
                      'assets/bg3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
