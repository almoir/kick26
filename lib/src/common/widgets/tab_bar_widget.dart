import 'package:flutter/material.dart';
import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/common/fonts_family.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  final TabController tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
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
      indicatorWeight: 1,
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.zero,
      tabs: tabs,
    );
  }
}
