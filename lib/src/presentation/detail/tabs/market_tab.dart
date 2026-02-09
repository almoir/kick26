import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/card_model.dart';

class MarketTab extends StatelessWidget {
  const MarketTab({super.key, required this.cards, required this.card});

  final List<CardModel> cards;
  final CardModel card;

  String _euro(dynamic v) {
    if (v == null) return "€-";
    return "€${(v as num).toStringAsFixed(2)}";
  }

  String _s(dynamic v, {String fallback = "-"}) {
    if (v == null) return fallback;
    return v.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ============================
            /// MARKET SUMMARY IMAGE (DO NOT TOUCH)
            /// ============================
            Image.asset("assets/images/market_summary.png"),

            const Gap(16),

            /// ============================
            /// MARKET STATUS FLAGS
            /// ============================
            Row(
              children: [
                _FlagChip("On Market", card.market.isOnMarket == true),
                const Gap(8),
                _FlagChip("Tradable", card.market.isTradable == true),
                const Gap(8),
                _FlagChip("Bid Enabled", card.market.isBidEnabled == true),
              ],
            ),

            const Gap(16),

            /// ============================
            /// PRICE SNAPSHOT
            /// ============================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price Snapshot",
                    style: TextStyle(fontFamily: poppinsMedium, fontSize: 13, color: ConstColors.light),
                  ),
                  const Gap(12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PriceMetric("Current", _euro(card.market.currentPrice)),
                      _PriceMetric("Floor", _euro(card.market.floorPrice)),
                      _PriceMetric("Highest Bid", _euro(card.market.highestBid), valueColor: ConstColors.green2),
                    ],
                  ),

                  const Gap(12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PriceMetric("24h Change", "${card.market.trend}%", valueColor: ConstColors.green2),
                      _PriceMetric("Low", _euro(card.market.low)),
                      _PriceMetric("High", _euro(card.market.high)),
                    ],
                  ),
                ],
              ),
            ),

            const Gap(16),

            /// ============================
            /// MARKET ACTIVITY
            /// ============================
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Market Activity",
                    style: TextStyle(fontFamily: poppinsMedium, fontSize: 13, color: ConstColors.light),
                  ),
                  const Gap(12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Stat("Trades", _s(card.market.totalTrades)),
                      _Stat("Owners", _s(card.market.uniqueOwners)),
                      _Stat("Currency", _s(card.market.currency)),
                    ],
                  ),

                  const Gap(12),

                  Text(
                    "Last traded at ${_s(card.market.lastTradedAt)}",
                    style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.darkGray),
                  ),
                ],
              ),
            ),

            const Gap(16),

            /// ============================
            /// LIVE FEED (EXISTING UI – ENHANCED COPY)
            /// ============================
            GoldGradient(child: const Text('Live Feed', style: TextStyle(fontFamily: poppinsRegular))),

            const Gap(12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT CARD
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: Row(
                            children: [
                              Image.asset(IconPaths.home.file, width: 12, height: 12),
                              const Gap(4),
                              Text("Recent Issuances", style: TextStyle(color: ConstColors.light, fontSize: 12)),
                            ],
                          ),
                        ),
                        const Gap(4),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "New cards issued recently",
                            style: TextStyle(color: ConstColors.darkGray, fontSize: 12),
                          ),
                        ),
                        const Gap(8),
                        const Divider(color: Color(0xff2B2B2B)),
                        const Gap(8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Image.asset(IconPaths.home.graph, width: 12, height: 12),
                              const Gap(4),
                              Text("Large Trades", style: TextStyle(color: ConstColors.light, fontSize: 12)),
                            ],
                          ),
                        ),
                        const Gap(4),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Text(
                            "${_euro(card.market.highestBid)} trade executed",
                            style: TextStyle(color: ConstColors.darkGray, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(8),

                /// RIGHT CARD
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("MARKET CAP", style: TextStyle(color: ConstColors.light, fontSize: 12)),
                            Text("24H", style: TextStyle(color: ConstColors.darkGray, fontSize: 12)),
                          ],
                        ),
                        const Gap(8),
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
    );
  }
}

/// ============================
/// SMALL COMPONENTS
/// ============================

class _FlagChip extends StatelessWidget {
  final String label;
  final bool active;

  const _FlagChip(this.label, this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? ConstColors.green2.withValues(alpha: 0.15) : ConstColors.baseColorDark5,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: active ? ConstColors.green2 : ConstColors.baseColorDark5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// CHECK ICON (ONLY IF ACTIVE)
          if (active) ...[Icon(Icons.check_circle, size: 12, color: ConstColors.green2), const Gap(4)],

          /// LABEL
          Text(
            label,
            style: TextStyle(
              fontFamily: poppinsMedium,
              fontSize: 10,
              color: active ? ConstColors.green2 : ConstColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _PriceMetric(this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray)),
        const Gap(4),
        Text(
          value,
          style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 13, color: valueColor ?? ConstColors.light),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;

  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray)),
        const Gap(4),
        Text(value, style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 12, color: ConstColors.light)),
      ],
    );
  }
}
