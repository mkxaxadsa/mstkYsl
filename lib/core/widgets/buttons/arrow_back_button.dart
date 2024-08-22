import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pop(context);
      },
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          SvgPicture.asset('assets/settings2.svg'),
          Positioned(
            left: 16,
            top: 5,
            child: SvgPicture.asset(
              'assets/back.svg',
              width: 17,
            ),
          ),
        ],
      ),
    );
  }
}
