import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/data/models/card_model.dart';
import 'package:kick26/src/presentation/menu/history/widgets/history_tab_widget.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<CardModel> cards1 = [];
  List<CardModel> cards2 = [];
  List<CardModel> cards3 = [];
  List<CardModel> cards4 = [];
  @override
  void initState() {
    cards1 = generateDummyCards().getRange(10, 20).toList();
    cards2 = generateDummyCards().getRange(20, 30).toList();
    cards3 = generateDummyCards().getRange(30, 40).toList();
    cards4 = generateDummyCards().getRange(40, 50).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("History", style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15)),
        centerTitle: true,
      ),

      // BODY
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TabBar(
                dividerColor: Colors.transparent,
                isScrollable: true,
                indicator: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(6)),
                labelPadding: EdgeInsets.only(right: 8),
                indicatorColor: Colors.transparent,
                indicatorAnimation: TabIndicatorAnimation.linear,
                tabAlignment: TabAlignment.center,
                labelStyle: const TextStyle(fontFamily: poppinsRegular, color: ConstColors.gold, fontSize: 12),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: poppinsRegular,
                  color: ConstColors.gray10,
                  fontSize: 12,
                ),
                tabs: [
                  SizedBox(height: 26, width: 84, child: Tab(text: "All")),
                  SizedBox(height: 26, width: 84, child: Tab(text: "Purchase")),
                  SizedBox(height: 26, width: 84, child: Tab(text: "Bid")),
                  SizedBox(height: 26, width: 84, child: Tab(text: "Sale")),
                ],
              ),
              Gap(16),
              Expanded(
                child: TabBarView(
                  children: [
                    HistoryTabWidget(cards: cards1, tag: "all"),
                    HistoryTabWidget(cards: cards2, tag: "purchase"),
                    HistoryTabWidget(cards: cards3, tag: "bid"),
                    HistoryTabWidget(cards: cards4, tag: "sale"),
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
