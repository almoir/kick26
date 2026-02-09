import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/card_model.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.card, required this.cards, required this.tag});

  final CardModel card;
  final List<CardModel> cards;
  final String tag;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
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
                Hero(tag: tag, child: Image.asset(card.media.images?.playerProfile ?? "", height: 96)),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardClassWidget(cardClass: card.data.cardClass ?? "C"),
                      const Gap(6),
                      Text(
                        card.player.name ?? "",
                        style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 15, color: ConstColors.light),
                      ),
                      const Gap(2),
                      Text(
                        card.club.name ?? "",
                        style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.gray),
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          _TagChip(_s(card.data.edition)),
                          const Gap(6),
                          _TagChip("#${card.data.sequenceNumber}/${card.data.totalIssued}"),
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
                _MetaInfo("Issuer", _s(card.data.issuerName)),
                _MetaInfo("Edition", _upper(card.data.edition)),
                _MetaInfo(
                  "Type",
                  _upper(
                    card.data.cardClass == "S"
                        ? "GOLD"
                        : card.data.cardClass == "A"
                        ? "DIAMOND"
                        : card.data.cardClass == "B"
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
                _MarketInfo("Floor Price", _euro(card.market.floorPrice)),
                _MarketInfo("Last Sale", _euro(card.market.lastTransactionPrice)),
                _MarketInfo("Highest Bid", _euro(card.market.highestBid), color: ConstColors.green2),
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
              _StatCard("Games", (card.player.snapshotBio?.games ?? 0).toString()),
              _StatCard("Goals", (card.player.snapshotBio?.goals ?? 0).toString()),
              _StatCard("Assists", (card.player.snapshotBio?.assists ?? 0).toString()),
            ],
          ),

          const Gap(8),

          Row(
            children: [
              _StatCard(
                "Trend",
                "${card.market.trend}%",
                valueColor: (card.market.isUp ?? false) ? ConstColors.green2 : ConstColors.orange,
              ),
              _StatCard("Age", "${card.player.snapshotBio?.age ?? 0}"),
              _StatCard("Height", "${card.player.snapshotBio?.height ?? 0}cm"),
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
              "${card.player.name} continues to deliver consistent performances, "
              "recording ${card.player.snapshotBio?.goals ?? 0} goals and ${card.player.snapshotBio?.assists ?? 0} assists "
              "across ${card.player.snapshotBio?.games ?? 0} matches this season.",
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
