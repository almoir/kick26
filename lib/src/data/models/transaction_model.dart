import 'package:kick26/src/data/models/card_model.dart';

class TransactionModel {
  final String id;
  final CardModel card;
  final bool isBuy;
  final DateTime date;

  TransactionModel({required this.id, required this.card, required this.isBuy, required this.date});
}
