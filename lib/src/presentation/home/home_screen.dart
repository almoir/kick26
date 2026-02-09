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
import 'package:kick26/src/data/models/card_model.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onTapTrending;
  const HomeScreen({super.key, this.onTapTrending});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String choosenMenu = 'Very Rare';

  late List<CardModel> cards;
  late List<CardModel> ownedCards;
  late List<CardModel> notOwnedCards;
  late List<CardModel> sClassCards;
  late List<CardModel> aClassCards;
  late List<CardModel> bClassCards;
  late List<CardModel> cClassCards;

  Timer? _timer;
  final _rnd = Random();

  @override
  void initState() {
    super.initState();
    cards = generateDummyCards();
    ownedCards = cards.where((card) => card.data.isOwned).toList();
    notOwnedCards = cards.where((card) => !card.data.isOwned).toList();
    sClassCards = cards.where((card) => card.data.cardClass == 'S').toList();
    aClassCards = cards.where((card) => card.data.cardClass == 'A').toList();
    bClassCards = cards.where((card) => card.data.cardClass == 'B').toList();
    cClassCards = cards.where((card) => card.data.cardClass == 'C').toList();
    // update pertama kali agar tidak kosong (opsional)
    updateCardTrends(cards, random: _rnd, maxChangePercent: 3);

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        // setiap tick, random change kecil
        updateCardTrends(cards, random: _rnd, maxChangePercent: 3);
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
      length: 4,
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
                              style: TextStyle(color: ConstColors.gray10, fontFamily: poppinsRegular, fontSize: 12),
                            ),
                            Gap(10),
                            Text(
                              '€48.341,77',
                              style: TextStyle(color: ConstColors.white, fontFamily: poppinsSemiBold, fontSize: 24),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GoldGradient(child: Icon(Icons.arrow_drop_up_sharp)),
                                GoldGradient(
                                  child: Text(
                                    '0.73 (-0.73%) Today',
                                    style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(40),
                        Expanded(child: Image.asset(ImagePaths.home.chartOutlined)),
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
                      style: TextStyle(color: ConstColors.light, fontFamily: poppinsRegular),
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
                          child: GoldGradient(child: Image.asset(IconPaths.home.arrowRight2, width: 14, height: 14)),
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
                  itemCount: 5,
                  padding: const EdgeInsets.only(left: 16),
                  itemBuilder: (context, index) {
                    final card = ownedCards[index];
                    return FlipPlayerCardWidget(card: card, cards: cards, tag: "home_screen");
                  },
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
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorAnimation: TabIndicatorAnimation.linear,
                  indicatorWeight: 1,
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  labelStyle: const TextStyle(fontFamily: poppinsRegular, color: ConstColors.gold, fontSize: 12),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: poppinsRegular,
                    color: ConstColors.gray10,
                    fontSize: 12,
                  ),
                  tabs: const [Tab(text: "S Class"), Tab(text: "A Class"), Tab(text: "B Class"), Tab(text: "C Class")],
                ),
              ),
              const Gap(12),
              SizedBox(
                height: 400,
                child: TabBarView(
                  children: [
                    ListTilePlayersWidget(cards: sClassCards),
                    ListTilePlayersWidget(cards: aClassCards),
                    ListTilePlayersWidget(cards: bClassCards),
                    ListTilePlayersWidget(cards: cClassCards),
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
