import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/common/fonts_family.dart';
import 'package:kick24/src/common/icon_paths.dart';
import 'package:kick24/src/common/image_paths.dart';
import 'package:kick24/src/data/models/player_model.dart';
import 'package:kick24/src/presentation/detail/detail_screen.dart';

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
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 TabBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: ConstColors.goldGradient2),
                ),
                indicatorPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 2,
                ),
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorAnimation: TabIndicatorAnimation.linear,
                labelStyle: const TextStyle(
                  fontFamily: poppinsRegular,
                  color: ConstColors.goldGradient2,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: poppinsRegular,
                  color: ConstColors.gray10,
                  fontSize: 12,
                ),
                indicatorWeight: 1,
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Trending"),
                  Tab(text: "Popular"),
                  Tab(text: "Initial Offering"),
                ],
              ),
            ),
            const Gap(15),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListPlayers(players: players.sublist(0, 6)),
                  ListPlayers(players: players.sublist(6, 12)),
                  ListPlayers(players: players.sublist(12, 18)),
                  ListPlayers(players: players.sublist(18, 24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPlayers extends StatelessWidget {
  final List<PlayerModel> players;
  const ListPlayers({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: players.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final player = players[index];
        return PlayerCard(player: player);
      },
    );
  }
}

class PlayerCard extends StatefulWidget {
  final PlayerModel player;
  const PlayerCard({super.key, required this.player});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  Color _flashColor = Colors.transparent;

  @override
  void didUpdateWidget(covariant PlayerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.player.price != oldWidget.player.price) {
      // 🔹 Efek flash hijau atau merah
      setState(() {
        _flashColor =
            widget.player.isUp
                ? Colors.green.withValues(alpha: 0.3)
                : Colors.red.withValues(alpha: 0.3);
      });

      // 🔹 Kembalikan ke transparan setelah 500ms
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _flashColor = Colors.transparent;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return InkWell(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailScreen(player: widget.player),
            ),
          ),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0C0C0C),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.name,
                          style: const TextStyle(
                            color: ConstColors.light,
                            fontFamily: poppinsRegular,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(player.clubImage, height: 16),
                            const Gap(5),
                            Expanded(
                              child: Text(
                                player.club,
                                style: const TextStyle(
                                  color: ConstColors.light,
                                  fontFamily: poppinsLight,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      player.isUp
                          ? Icons.arrow_drop_up_sharp
                          : Icons.arrow_drop_down_sharp,
                      key: ValueKey(player.isUp),
                      color:
                          player.isUp
                              ? ConstColors.goldGradient2
                              : ConstColors.orange,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Image.asset(
                        ImagePaths.home.chartUp,
                        width: 180,
                        height: 170,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(player.image, height: 170),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          ConstColors.baseColorDark,
                        ],
                      ),
                    ),
                    height: 70,
                    width: 180,
                  ),
                  SizedBox(
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF7EF8A).withAlpha(255),
                                  offset: const Offset(-1, 0),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(IconPaths.home.ss, height: 30),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: _flashColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder:
                                    (child, anim) => FadeTransition(
                                      opacity: anim,
                                      child: child,
                                    ),
                                child: Text(
                                  "€${player.price.toStringAsFixed(2)}",
                                  key: ValueKey(player.price),
                                  style: const TextStyle(
                                    color: ConstColors.light,
                                    fontFamily: poppinsMedium,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
