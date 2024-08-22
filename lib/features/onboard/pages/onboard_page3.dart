import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../home/pages/home_page.dart';

class OnboardPage3 extends StatefulWidget {
  const OnboardPage3({super.key, required this.page});
  final Pages page;
  @override
  State<OnboardPage3> createState() => _OnboardPage3State();
}

class _OnboardPage3State extends State<OnboardPage3> {
  int index = 0;

  int bg = 15;

  String title =
      '“Lucky Fish” - the player takes\non the role of a young\nfisherman who wants to catch\na lucky fish to bring him\nwealth and jewelry.';

  void onTap() {
    index++;
    if (index == 1) {
      title =
          'The player\'s task is to catch\nthe fish by connecting rows of\nthree or more identical items\nto bring him historical secrets\nof wealth and collect coins.';
      bg = 16;
    } else if (index == 2) {
      title =
          'These coins help you acquire\nextra time, tools for catching\nfish or hints for solving\nparticularly difficult\nproblems.';
      bg = 17;
    } else if (index == 3) {
      title =
          'Time is limited, and if the\nplayer does not manage to\ncollect the required number of\ncombinations, it leads to\ndefeat, and the protagonist\nexpresses his frustration with\nfailure.';
      bg = 18;
    } else if (index == 4) {
      title =
          'Each new level poses new\nchallenges and requires\nimprovement of your skills and\nreaction speed.';
      bg = 19;
    } else {
      context.pop(); // go to slot page
      context.push("/slot", extra: widget.page); // go t
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    try {
      precacheImage(const AssetImage('assets/bg4.png'), context);
      precacheImage(const AssetImage('assets/bg15.png'), context);
      precacheImage(const AssetImage('assets/bg16.png'), context);
      precacheImage(const AssetImage('assets/bg17.png'), context);
      precacheImage(const AssetImage('assets/bg18.png'), context);
      precacheImage(const AssetImage('assets/bg19.png'), context);
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
  const _ImageCard({this.index = 0});

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
                      'assets/bg4.png',
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
