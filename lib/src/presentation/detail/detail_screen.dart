import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/buy_player_card/buy_player_card_screen.dart';
import 'package:kick26/src/presentation/detail/tabs/history_tab.dart';
import 'package:kick26/src/presentation/detail/tabs/market_tab.dart';
import 'package:kick26/src/presentation/detail/tabs/overview_tab.dart';
import 'package:kick26/src/presentation/detail/tabs/player_tab.dart';
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
                    MarketTab(players: notOwnedPlayers, player: player),
                    PlayerTab(player: player, notOwnedPlayers: notOwnedPlayers, tag: widget.tag),
                    HistoryTab(player: player),
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
