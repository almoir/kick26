import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/detail/sections/player_card_section.dart';

class MarketTab extends StatelessWidget {
  const MarketTab({super.key, required this.players, required this.player});

  final List<PlayerModel> players;
  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/market_summary.png"),
            Gap(16),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recent Trades", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                  Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "+EUR ${(player.price * 0.25).toStringAsFixed(2)}",
                        style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.green2),
                      ),
                      Text("60 Cards", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                      Text(
                        "+EUR ${(player.price + player.price * 0.25).toStringAsFixed(2)}",
                        style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light),
                      ),
                    ],
                  ),
                  Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "-EUR ${(player.price * 0.1).toStringAsFixed(2)}",
                        style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.orange),
                      ),
                      Text("60 Cards", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                      Text(
                        "+EUR ${(player.price - player.price * 0.1).toStringAsFixed(2)}",
                        style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(16),
            GoldGradient(child: const Text('Live Feed', style: TextStyle(fontFamily: poppinsRegular))),
            Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: Row(
                            children: [
                              Image.asset(IconPaths.home.file, width: 12, height: 12),
                              Gap(4),
                              Text("Recent Issuances", style: TextStyle(color: ConstColors.light, fontSize: 12)),
                            ],
                          ),
                        ),
                        Gap(4),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "3 new cards have been issued",
                            style: TextStyle(color: ConstColors.darkGray, fontSize: 12),
                          ),
                        ),
                        Gap(8),
                        Divider(color: Color(0xff2B2B2B)),
                        Gap(8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Image.asset(IconPaths.home.graph, width: 12, height: 12),
                              Gap(4),
                              Text("Large Trades", style: TextStyle(color: ConstColors.light, fontSize: 12)),
                            ],
                          ),
                        ),
                        Gap(4),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Text(
                            "€250K trade executed",
                            style: TextStyle(color: ConstColors.darkGray, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("MARKET CAP", style: TextStyle(color: ConstColors.light, fontSize: 12)),
                            Gap(4),
                            Text("24H", style: TextStyle(color: ConstColors.darkGray, fontSize: 12)),
                          ],
                        ),
                        Gap(4),
                        Image.asset(ImagePaths.home.marketCap),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            PlayerCardsSection(players: players, tabIndex: 1),
          ],
        ),
      ),
    );
  }
}
