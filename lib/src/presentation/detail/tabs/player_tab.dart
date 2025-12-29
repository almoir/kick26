import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/detail/sections/overview_section.dart';
import 'package:kick26/src/presentation/detail/sections/player_card_section.dart';
import 'package:kick26/src/presentation/detail/widgets/detail_player_card_widget.dart';

import '../../../common/fonts_family.dart';

class PlayerTab extends StatelessWidget {
  const PlayerTab({super.key, required this.player, required this.notOwnedPlayers, required this.tag});

  final PlayerModel player;
  final List<PlayerModel> notOwnedPlayers;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            OverviewSection(player: player, tag: tag),
            Gap(16),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DetailPlayerCardWidget(
                        name: "Age",
                        icon: IconPaths.detailPlayer.calendar,
                        title: "${player.age} Year",
                        subtitle: "Dec 20, 1998",
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: DetailPlayerCardWidget(
                        name: "Awards",
                        icon: IconPaths.detailPlayer.awards,
                        title: "Golden Boy 20..",
                        subtitle: "POTM WC 2018",
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: DetailPlayerCardWidget(
                        name: "Height",
                        icon: IconPaths.detailPlayer.height,
                        title: "${player.height}m",
                        subtitle: "(5 ft 10 inches)",
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.asset(player.clubImage, height: 69, width: 49, fit: BoxFit.contain),
                      const SizedBox(width: 8),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player.club,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: poppinsMedium, fontSize: 12, color: ConstColors.light),
                            ),

                            const SizedBox(height: 4),

                            Row(
                              children: [
                                Image.asset(ImagePaths.general.laliga, width: 12, height: 11),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "La Liga",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.light),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            InfoRow(label: "League Level:", value: "${player.countryCode.toFlag} First Tier"),
                            InfoRow(label: "Joined:", value: "Jul 1, 2024"),
                            InfoRow(label: "Contract Exp:", value: "Jun 30, 2029"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(16),
            Image.asset(ImagePaths.home.mbapeHistory),
            Gap(16),
            PlayerCardsSection(players: notOwnedPlayers, tabIndex: 2),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Wrap(
        spacing: 4,
        runSpacing: 2,
        children: [
          Text(label, style: TextStyle(fontFamily: poppinsLight, fontSize: 10, color: ConstColors.gray)),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.light),
          ),
        ],
      ),
    );
  }
}
