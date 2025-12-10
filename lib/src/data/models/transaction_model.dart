import 'package:kick26/src/data/models/player_model.dart';

class TransactionModel {
  final String id;
  final PlayerModel player;
  final bool isBuy;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.player,
    required this.isBuy,
    required this.date,
  });
}
