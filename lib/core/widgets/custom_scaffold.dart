import 'package:flutter/material.dart';

import '../utils.dart';
import 'buttons/arrow_back_button.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.bg = 1,
    this.back = false,
    this.dark = false,
    this.onTap,
  });

  final Widget body;
  final int bg;
  final bool back;
  final bool dark;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(color: const Color(0xff73CEFF)),
            Image.asset(
              'assets/bg$bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              height: 273,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xff331F8D),
                    const Color(0xff331F8D).withOpacity(0.5),
                    const Color(0xff000000).withOpacity(0),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 273,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff000000).withOpacity(0),
                      const Color(0xff331F8D).withOpacity(0.5),
                      const Color(0xff331F8D),
                    ],
                  ),
                ),
              ),
            ),
            if (dark)
              Container(color: const Color(0xff1B1B22).withOpacity(0.6)),
            if (back)
              Positioned(
                top: 32 + getStatusBar(context),
                left: 25,
                child: const ArrowBackButton(),
              ),
            body,
          ],
        ),
      ),
    );
  }
}
