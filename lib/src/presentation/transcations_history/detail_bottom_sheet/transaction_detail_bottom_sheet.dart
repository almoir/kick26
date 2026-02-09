import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/transaction_model.dart';

class TransactionDetailBottomSheet extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailBottomSheet({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final card = transaction.card;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.35,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: ConstColors.baseColorDark,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(color: ConstColors.gray, borderRadius: BorderRadius.circular(20)),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------------- Player Section ----------------
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              card.media.images?.playerProfile ?? "",
                              width: 85,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card.player.name ?? "",
                                  style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 18),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Image.asset(card.media.images?.clubImage ?? "", height: 20),
                                    Gap(8),
                                    Text(
                                      card.club.name ?? "",
                                      style: TextStyle(
                                        color: ConstColors.gray,
                                        fontSize: 12,
                                        fontFamily: poppinsMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                Row(
                                  children: [
                                    Icon(
                                      transaction.isBuy ? Icons.call_made : Icons.call_received,
                                      color: transaction.isBuy ? ConstColors.orange : ConstColors.green,
                                      size: 18,
                                    ),
                                    Gap(6),
                                    Text(
                                      transaction.isBuy ? "Buy Transaction" : "Sell Transaction",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: poppinsMedium,
                                        color:
                                            transaction.isBuy
                                                ? ConstColors.orange.withValues(alpha: 0.8)
                                                : ConstColors.green.withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ---------------- Transaction Info ----------------
                      _detailSection(
                        title: "Transaction Details",
                        children: [
                          _detailRow("Transaction ID", transaction.id),
                          _divider(),
                          _detailRow("Type", transaction.isBuy ? "BUY" : "SELL"),
                          _divider(),
                          _detailRow(
                            transaction.isBuy ? "Amount Paid" : "Amount Received",
                            transaction.isBuy
                                ? "- €${formatPrice(card.market.currentPrice ?? 0)}"
                                : "+ €${formatPrice(card.market.currentPrice ?? 0)}",
                            valueColor:
                                transaction.isBuy
                                    ? ConstColors.orange.withValues(alpha: .8)
                                    : ConstColors.green.withValues(alpha: .8),
                          ),
                          _divider(),
                          _detailRow("Date", formatDate(transaction.date)),
                          _divider(),
                          _detailRow("Time", formatTime(transaction.date)),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ---------------- Status ----------------
                      Center(
                        child: GoldGradient(
                          child: Text(
                            "Transaction Completed",
                            style: TextStyle(fontSize: 14, fontFamily: poppinsSemiBold),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Center(
                        child: Text(
                          "This transaction has been recorded successfully.",
                          style: TextStyle(color: ConstColors.gray10, fontSize: 11, fontFamily: poppinsMedium),
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- Widgets ----------------

  Widget _detailSection({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _detailRow(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: ConstColors.gray10, fontFamily: poppinsMedium, fontSize: 12)),
          Gap(30),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? ConstColors.light,
                fontFamily: poppinsSemiBold,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 6), color: ConstColors.baseColorDark5);
  }
}
