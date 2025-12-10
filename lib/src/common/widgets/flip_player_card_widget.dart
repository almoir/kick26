import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/detail/detail_screen.dart';

class FlipPlayerCardWidget extends StatefulWidget {
  const FlipPlayerCardWidget({
    super.key,
    required this.player,
    required this.players,
    required this.tag,
  });

  final PlayerModel player;
  final List<PlayerModel> players;
  final String tag;

  @override
  State<FlipPlayerCardWidget> createState() => _FlipPlayerCardWidgetState();
}

class _FlipPlayerCardWidgetState extends State<FlipPlayerCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool get isFront => _controller.value < 0.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  void flipCard() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return GestureDetector(
      onDoubleTap: flipCard,
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => DetailScreen(
                    player: player,
                    players: widget.players,
                    tag: widget.tag,
                  ),
            ),
          ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final angle = _controller.value * pi;
          final isFrontSide = angle <= (pi / 2);

          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
            child:
                isFrontSide
                    ? _buildFront(player)
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildBack(player),
                    ),
          );
        },
      ),
    );
  }

  // ==============================
  // FRONT SIDE (Card Asli Kamu)
  // ==============================
  Widget _buildFront(PlayerModel player) {
    return Container(
      width: 140,
      height: 180,
      margin: EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ConstColors.baseColorDark3, ConstColors.baseColorDark4],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(ImagePaths.home.borderCard),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: "${widget.tag}_${player.id}",
                  child: Image.asset(player.image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // SS TOP
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(IconPaths.home.ss, height: 24),
                          const Gap(4),
                          Image.asset(player.clubImage, height: 16),
                          Text(player.countryCode.toFlag),
                        ],
                      ),
                      Column(
                        children: [
                          GoldGradient(
                            child: Text(
                              "41",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: poppinsRegular,
                              ),
                            ),
                          ),
                          Container(
                            width: 12,
                            height: 1,
                            color: ConstColors.darkGray2,
                          ),
                          Text(
                            "60",
                            style: TextStyle(
                              color: ConstColors.darkGray,
                              fontSize: 10,
                              fontFamily: poppinsRegular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // PLAYER DETAILS
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ConstColors.baseColorDark4,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoldGradient(
                          child: Text(
                            player.name,
                            style: TextStyle(
                              fontFamily: poppinsRegular,
                              fontSize: 10,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "€${formatPrice(player.price)}",
                              style: const TextStyle(
                                color: ConstColors.light,
                                fontFamily: poppinsMedium,
                                fontSize: 12,
                              ),
                            ),

                            Row(
                              children: [
                                Icon(
                                  player.isUp
                                      ? Icons.arrow_drop_up_sharp
                                      : Icons.arrow_drop_down_sharp,
                                  color:
                                      player.isUp
                                          ? ConstColors.green
                                          : ConstColors.orange,
                                  size: 12,
                                ),
                                Text(
                                  "${player.trend.toStringAsFixed(2)}%",
                                  style: TextStyle(
                                    fontFamily: poppinsSemiBold,
                                    fontSize: 8,
                                    color:
                                        player.isUp
                                            ? ConstColors.green
                                            : ConstColors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // BACK SIDE (Stats Dinamis)
  // ==============================
  Widget _buildBack(PlayerModel player) {
    return Container(
      width: 140,
      height: 180,
      margin: EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ConstColors.baseColorDark3, ConstColors.baseColorDark4],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(ImagePaths.home.borderCard),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoldGradient(
              child: Text(
                "STATS",
                style: TextStyle(fontSize: 12, fontFamily: poppinsSemiBold),
              ),
            ),
            const Gap(10),

            // === Contoh stats dinamis dari API player model ===
            _statTile("Height", "${player.height}m"),
            _statTile("Weight", "${player.weight}kg"),
            _statTile("Age", "${player.age}yo"),
            _statTile("Games", "${player.games}"),
            _statTile("Goals", "${player.goals}"),
            _statTile("Assits", "${player.assists}"),
          ],
        ),
      ),
    );
  }

  Widget _statTile(String title, dynamic val) {
    final value = val ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ConstColors.light,
              fontFamily: poppinsRegular,
              fontSize: 10,
            ),
          ),
          Text(
            "$value",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: poppinsSemiBold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
