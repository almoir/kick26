import 'package:flutter/material.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/data/models/card_model.dart';

class ListPlayersWidget extends StatelessWidget {
  final List<CardModel> cards;
  const ListPlayersWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.82,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
        return SizedBox(height: 180, child: FlipPlayerCardWidget(card: card, cards: cards, tag: "list_player_widget"));
      },
    );
  }
}
