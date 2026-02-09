import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/data/models/card_model.dart';
import 'package:rive/rive.dart' as riv;

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/gold_shine_overlay.dart';
import 'package:kick26/src/presentation/detail/detail_screen.dart';

class FlipPlayerCardWidget extends StatefulWidget {
  const FlipPlayerCardWidget({
    super.key,
    required this.card,
    required this.cards,
    required this.tag,
    this.onTap,
    this.isFavorite = false,
  });

  final CardModel card;
  final List<CardModel> cards;
  final String tag;
  final VoidCallback? onTap;
  final bool isFavorite;

  @override
  State<FlipPlayerCardWidget> createState() => _FlipPlayerCardWidgetState();
}

class _FlipPlayerCardWidgetState extends State<FlipPlayerCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool get isFront => _controller.value < 0.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
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
    final card = widget.card;

    return GestureDetector(
      onDoubleTap: flipCard,
      onTap:
          widget.onTap ??
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(card: card, cards: widget.cards, tag: widget.tag)),
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
                    ? _buildFront(card)
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildBack(card),
                    ),
          );
        },
      ),
    );
  }

  // ==============================
  // FRONT SIDE (Card Asli Kamu)
  // ==============================
  Widget _buildFront(CardModel card) {
    return Stack(
      children: [
        Container(
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
            image:
                card.data.cardClass != "S"
                    ? DecorationImage(image: AssetImage(ImagePaths.home.borderCard), fit: BoxFit.cover)
                    : null,
          ),
          child: card.data.cardClass == "S" ? _buildSCardFront(card) : _buildCardFront(card),
        ),

        card.data.cardClass == "S"
            ? SizedBox(width: 140, height: 180, child: riv.RiveAnimation.asset('assets/animations/cardgold.riv'))
            : SizedBox(),
      ],
    );
  }

  Widget _buildSCardFront(CardModel card) {
    return GoldShineOverlay(child: _buildCardFront(card));
  }

  Widget _buildCardFront(CardModel card) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: "${widget.tag}_${card.id}",
                child: Image.asset(card.media.images!.playerProfile!, fit: BoxFit.contain),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CardClassWidget(cardClass: card.data.cardClass!),
                        const Gap(4),
                        Image.asset(card.media.images!.clubImage!, height: 16),
                        Text(card.player.countryCode?.toFlag ?? ""),
                      ],
                    ),
                    widget.isFavorite
                        ? Image.asset(IconPaths.general.favorites, width: 24, height: 24)
                        : Column(
                          children: [
                            GoldGradient(child: Text("41", style: TextStyle(fontSize: 10, fontFamily: poppinsRegular))),
                            Container(width: 12, height: 1, color: ConstColors.darkGray2),
                            Text(
                              "60",
                              style: TextStyle(color: ConstColors.darkGray, fontSize: 10, fontFamily: poppinsRegular),
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
                      colors: [Colors.transparent, ConstColors.baseColorDark4],
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
                          card.player.name ?? "",
                          style: TextStyle(fontFamily: poppinsRegular, fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "€${formatPrice(card.market.currentPrice ?? 0)}",
                            style: const TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 12),
                          ),

                          Row(
                            children: [
                              Icon(
                                (card.market.isUp ?? false) ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp,
                                color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                                size: 12,
                              ),
                              Text(
                                "${card.market.trend?.toStringAsFixed(2) ?? 0}%",
                                style: TextStyle(
                                  fontFamily: poppinsSemiBold,
                                  fontSize: 8,
                                  color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
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
    );
  }

  // ==============================
  // BACK SIDE (Stats Dinamis)
  // ==============================
  Widget _buildBack(CardModel card) {
    return Stack(
      children: [
        Container(
          width: 140,
          height: 180,
          margin: EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ConstColors.baseColorDark3, ConstColors.baseColorDark4],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            image:
                card.data.cardClass != "S"
                    ? DecorationImage(image: AssetImage(ImagePaths.home.borderCard), fit: BoxFit.cover)
                    : null,
          ),
          child: card.data.cardClass == "S" ? _buildSCardBack(card) : _buildCardBack(card),
        ),
        card.data.cardClass == "S"
            ? SizedBox(width: 140, height: 180, child: riv.RiveAnimation.asset('assets/animations/cardgold.riv'))
            : SizedBox(),
      ],
    );
  }

  Widget _buildSCardBack(CardModel card) {
    return GoldShineOverlay(child: _buildCardBack(card));
  }

  Widget _buildCardBack(CardModel card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoldGradient(child: Text("STATS", style: TextStyle(fontSize: 12, fontFamily: poppinsSemiBold))),
        const Gap(10),

        // === Contoh stats dinamis dari API player model ===
        _statTile("Height", "${card.player.snapshotBio?.height}m"),
        _statTile("Weight", "${card.player.snapshotBio?.weight}kg"),
        _statTile("Age", "${card.player.snapshotBio?.age}yo"),
        _statTile("Games", "${card.player.snapshotBio?.games}"),
        _statTile("Goals", "${card.player.snapshotBio?.goals}"),
        _statTile("Assists", "${card.player.snapshotBio?.assists}"),
      ],
    );
  }

  Widget _statTile(String title, dynamic val) {
    final value = val ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: ConstColors.light, fontFamily: poppinsRegular, fontSize: 10)),
          Text("$value", style: const TextStyle(color: Colors.white, fontFamily: poppinsSemiBold, fontSize: 11)),
        ],
      ),
    );
  }
}
