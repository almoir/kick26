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
import 'package:kick26/src/data/models/card_model.dart';
import 'package:kick26/src/presentation/market/market_search_screen.dart';
import 'package:kick26/src/presentation/market/widgets/list_player_widget.dart';
import 'package:kick26/src/presentation/market/widgets/search_field_widget.dart';

void updateCardPrices(List<CardModel> cards, {required Random random, double maxChangePercent = 3}) {
  for (var card in cards) {
    final oldPrice = card.market.currentPrice;
    final changePercent = (random.nextDouble() * maxChangePercent) * (random.nextBool() ? 1 : -1);
    final newPrice = card.market.currentPrice ?? 0 * (1 + (changePercent / 100));
    card.market.currentPrice = newPrice.clamp(0, double.infinity);
    card.market.isUp = newPrice > (oldPrice?.toDouble() ?? 0);
  }
}

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<CardModel> cards;
  late List<CardModel> ownedCards;
  late List<CardModel> notOwnedCards;
  Timer? _timer;
  final _rnd = Random();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    cards = generateDummyCards();
    ownedCards = cards.where((card) => card.data.isOwned).toList();
    notOwnedCards = cards.where((card) => !card.data.isOwned).toList();

    // 🔹 Update harga tiap 5 detik
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        updateCardPrices(cards, random: _rnd);
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
            child: SearchFieldWidget(
              readOnly: true,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketSearchScreen(cards: cards)),
                  ),
            ),
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
                      Text("Top Selling", style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.light)),
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
                            child: GoldGradient(child: Image.asset(IconPaths.home.arrowRight2, width: 14, height: 14)),
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
                      final card = notOwnedCards.sublist(10, 20)[index];
                      return FlipPlayerCardWidget(card: card, cards: cards, tag: "market_screen_1");
                    },
                  ),
                ),
              ],
            ),
          ),
          Gap(24),

          // TRENDINGS
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
                      Text("Trendings", style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.light)),
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
                            child: GoldGradient(child: Image.asset(IconPaths.home.arrowRight2, width: 14, height: 14)),
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
                      final card = notOwnedCards.sublist(30, 40)[index];
                      return FlipPlayerCardWidget(card: card, cards: cards, tag: "market_screen_2");
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
              tabs: const [Tab(text: "All"), Tab(text: "Top Selling"), Tab(text: "Trending"), Tab(text: "New")],
            ),
          ),

          SizedBox(
            height: MediaQuery.sizeOf(context).height * .6,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListPlayersWidget(cards: notOwnedCards),
                ListPlayersWidget(cards: notOwnedCards.sublist(6, 12)),
                ListPlayersWidget(cards: notOwnedCards.sublist(12, 18)),
                ListPlayersWidget(cards: notOwnedCards.sublist(18, 24)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
