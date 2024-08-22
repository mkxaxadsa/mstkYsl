import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class FortuneButton extends StatelessWidget {
  const FortuneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.push('/fortune');
      },
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SvgPicture.asset('assets/daily3.svg'),
          SvgPicture.asset('assets/daily2.svg'),
        ],
      ),
    );
  }
}
