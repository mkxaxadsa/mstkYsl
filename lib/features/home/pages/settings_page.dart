import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mswm_test/core/widgets/title_card.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool sound = false;

  void onSound() {
    setState(() {
      sound = !sound;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      back: true,
      body: Stack(
        children: [
          Positioned(
            top: 72 + getStatusBar(context),
            left: 0,
            right: 0,
            child: const TitleCard('Settings'),
          ),
          Center(
            child: Container(
              height: 306,
              width: 228,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff7ABBEB),
                    blurRadius: 10,
                    spreadRadius: 3,
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
              child: Center(
                child: Container(
                  height: 302,
                  width: 224,
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
                      const SizedBox(height: 25),
                      CupertinoButton(
                        onPressed: () {
                          context.push('/rules');
                        },
                        padding: EdgeInsets.zero,
                        minSize: 39,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/settings_button1.svg'),
                            const Positioned(
                              top: 8,
                              left: 15,
                              child: Text(
                                'RULES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 15,
                              child: SvgPicture.asset('assets/rules.svg'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
