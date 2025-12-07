import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/tab_bar_widget.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/market/widgets/list_player_widget.dart';
import 'package:kick26/src/presentation/market/widgets/search_field_widget.dart';

void updatePlayerPrices(
  List<PlayerModel> players, {
  required Random random,
  double maxChangePercent = 3,
}) {
  for (var p in players) {
    final oldPrice = p.price;
    final changePercent =
        (random.nextDouble() * maxChangePercent) * (random.nextBool() ? 1 : -1);
    final newPrice = p.price * (1 + (changePercent / 100));
    p.price = newPrice.clamp(0, double.infinity);
    p.isUp = newPrice > oldPrice;
  }
}

class MarketScreen extends StatefulWidget {
  final int initialTab;
  const MarketScreen({super.key, this.initialTab = 0});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<PlayerModel> players;
  Timer? _timer;
  final _rnd = Random();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTab,
    );

    players = generateDummyPlayers();

    // 🔹 Update harga tiap 5 detik
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        updatePlayerPrices(players, random: _rnd);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SEARCH FIELD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SearchFieldWidget(),
          ),
          Gap(6),

          // TOP SELLING
          SizedBox(
            height: 222,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Selling",
                        style: TextStyle(
                          fontFamily: poppinsRegular,
                          color: ConstColors.light,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ConstColors.gold.withValues(alpha: 0.2),
                          ),
                          child: Center(
                            child: GoldGradient(
                              child: Image.asset(
                                IconPaths.home.arrowRight2,
                                width: 14,
                                height: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final player = players.sublist(10, 20)[index];
                      return FlipPlayerCardWidget(
                        player: player,
                        players: players,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Gap(24),

          // TOP MOVER
          SizedBox(
            height: 222,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Mover",
                        style: TextStyle(
                          fontFamily: poppinsRegular,
                          color: ConstColors.light,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ConstColors.gold.withValues(alpha: 0.2),
                          ),
                          child: Center(
                            child: GoldGradient(
                              child: Image.asset(
                                IconPaths.home.arrowRight2,
                                width: 14,
                                height: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final player = players.sublist(30, 40)[index];
                      return FlipPlayerCardWidget(
                        player: player,
                        players: players,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Gap(24),

          // 🔹 TabBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBarWidget(
              tabController: _tabController,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Trending"),
                Tab(text: "Popular"),
                Tab(text: "Initial Offering"),
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.sizeOf(context).height * .6,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListPlayersWidget(players: players),
                ListPlayersWidget(players: players.sublist(6, 12)),
                ListPlayersWidget(players: players.sublist(12, 18)),
                ListPlayersWidget(players: players.sublist(18, 24)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
