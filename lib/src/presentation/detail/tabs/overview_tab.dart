import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.player, required this.players, required this.tag, required this.card});

  final PlayerModel player;
  final List<PlayerModel> players;
  final String tag;
  final Map<String, dynamic> card;

  String _s(dynamic v, {String fallback = "-"}) {
    if (v == null) return fallback;
    return v.toString();
  }

  String _upper(dynamic v) {
    if (v == null) return "-";
    return v.toString().toUpperCase();
  }

  String _euro(dynamic v) {
    if (v == null) return "€-";
    return "€${(v as num).toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    final cardData = card['card'];
    final market = card['market'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ============================
          /// PLAYER + CARD HEADER
          /// ============================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ConstColors.baseColorDark3,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ConstColors.baseColorDark5),
            ),
            child: Row(
              children: [
                Hero(tag: tag, child: Image.asset(player.image, height: 96)),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardClassWidget(cardClass: player.cardClass),
                      const Gap(6),
                      Text(
                        player.name,
                        style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 15, color: ConstColors.light),
                      ),
                      const Gap(2),
                      Text(
                        player.club,
                        style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.gray),
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          _TagChip(_s(cardData['edition'])),
                          const Gap(6),
                          _TagChip("#${cardData['sequenceNumber']}/${cardData['totalIssued']}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Gap(16),

          /// ============================
          /// CARD IDENTITY
          /// ============================
          _SectionTitle("Card Identity"),
          const Gap(8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MetaInfo("Issuer", _s(cardData['issuerName'])),
                _MetaInfo("Edition", _upper(cardData['edition'])),
                _MetaInfo(
                  "Type",
                  _upper(
                    player.cardClass == "S"
                        ? "GOLD"
                        : player.cardClass == "A"
                        ? "DIAMOND"
                        : player.cardClass == "B"
                        ? "SILVER"
                        : "BRONZE",
                  ),
                ),
              ],
            ),
          ),

          const Gap(16),

          /// ============================
          /// MARKET SNAPSHOT
          /// ============================
          _SectionTitle("Market Snapshot"),
          const Gap(8),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MarketInfo("Floor Price", _euro(market['floorPrice'])),
                _MarketInfo("Last Sale", _euro(market['lastTransactionPrice'])),
                _MarketInfo("Highest Bid", _euro(market['highestBid']), color: ConstColors.green2),
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
              "${player.name} continues to deliver consistent performances, "
              "recording ${player.goals} goals and ${player.assists} assists "
              "across ${player.games} matches this season.",
              style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================
/// SHARED COMPONENTS
/// ============================

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

class _MetaInfo extends StatelessWidget {
  final String label;
  final String value;

  const _MetaInfo(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray)),
        const Gap(4),
        value == "GOLD"
            ? GoldGradient(
              child: Text(value, style: TextStyle(fontFamily: poppinsMedium, fontSize: 12, color: ConstColors.light)),
            )
            : Text(value, style: TextStyle(fontFamily: poppinsMedium, fontSize: 12, color: ConstColors.light)),
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
