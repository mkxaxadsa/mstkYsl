import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.asset,
    required this.onPressed,
  });

  final String asset;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
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
                  border: Border.all(color: const Color(0xff117EC1)),
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
                  child: SvgPicture.asset('assets/$asset.svg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
