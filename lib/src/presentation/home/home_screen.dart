import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/list_tile_player_widget.dart';
import 'package:kick26/src/data/models/player_model.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onTapTrending;
  const HomeScreen({super.key, this.onTapTrending});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String choosenMenu = 'Very Rare';

  late List<PlayerModel> players;

  Timer? _timer;
  final _rnd = Random();

  @override
  void initState() {
    super.initState();
    players = generateDummyPlayers();
    // update pertama kali agar tidak kosong (opsional)
    updatePlayerTrends(players, random: _rnd, maxChangePercent: 3);

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        // setiap tick, random change kecil
        updatePlayerTrends(players, random: _rnd, maxChangePercent: 3);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Porfolio Value Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: ConstColors.baseColorDark2,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    transform: const GradientRotation(-0.5),
                    colors: [
                      ConstColors.gold.withValues(alpha: 0.4),
                      ConstColors.baseColorDark2,
                      ConstColors.baseColorDark2,
                      ConstColors.baseColorDark2,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portfolio Value',
                              style: TextStyle(
                                color: ConstColors.gray10,
                                fontFamily: poppinsRegular,
                                fontSize: 12,
                              ),
                            ),
                            Gap(10),
                            Text(
                              '€48.341,77',
                              style: TextStyle(
                                color: ConstColors.white,
                                fontFamily: poppinsSemiBold,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GoldGradient(
                                  child: Icon(Icons.arrow_drop_up_sharp),
                                ),
                                GoldGradient(
                                  child: Text(
                                    '0.73 (-0.73%) Today',
                                    style: TextStyle(
                                      fontFamily: poppinsSemiBold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(40),
                        Expanded(
                          child: Image.asset(ImagePaths.home.chartOutlined),
                        ),
                      ],
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Column(
                            children: [
                              GoldGradient(
                                child: Icon(
                                  Icons.add_circle_outline_outlined,
                                  color: ConstColors.light,
                                ),
                              ),
                              GoldGradient(
                                child: Text(
                                  'Deposit',
                                  style: TextStyle(
                                    color: ConstColors.light,
                                    fontFamily: poppinsLight,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xff333333),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              GoldGradient(
                                child: Transform.rotate(
                                  angle: -0.5,
                                  child: const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: ConstColors.light,
                                  ),
                                ),
                              ),
                              GoldGradient(
                                child: const Text(
                                  'Trade',
                                  style: TextStyle(
                                    color: ConstColors.light,
                                    fontFamily: poppinsLight,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xff333333),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Image.asset(IconPaths.home.explore, height: 24),
                              GoldGradient(
                                child: const Text(
                                  'Explore',
                                  style: TextStyle(
                                    color: ConstColors.light,
                                    fontFamily: poppinsLight,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(24),

              // MY PLAYER CARDS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Player Cards',
                      style: TextStyle(
                        color: ConstColors.light,
                        fontFamily: poppinsRegular,
                      ),
                    ),
                    InkWell(
                      onTap: widget.onTapTrending,
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
              const Gap(12),

              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  padding: const EdgeInsets.only(left: 16),
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return FlipPlayerCardWidget(
                      player: player,
                      players: players,
                    );
                  },
                ),
              ),

              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoldGradient(
                      child: const Text(
                        'Live Feed',
                        style: TextStyle(fontFamily: poppinsRegular),
                      ),
                    ),
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
                                      Image.asset(
                                        IconPaths.home.file,
                                        width: 12,
                                        height: 12,
                                      ),
                                      Gap(4),
                                      Text(
                                        "Recent Issuances",
                                        style: TextStyle(
                                          color: ConstColors.light,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(4),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    "3 new cards have been issued",
                                    style: TextStyle(
                                      color: ConstColors.darkGray,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Gap(8),
                                Divider(color: Color(0xff2B2B2B)),
                                Gap(8),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        IconPaths.home.graph,
                                        width: 12,
                                        height: 12,
                                      ),
                                      Gap(4),
                                      Text(
                                        "Large Trades",
                                        style: TextStyle(
                                          color: ConstColors.light,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(4),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                                  child: Text(
                                    "€250K trade executed",
                                    style: TextStyle(
                                      color: ConstColors.darkGray,
                                      fontSize: 12,
                                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "MARKET CAP",
                                      style: TextStyle(
                                        color: ConstColors.light,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Gap(4),
                                    Text(
                                      "24H",
                                      style: TextStyle(
                                        color: ConstColors.darkGray,
                                        fontSize: 12,
                                      ),
                                    ),
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
                  ],
                ),
              ),
              Gap(16),

              // Hot Players
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ConstColors.gold),
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorAnimation: TabIndicatorAnimation.linear,
                  indicatorWeight: 1,
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  labelStyle: const TextStyle(
                    fontFamily: poppinsRegular,
                    color: ConstColors.gold,
                    fontSize: 12,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: poppinsRegular,
                    color: ConstColors.gray10,
                    fontSize: 12,
                  ),
                  tabs: const [
                    Tab(text: "Very Rare"),
                    Tab(text: "Rare"),
                    Tab(text: "SS+ Class"),
                    Tab(text: "S Class"),
                    Tab(text: "A Class"),
                  ],
                ),
              ),
              const Gap(12),
              SizedBox(
                height: 400,
                child: TabBarView(
                  children: [
                    ListTilePlayersWidget(players: players.sublist(0, 4)),
                    ListTilePlayersWidget(players: players.sublist(5, 9)),
                    ListTilePlayersWidget(players: players.sublist(10, 14)),
                    ListTilePlayersWidget(players: players.sublist(15, 19)),
                    ListTilePlayersWidget(players: players.sublist(20, 24)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
