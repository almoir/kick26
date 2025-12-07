import 'package:flutter/material.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/data/models/player_model.dart';

class ListPlayersWidget extends StatelessWidget {
  final List<PlayerModel> players;
  const ListPlayersWidget({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      itemCount: players.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.82,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final player = players[index];
        return SizedBox(
          height: 180,
          child: FlipPlayerCardWidget(player: player, players: players),
        );
      },
    );
  }
}
