import 'package:flutter/material.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/data/models/transaction_model.dart';

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
        id: "t1",
        player: players[0],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
      TransactionModel(
        id: "t2",
        player: players[4],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
      ),
      TransactionModel(
        id: "t3",
        player: players[7],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      TransactionModel(
        id: "t4",
        player: players[2],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      ),
      TransactionModel(
        id: "t5",
        player: players[9],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 5, hours: 1)),
      ),
      TransactionModel(
        id: "t6",
        player: players[3],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 7)),
      ),
      TransactionModel(
        id: "t7",
        player: players[10],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 8, hours: 4)),
      ),
      TransactionModel(
        id: "t8",
        player: players[1],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 9, hours: 2)),
      ),
      TransactionModel(
        id: "t9",
        player: players[5],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 10)),
      ),
      TransactionModel(
        id: "t10",
        player: players[6],
        isBuy: false,
        date: DateTime.now().subtract(const Duration(days: 12, hours: 6)),
      ),
      TransactionModel(
        id: "t11",
        player: players[8],
        isBuy: true,
        date: DateTime.now().subtract(const Duration(days: 13)),
      ),
      TransactionModel(
        id: "t12",
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

            return Container(
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
                          style: const TextStyle(
                            fontFamily: poppinsSemiBold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Buy/Sell Label
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color:
                                    tx.isBuy
                                        ? Colors.green.withValues(alpha: 0.2)
                                        : Colors.red.withValues(alpha: 0.2),
                              ),
                              child: Text(
                                tx.isBuy ? "BUY" : "SELL",
                                style: TextStyle(
                                  color: tx.isBuy ? Colors.green : Colors.red,
                                  fontFamily: poppinsMedium,
                                  fontSize: 11,
                                ),
                              ),
                            ),

                            const SizedBox(width: 6),

                            Row(
                              children: [
                                Icon(
                                  player.isUp
                                      ? Icons.trending_up
                                      : Icons.trending_down,
                                  color:
                                      player.isUp ? Colors.green : Colors.red,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${player.trend}%",
                                  style: TextStyle(
                                    color:
                                        player.isUp ? Colors.green : Colors.red,
                                    fontFamily: poppinsRegular,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Price + Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GoldGradient(
                        child: Text(
                          formatPrice(player.price),
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: poppinsSemiBold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatDate(tx.date),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                          fontFamily: poppinsRegular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
