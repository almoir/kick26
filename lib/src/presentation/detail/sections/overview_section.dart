import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/gold_shine_overlay.dart';
import 'package:kick26/src/data/models/card_model.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key, required this.card, required this.tag});

  final CardModel card;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
      child: card.data.cardClass == "S" ? _buildSCardClass(context) : _buildCardClass(context),
    );
  }

  Widget _buildSCardClass(BuildContext context) {
    return GoldShineOverlay(borderRadius: BorderRadius.circular(10), child: _buildCardClass(context));
  }

  Stack _buildCardClass(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${tag}_${card.id}",
              child: Image.asset(
                card.media.images?.playerProfile ?? "",
                width: MediaQuery.sizeOf(context).width * 0.475,
                height: 200,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 24,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // NUMBER BADGE
                          Positioned(
                            left: 30,
                            top: 3,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ConstColors.gold),
                                color: ConstColors.baseColorDark,
                              ),
                              child: Center(
                                child: GoldGradient(
                                  child: Text("9", style: TextStyle(fontFamily: poppinsRegular, fontSize: 12)),
                                ),
                              ),
                            ),
                          ),
                          // FLAG
                          Positioned(
                            left: 15,
                            child: Container(
                              width: 20,
                              height: 24,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                              child: Center(
                                child: Text(
                                  card.player.countryCode?.toFlag ?? "",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),

                          // CLUB LOGO
                          Positioned(
                            left: 0,
                            child: Image.asset(card.media.images?.clubImage ?? "", width: 20, height: 24),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Text(
                      (card.player.name ?? "").split(' ').first,
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 12),
                    ),
                    Text(
                      (card.player.name ?? "").split(' ').last,
                      style: TextStyle(fontFamily: poppinsSemiBold, color: ConstColors.white, fontSize: 18),
                    ),
                    Gap(10),
                    Row(
                      children: [
                        CardClassWidget(cardClass: card.data.cardClass ?? ""),
                        Gap(12),
                        Container(width: 1, height: 16, color: ConstColors.baseColorDark5),
                        Gap(10),
                        Text(
                          "Only 60 Cards",
                          style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.transparent, ConstColors.baseColorDark3],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // HEIGHT
                Column(
                  children: [
                    Text(
                      "${card.player.snapshotBio?.height ?? 0}m",
                      style: TextStyle(fontFamily: poppinsSemiBold, color: Colors.white),
                    ),
                    Text(
                      "Height",
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10),
                    ),
                  ],
                ),
                // WEIGHT
                Column(
                  children: [
                    Text(
                      "${card.player.snapshotBio?.weight ?? 0}kg",
                      style: TextStyle(fontFamily: poppinsSemiBold, color: Colors.white),
                    ),
                    Text(
                      "Weight",
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10),
                    ),
                  ],
                ),
                // AGE
                Column(
                  children: [
                    Text(
                      "${card.player.snapshotBio?.age ?? 0}yo",
                      style: TextStyle(fontFamily: poppinsSemiBold, color: Colors.white),
                    ),
                    Text("Age", style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10)),
                  ],
                ),
                Container(width: 1, height: 25, color: ConstColors.baseColorDark5),
                // GAMES
                Column(
                  children: [
                    Text(
                      "${card.player.snapshotBio?.games ?? 0}",
                      style: TextStyle(fontFamily: poppinsSemiBold, color: Colors.white),
                    ),
                    Text(
                      "Games",
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10),
                    ),
                  ],
                ),
                // GOALS
                Column(
                  children: [
                    Text(
                      "${card.player.snapshotBio?.goals ?? 0}",
                      style: TextStyle(fontFamily: poppinsSemiBold, color: Colors.white),
                    ),
                    Text(
                      "Goals",
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10),
                    ),
                  ],
                ),
                // ASSISTS
                Column(
                  children: [
                    Text(
                      "${card.player.snapshotBio?.assists ?? 0}",
                      style: TextStyle(fontFamily: poppinsSemiBold, color: Colors.white),
                    ),
                    Text(
                      "Assists",
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
