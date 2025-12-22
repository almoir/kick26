import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';

class DetailPlayerTabBar extends StatelessWidget {
  const DetailPlayerTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Colors.transparent,
      isScrollable: true,
      indicator: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(6)),
      labelPadding: EdgeInsets.only(right: 8),
      indicatorColor: Colors.transparent,
      indicatorAnimation: TabIndicatorAnimation.linear,
      tabAlignment: TabAlignment.center,
      labelStyle: const TextStyle(fontFamily: poppinsRegular, color: ConstColors.gold, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontFamily: poppinsRegular, color: ConstColors.gray10, fontSize: 12),
      tabs: [
        SizedBox(height: 26, width: 84, child: Tab(text: "Overview")),
        SizedBox(height: 26, width: 84, child: Tab(text: "Market")),
        SizedBox(height: 26, width: 84, child: Tab(text: "Player")),
        SizedBox(height: 26, width: 84, child: Tab(text: "History")),
      ],
    );
  }
}
