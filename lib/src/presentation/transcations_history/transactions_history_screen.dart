import 'package:flutter/material.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/data/models/transaction_model.dart';
import 'package:kick26/src/presentation/transcations_history/detail_bottom_sheet/transaction_detail_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class TransactionsHistoryScreen extends StatefulWidget {
  const TransactionsHistoryScreen({super.key, required this.players});
  final List<PlayerModel> players;

  @override
  State<TransactionsHistoryScreen> createState() =>
      _TransactionsHistoryScreenState();
}

class _TransactionsHistoryScreenState extends State<TransactionsHistoryScreen> {
  late List<PlayerModel> players;
  late List<TransactionModel> transactions;

  @override
  void initState() {
    super.initState();

    players = generateDummyPlayers();

    transactions = [
      TransactionModel(
        id: Uuid().v1(),
        player: players[0],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[4],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[7],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[2],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[9],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 5, hours: 1)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[3],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 7)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[10],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 8, hours: 4)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[1],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 9, hours: 2)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[5],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 10)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[6],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 12, hours: 6)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[8],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 13)),
      ),
      TransactionModel(
        id: Uuid().v1(),
        player: players[11],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 14, hours: 3)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 72,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ConstColors.baseColorDark5),
            ),
            child: Center(
              child: GoldGradient(
                child: const Icon(Icons.chevron_left, size: 28),
              ),
            ),
          ),
        ),
        title: Text(
          "Transactions History",
          style: TextStyle(
            color: ConstColors.light,
            fontFamily: poppinsSemiBold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: ConstColors.baseColorDark,
        child: ListView.builder(
          itemCount: transactions.length,
          padding: const EdgeInsets.only(top: 12, bottom: 30),
          itemBuilder: (context, index) {
            final tx = transactions[index];
            final player = tx.player;

            return InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => TransactionDetailBottomSheet(transaction: tx),
                );
              },

              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ConstColors.baseColorDark3,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    // Player Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        player.image,
                        width: 55,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Player Info & Transaction Detail
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Player Name
                          Text(
                            player.name,
                            style: TextStyle(
                              color: ConstColors.light,
                              fontSize: 14,
                              fontFamily: poppinsSemiBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Buy/Sell Label
                          Row(
                            children: [
                              GoldGradientBorder(
                                borderRadius: 6,
                                borderWidth: 1,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                backgroundColor: ConstColors.baseColorDark3,
                                child: GoldGradient(
                                  child: Text(
                                    tx.isBuy ? "BUY" : "SELL",
                                    style: TextStyle(
                                      fontFamily: poppinsMedium,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 6),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price + Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          tx.isBuy
                              ? "- €${formatPrice(player.price)}"
                              : "+ €${formatPrice(player.price)}",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: poppinsSemiBold,
                            color:
                                tx.isBuy
                                    ? ConstColors.orange.withValues(alpha: 0.8)
                                    : ConstColors.green.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatDateTime(tx.date),
                          style: TextStyle(
                            color: ConstColors.gray,
                            fontSize: 10,
                            fontFamily: poppinsSemiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
