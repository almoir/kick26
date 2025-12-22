import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';

class HistoryTab extends StatefulWidget {
  final PlayerModel player;

  const HistoryTab({super.key, required this.player});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  String generatePlayerId(String name) {
    final initials = name.trim().split(RegExp(r'\s+')).map((e) => e.isNotEmpty ? e[0].toUpperCase() : '').join();

    final random = Random().nextInt(900000) + 100000; // 6 digit
    return "$initials-$random";
  }

  late PlayerModel player;

  late int totalIssued;
  late String playerId;

  @override
  void initState() {
    player = widget.player;
    totalIssued = 60;
    playerId = generatePlayerId(player.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Card History", style: TextStyle(fontFamily: poppinsMedium, fontSize: 14, color: ConstColors.light)),
          const Gap(16),

          player.isOwned
              ? HistoryCard(
                icon: Icons.shopping_cart,
                title: "Bought",
                description: "Bought by You",
                price: "EUR ${(widget.player.price + 1.25).toStringAsFixed(2)}",
                date: DateFormat("MMM dd, yyyy").format(DateTime.now()),
                playerId: playerId,
                cardNumber: 2,
                totalIssued: totalIssued,
                isHighlight: true,
              )
              : SizedBox(),

          HistoryCard(
            icon: Icons.trending_up,
            title: "Price Updated",
            description: "Market price adjusted",
            price: "EUR ${(widget.player.price + 1.25).toStringAsFixed(2)}",
            date: "Mar 01, 2025",
            playerId: playerId,
            cardNumber: Random().nextInt(50),
            totalIssued: totalIssued,
          ),

          HistoryCard(
            icon: Icons.swap_horiz,
            title: "Sold",
            description: "Sold from Alex Morgan to David Silva",
            price: "EUR ${widget.player.price.toStringAsFixed(2)}",
            date: "Feb 14, 2025",
            playerId: playerId,
            cardNumber: 1,
            totalIssued: totalIssued,
          ),

          HistoryCard(
            icon: Icons.shopping_cart,
            title: "Bought",
            description: "Bought by Alex Morgan",
            price: "EUR ${widget.player.price.toStringAsFixed(2)}",
            date: "Jan 02, 2025",
            playerId: playerId,
            cardNumber: 1,
            totalIssued: totalIssued,
          ),

          HistoryCard(
            icon: Icons.auto_awesome,
            title: "Card Created",
            description: "Initial card minted on platform",
            price: "EUR ${widget.player.price.toStringAsFixed(2)}",
            date: "Dec 12, 2024",
            playerId: playerId,
            cardNumber: 1,
            totalIssued: totalIssued,
          ),
        ],
      ),
    );
  }
}

// HISTORY CARD WIDGET
class HistoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String date;
  final String? price;
  final bool isHighlight;

  /// NEW
  final String playerId;
  final int cardNumber;
  final int totalIssued;

  const HistoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
    required this.playerId,
    required this.cardNumber,
    required this.totalIssued,
    this.price,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlight ? ConstColors.baseColorDark4 : ConstColors.baseColorDark3,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isHighlight ? ConstColors.gold : ConstColors.baseColorDark5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark5),
            child: Icon(icon, size: 16, color: ConstColors.gold),
          ),

          const Gap(12),

          /// CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE + DATE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontFamily: poppinsMedium, fontSize: 12, color: ConstColors.light)),
                    Text(date, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray)),
                  ],
                ),

                const Gap(4),

                /// DESCRIPTION
                Text(
                  description,
                  style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.darkGray),
                ),

                const Gap(6),

                /// META INFO (ID + CARD NUMBER)
                title != "Card Created" && title != "Price Updated"
                    ? Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [_MetaChip(text: "ID $playerId"), _MetaChip(text: "Card #$cardNumber of $totalIssued")],
                    )
                    : SizedBox(),

                if (price != null) ...[
                  const Gap(8),
                  GoldGradient(
                    child: Text(
                      price!,
                      style: TextStyle(fontFamily: poppinsMedium, fontSize: 11, color: ConstColors.light),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String text;

  const _MetaChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: ConstColors.baseColorDark5, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: TextStyle(fontFamily: poppinsRegular, fontSize: 9, color: ConstColors.gray10)),
    );
  }
}
