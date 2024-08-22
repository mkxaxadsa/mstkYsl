import 'package:flutter/material.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/title_card.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      back: true,
      dark: true,
      body: Stack(
        children: [
          Positioned(
            top: 72 + getStatusBar(context),
            left: 0,
            right: 0,
            child: const TitleCard('Rules'),
          ),
          const Center(
            child: Text(
              'Everything is very easy and\nsimple - You have to make a\ncombination of 3 or more\nelements in a row. Only time is\nlimited, keep this in mind. For\neach successful combination you\nget a prize in the form of coins.\n\nYou have additional bonuses -\nthese are free moves and extra\ntime, you can get them for coins\n\nIf you fail two times in a row, you\ncan buy diamonds.\n\nIf you do not have time to collect\nthe required number of\ncombinations when the time\nruns out - you lose',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
