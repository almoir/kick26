import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/data/models/player_model.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.player, required this.players, required this.tag});

  final PlayerModel player;
  final List<PlayerModel> players;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ============================
          /// PLAYER HEADER
          /// ============================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Hero(tag: tag, child: Image.asset(player.image, height: 90)),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardClassWidget(cardClass: player.cardClass),
                      const Gap(8),
                      Text(
                        player.name,
                        style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 14, color: ConstColors.light),
                      ),
                      const Gap(4),
                      Text(
                        player.club,
                        style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.gray),
                      ),
                      const Gap(6),
                      _TagChip("${player.owned} Owned"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Gap(16),

          /// ============================
          /// FINANCIALS
          /// ============================
          _SectionTitle("Financials"),
          const Gap(8),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MarketInfo("Current Price", "€${player.price.toStringAsFixed(2)}"),
                _MarketInfo(
                  "24h Change",
                  player.isUp ? "+${player.trend}%" : "${player.trend}%",
                  color: player.isUp ? ConstColors.green2 : ConstColors.orange,
                ),
                _MarketInfo("Owned", "${player.owned} Cards"),
              ],
            ),
          ),

          const Gap(16),

          /// ============================
          /// KEY STATS
          /// ============================
          _SectionTitle("Key Stats"),
          const Gap(8),

          Row(
            children: [
              _StatCard("Games", player.games.toString()),
              _StatCard("Goals", player.goals.toString()),
              _StatCard("Assists", player.assists.toString()),
            ],
          ),

          const Gap(8),

          Row(
            children: [
              _StatCard("Trend", "${player.trend}%", valueColor: player.isUp ? ConstColors.green2 : ConstColors.orange),
              _StatCard("Age", "${player.age}"),
              _StatCard("Height", "${player.height}cm"),
            ],
          ),

          const Gap(16),

          /// ============================
          /// PERFORMANCE HIGHLIGHT
          /// ============================
          _SectionTitle("Performance Highlight"),
          const Gap(8),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
            child: Text(
              "${player.name} has been one of the most consistent performers this season with "
              "${player.assists} assists and ${player.goals} goals across ${player.games} matches.",
              style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontFamily: poppinsMedium, fontSize: 13, color: ConstColors.light));
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _StatCard(this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 14, color: valueColor ?? ConstColors.light),
            ),
            const Gap(4),
            Text(label, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray)),
          ],
        ),
      ),
    );
  }
}

class _MarketInfo extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _MarketInfo(this.label, this.value, {this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray)),
        const Gap(4),
        Text(value, style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 12, color: color ?? ConstColors.light)),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;

  const _TagChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: ConstColors.baseColorDark5, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.light)),
    );
  }
}
