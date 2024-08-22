import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/assets.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/title_card.dart';
import '../widgets/daily_reward_button.dart';
import '../widgets/fortune_button.dart';
import '../widgets/play_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pages> pages = [
    Pages(
      'Alien Invasion',
      Assets.assetsGm1,
      const Color(0xFF9CE3FF),
      2,
      [
        Assets.slotsEl1,
        Assets.slotsEl2,
        Assets.slotsEl3,
        Assets.slotsEl4,
        Assets.slotsEl5,
        Assets.slotsEl6,
        Assets.slotsEl7,
        Assets.slotsEl8,
        Assets.slotsEl9,
        Assets.slotsEl10,
        Assets.slotsEl11,
        Assets.slotsEl12,
        Assets.slotsEl13,
        Assets.slotsEl14,
        Assets.slotsEl15,
        Assets.slotsEl16,
        Assets.slotsEl17,
        Assets.slotsEl18,
        Assets.slotsEl19,
      ],
      gradient: const LinearGradient(colors: [
        Color(0xFF111D7E),
        Color(0xFF5A3F94),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
    Pages(
      'Ancient Greece',
      Assets.assetsGm2,
      const Color(0xFF63EF6C),
      3,
      [
        Assets.slots2El1,
        Assets.slots2El2,
        Assets.slots2El3,
        Assets.slots2El4,
        Assets.slots2El5,
        Assets.slots2El6,
        Assets.slots2El7,
        Assets.slots2El8,
        Assets.slots2El9,
        Assets.slots2El10,
        Assets.slots2El11,
        Assets.slots2El12,
        Assets.slots2El13,
        Assets.slots2El14,
        Assets.slots2El15,
        Assets.slots2El16,
        Assets.slots2El17,
        Assets.slots2El18,
        Assets.slots2El19,
      ],
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF7E7111),
          Color(0xFF593F94),
        ],
      ),
    ),
    Pages(
      'Lucky Fish',
      Assets.assetsGm3,
      const Color(0xFFEF6365),
      4,
      [
        Assets.slots3El1,
        Assets.slots3El2,
        Assets.slots3El3,
        Assets.slots3El4,
        Assets.slots3El5,
        Assets.slots3El6,
        Assets.slots3El7,
        Assets.slots3El8,
        Assets.slots3El9,
        Assets.slots3El10,
        Assets.slots3El11,
        Assets.slots3El12,
        Assets.slots3El13,
        Assets.slots3El14,
        Assets.slots3El15,
        Assets.slots3El16,
        Assets.slots3El17,
        Assets.slots3El18,
        Assets.slots3El19,
      ],
      gradient: const LinearGradient(
        colors: [
          Color(0xFF117E68),
          Color(0xFF593F94),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  ];

  Color getTitleColor(int index) {
    if (index == 0) return const Color(0xffFF172D);
    if (index == 1) return const Color(0xff8800FF);
    if (index == 2) return const Color(0xff54AB41);
    return const Color(0xffFF172D);
  }

  PageController pageController = PageController();

  String getAsset(int index) {
    if (index == 0) return 'play';
    if (index == 1) return 'play2';
    if (index == 2) return 'play3';
    return 'play';
  }

  int pageIndex = 0;

  void changaIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar(),
          const SizedBox(height: 95),
          Expanded(
            // height: size.width * .9,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: pages.length,
                    onPageChanged: (value) {
                      changaIndex(value);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TitleCard(
                            pages[index].title,
                            color: getTitleColor(index),
                          ),
                          Expanded(child: Image.asset(pages[index].image)),
                        ],
                      );
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: pages.length,
                  effect: const JumpingDotEffect(
                    activeDotColor: Colors.white,
                    dotColor: Color(0xFF0D014F),
                  ),
                ),
                const SizedBox(height: 32)
              ],
            ),
          ),
          PlayButton(
            asset: getAsset(pageIndex),
            onPressed: () {
              var page = pages[pageController.page?.toInt() ?? 0];
              context.push('/onboard${page.bg - 1}', extra: page);
            },
          ),
          const Row(
            children: [
              SizedBox(width: 25),
              DailyRewardButton(),
              Spacer(),
              FortuneButton(),
              SizedBox(width: 25),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class Pages {
  String title;
  String image;
  Color color;
  int bg;
  List<String> items;
  LinearGradient gradient;

  Pages(
    this.title,
    this.image,
    this.color,
    this.bg,
    this.items, {
    required this.gradient,
  });
}
