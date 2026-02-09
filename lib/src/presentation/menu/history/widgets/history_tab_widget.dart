import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/card_model.dart';
import 'package:kick26/src/presentation/detail/detail_screen.dart';

class HistoryTabWidget extends StatelessWidget {
  const HistoryTabWidget({super.key, required this.cards, required this.tag});

  final List<CardModel> cards;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(card: card, cards: cards, tag: 'history_tab_$tag'),
                ),
              ),
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: ConstColors.baseColorDark5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlipPlayerCardWidget(card: card, cards: cards, tag: 'history_tab_$tag'),
                Gap(4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.player.name ?? "",
                        style: TextStyle(
                          color: ConstColors.white,
                          fontFamily: poppinsSemiBold,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gap(4),
                      Text(
                        card.club.name ?? "",
                        style: TextStyle(color: ConstColors.lightGray, fontFamily: poppinsRegular, fontSize: 12),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: ConstColors.lightGray),
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: poppinsRegular,
                                  fontSize: 10,
                                  color: ConstColors.lightGray,
                                ),
                                children: [
                                  TextSpan(text: "41", style: TextStyle(color: ConstColors.gold)),
                                  TextSpan(text: "/60"),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: ConstColors.lightGray),
                            ),
                            child: Text(
                              "CF",
                              style: TextStyle(color: ConstColors.lightGray, fontFamily: poppinsRegular, fontSize: 10),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: ConstColors.lightGray),
                            ),
                            child: Text(
                              "${card.player.snapshotBio?.age ?? 0} y.o",
                              style: TextStyle(color: ConstColors.lightGray, fontFamily: poppinsRegular, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            "Id: ",
                            style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.lightGray),
                          ),
                          Expanded(
                            child: Text(
                              card.id,
                              style: TextStyle(color: ConstColors.white, fontSize: 12, overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      GoldGradientBorder(
                        backgroundColor: ConstColors.baseColorDark3,
                        borderRadius: 14,
                        borderWidth: 1,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bought",
                                  style: TextStyle(color: ConstColors.green, fontFamily: poppinsRegular, fontSize: 12),
                                ),
                                Text(
                                  "12/12/2025",
                                  style: TextStyle(
                                    color: ConstColors.lightGray,
                                    fontFamily: poppinsRegular,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 36,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              color: ConstColors.baseColorDark5,
                            ),
                            Text(
                              "€${card.market.currentPrice?.toStringAsFixed(2)}",
                              style: TextStyle(color: ConstColors.white, fontFamily: poppinsMedium),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
