import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<PlayerModel> players = [];

  @override
  void initState() {
    players = generateDummyPlayers().getRange(0, 10).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 72,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ConstColors.baseColorDark5)),
            child: Center(child: GoldGradient(child: const Icon(Icons.chevron_left, size: 28))),
          ),
        ),
        title: Text("Favorites", style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15)),
        centerTitle: true,
      ),

      // BODY
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: players.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.82,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final player = players[index];
            return FlipPlayerCardWidget(player: player, players: players, tag: "favorites", isFavorite: true);
          },
        ),
      ),
    );
  }
}
