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
  final Map<String, dynamic> card;

  const HistoryTab({super.key, required this.player, required this.card});

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
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TODAY
          if (player.isOwned)
            HistoryCard(
              icon: Icons.shopping_cart,
              title: "Bought",
              description: "Market → You",
              price: "€${(widget.player.price + 1.25).toStringAsFixed(2)}",
              date: DateFormat("MMM dd, yyyy").format(DateTime.now()),
              timeStamp: DateFormat("HH:mm").format(DateTime.now()),
              playerId: playerId,
              cardNumber: 2,
              totalIssued: totalIssued,
              isHighlight: true,
            ),

          /// 18 DEC 2025
          HistoryCard(
            icon: Icons.swap_horiz,
            title: "Trade",
            description: "Alex Morgan → Anthony Vargas",
            price: "€${(widget.player.price - 0.75).toStringAsFixed(2)}",
            date: "Dec 18, 2025",
            timeStamp: "16:49",
            playerId: playerId,
            cardNumber: 2,
            totalIssued: totalIssued,
          ),

          /// 26 NOV 2025
          HistoryCard(
            icon: Icons.swap_horiz,
            title: "Trade",
            description: "Market → David Silva",
            price: "€${(widget.player.price - 1.10).toStringAsFixed(2)}",
            date: "Nov 26, 2025",
            timeStamp: "18:46",
            playerId: playerId,
            cardNumber: 1,
            totalIssued: totalIssued,
          ),

          /// 21 OCT 2025
          HistoryCard(
            icon: Icons.swap_horiz,
            title: "Trade",
            description: "David Silva → Alex Morgan",
            price: "€${widget.player.price.toStringAsFixed(2)}",
            date: "Oct 21, 2025",
            timeStamp: "13:00",
            playerId: playerId,
            cardNumber: 1,
            totalIssued: totalIssued,
          ),

          /// 07 MAR 2025
          HistoryCard(
            icon: Icons.swap_horiz,
            title: "Trade",
            description: "Market → Alex Morgan",
            price: "€${(widget.player.price - 2.15).toStringAsFixed(2)}",
            date: "Mar 07, 2025",
            timeStamp: "11:00",
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
  final String timeStamp;
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
    required this.timeStamp,
    this.price,
    this.isHighlight = false,
    required this.playerId,
    required this.cardNumber,
    required this.totalIssued,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(date, style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.light)),
        Gap(12),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showHistoryDetail(context),
          child: Container(
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
                          Text(
                            title,
                            style: TextStyle(fontFamily: poppinsMedium, fontSize: 12, color: ConstColors.light),
                          ),
                          Text(
                            timeStamp,
                            style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray),
                          ),
                        ],
                      ),

                      const Gap(4),

                      /// DESCRIPTION + TRANSFER
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (description.contains("→")) ...[
                            _TransferArrow(
                              from: description.split("→")[0].trim(),
                              to: description.split("→")[1].trim(),
                            ),
                          ] else
                            Text(
                              description,
                              style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.darkGray),
                            ),
                        ],
                      ),

                      const Gap(6),

                      /// META INFO (ID + CARD NUMBER)
                      title != "Card Created" && title != "Price Updated"
                          ? Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              _MetaChip(text: "ID $playerId"),
                              _MetaChip(text: "Card #$cardNumber of $totalIssued"),
                            ],
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
          ),
        ),
      ],
    );
  }

  void _showHistoryDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ConstColors.baseColorDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        final parts = description.contains("→") ? description.split("→") : ["Unknown", "Unknown"];

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// DRAG HANDLE
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: ConstColors.baseColorDark5, borderRadius: BorderRadius.circular(4)),
              ),

              const Gap(20),

              /// ICON
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark3),
                child: Icon(icon, color: ConstColors.gold, size: 28),
              ),

              const Gap(16),

              /// TITLE
              Text(title, style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 16, color: ConstColors.light)),

              const Gap(6),

              /// DATE & TIME
              Text(
                "$date • $timeStamp",
                style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.gray),
              ),

              const Gap(20),

              /// TRANSFER ROW (EUR → XLM STYLE)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _TransferEntity(parts[0].trim()),
                    Icon(Icons.arrow_forward, color: ConstColors.gold),
                    _TransferEntity(parts.length > 1 ? parts[1].trim() : ""),
                  ],
                ),
              ),

              const Gap(16),

              /// VALUE
              if (price != null)
                Text(price!, style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 18, color: ConstColors.light)),

              const Gap(20),

              /// META INFO
              Wrap(
                spacing: 8,
                children: [
                  _DetailChip("Card #$cardNumber"),
                  _DetailChip("Issued $totalIssued"),
                  _DetailChip("ID $playerId"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TransferEntity extends StatelessWidget {
  final String label;

  const _TransferEntity(this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark5),
          child: Center(
            child: Text(
              label.isNotEmpty ? label[0].toUpperCase() : "?",
              style: TextStyle(fontFamily: poppinsSemiBold, color: ConstColors.light),
            ),
          ),
        ),
        const Gap(6),
        Text(label, style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.gray)),
      ],
    );
  }
}

class _DetailChip extends StatelessWidget {
  final String text;

  const _DetailChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontFamily: poppinsRegular, fontSize: 11, color: ConstColors.gray)),
    );
  }
}

class _TransferArrow extends StatelessWidget {
  final String from;
  final String to;

  const _TransferArrow({required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(from, style: TextStyle(fontSize: 11, color: ConstColors.gray)),
        const Gap(6),
        Icon(Icons.arrow_forward, size: 14, color: ConstColors.gold),
        const Gap(6),
        Text(to, style: TextStyle(fontSize: 11, color: ConstColors.light)),
      ],
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
