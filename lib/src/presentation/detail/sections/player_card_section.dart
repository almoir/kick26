import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/data/models/player_model.dart';

class PlayerCardsSection extends StatelessWidget {
  const PlayerCardsSection({super.key, required this.players});

  final List<PlayerModel> players;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: ConstColors.baseColorDark5),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Player Cards",
                  style: TextStyle(
                    fontFamily: poppinsRegular,
                    color: ConstColors.light,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final player = players[index];
                return FlipPlayerCardWidget(player: player, players: players);
              },
            ),
          ),
          Gap(36),
        ],
      ),
    );
  }
}
