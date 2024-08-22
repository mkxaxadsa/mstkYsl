import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  const TitleCard(
    this.title, {
    super.key,
    this.color = const Color(0xffFF172D),
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 162,
          // decoration: const BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Color(0xff61C7FF),
          //       blurRadius: 50,
          //     ),
          //   ],
          // ),
          child: Stack(
            children: [
              Container(
                height: 30,
                width: 162,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: const Color(0xff117EC1)),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff117EC1),
                      Color(0xff218ECF),
                      Color(0xff339EDE),
                      Color(0xff7AD2FF),
                      Color(0xff6FCCFD),
                      Color(0xff58BFFA),
                      Color(0xff4AB7F8),
                      Color(0xff45B4F7),
                      Color(0xff73CEFF),
                      Color(0xff5BC3FF),
                      Color(0xff2B96D7),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 7,
                left: 0,
                right: 0,
                child: Container(
                  height: 30,
                  width: 162,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.white),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff73CEFF),
                        Color(0xff95DFFF),
                        Color(0xffB7F0FF),
                        Color(0xffCCFAFF),
                        Color(0xffD3FEFF),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.white, // <-- Border color
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color, // <-- Inner color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
