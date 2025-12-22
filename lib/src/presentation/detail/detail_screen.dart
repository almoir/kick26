import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/buy_player_card/buy_player_card_screen.dart';
import 'package:kick26/src/presentation/detail/sections/overview_section.dart';
import 'package:kick26/src/presentation/detail/sections/player_card_section.dart';
import 'package:kick26/src/presentation/detail/tabs/authenticity_tab.dart';
import 'package:kick26/src/presentation/detail/widgets/detail_player_card_widget.dart';
import 'package:kick26/src/presentation/detail/widgets/detail_player_tab_bar.dart';
import 'package:kick26/src/presentation/sell_player_card/sell_player_card_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.player, required this.players, required this.tag});

  final PlayerModel player;
  final List<PlayerModel> players;
  final String tag;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late PlayerModel player;
  late List<PlayerModel> notOwnedPlayers;

  @override
  void initState() {
    super.initState();
    player = widget.player;
    notOwnedPlayers = widget.players.where((p) => !p.isOwned).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
          title: Text(
            "Player Card Details",
            style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
          ),
          centerTitle: true,
        ),

        // BODY
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              DetailPlayerTabBar(),
              Gap(16),
              Expanded(
                child: TabBarView(
                  children: [
                    OverviewTab(player: player, players: notOwnedPlayers, tag: widget.tag),
                    MarketTab(players: notOwnedPlayers),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Image.asset(ImagePaths.home.mbapeHistory),
                            Gap(16),
                            PlayerCardsSection(players: notOwnedPlayers, tabIndex: 2),
                          ],
                        ),
                      ),
                    ),
                    AuthenticityTab(player: player),
                  ],
                ),
              ),
            ],
          ),
        ),
        // BOTTOM NAV
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                player.isOwned
                    ? Flexible(
                      child: GestureDetector(
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SellPlayerCardScreen(player: player)),
                            ),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: GoldGradientBorder(
                            borderRadius: 10,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: GoldGradient(child: Text("Sell", style: TextStyle(fontFamily: poppinsMedium))),
                            ),
                          ),
                        ),
                      ),
                    )
                    : SizedBox(),
                player.isOwned ? Gap(10) : SizedBox(),
                Flexible(
                  child: GoldGradientButton(
                    height: 40,
                    text: "Buy",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyPlayerCardScreen(player: player)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MarketTab extends StatelessWidget {
  const MarketTab({super.key, required this.players});

  final List<PlayerModel> players;

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
                      Text("+EUR 2,330", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.green2)),
                      Text("125 Cards", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                      Text("EUR 18.64", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                    ],
                  ),
                  Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("-EUR 1,850", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.orange)),
                      Text("100 Cards", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                      Text("EUR 18.50", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                    ],
                  ),
                ],
              ),
            ),
            Gap(16),
            Text("Revenue Stream Breakdown", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ticketing", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            GoldGradient(
                              child: Text("35%", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            ),
                          ],
                        ),
                        Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Merch", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            GoldGradient(
                              child: Text("20%", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(10),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Broadcasting", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            GoldGradient(
                              child: Text("30%", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            ),
                          ],
                        ),
                        Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Other", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            GoldGradient(
                              child: Text("15%", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.player, required this.players, required this.tag});

  final PlayerModel player;
  final List<PlayerModel> players;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OverviewSection(player: player, tag: tag),
          Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// LEFT CARD
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ConstColors.baseColorDark3,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset(player.clubImage, height: 69, width: 49, fit: BoxFit.contain),
                            const SizedBox(width: 8),

                            /// ⬇️ PENTING: Expanded
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
                                          style: TextStyle(
                                            fontFamily: poppinsMedium,
                                            fontSize: 10,
                                            color: ConstColors.light,
                                          ),
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
                    ),

                    const SizedBox(width: 8),

                    /// RIGHT CARD
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ConstColors.baseColorDark3,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price (EUR)",
                              style: TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.light),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formatPrice(player.price),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: poppinsMedium, fontSize: 18, color: ConstColors.light),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              "Last Updated:",
                              style: TextStyle(fontFamily: poppinsRegular, fontSize: 8, color: ConstColors.gray),
                            ),
                            Text(
                              DateFormat("MMM dd, yyyy").format(DateTime.now()),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: poppinsBold, fontSize: 8, color: ConstColors.gray),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(16),
          PlayerCardsSection(players: players, tabIndex: 0),
        ],
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
