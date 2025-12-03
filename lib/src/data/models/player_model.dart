import 'dart:math';

import 'package:kick26/src/common/dummy.dart';

const Map<String, dynamic> dummyStats = {
  "rating": 91,
  "speed": 85,
  "shooting": 92,
  "dribble": 94,
  "defense": 34,
  "passing": 90,
};

class PlayerModel {
  final String name;
  double price; // bukan final -> bisa diupdate
  final String club;
  final String image;
  final String clubImage;
  final String countryCode;
  double trend; // current percent change (mis. 2.34)
  bool isUp;
  final Map<String, dynamic> stats;

  PlayerModel({
    required this.name,
    required this.price,
    required this.club,
    required this.image,
    required this.clubImage,
    required this.countryCode,
    required this.trend,
    required this.isUp,
    this.stats = dummyStats,
  });

  // helper: buat dari map dummy (yang price-nya string seperti "€99,999.99")
  factory PlayerModel.fromMap(
    Map<String, dynamic> m, {
    double? initialTrend,
    bool? initialIsUp,
  }) {
    double parsedPrice = _parsePriceString(m['price'] ?? m['price'].toString());
    return PlayerModel(
      name: m['name'] as String,
      price: parsedPrice,
      club: m['club'] as String,
      image: m['image'] as String,
      clubImage: m['clubImage'] as String,
      countryCode: m['countryCode'] as String,
      trend: initialTrend ?? 0,
      isUp: initialIsUp ?? true,
    );
  }

  // format price kembali ke string "€xx,xxx.xx"
  String toPriceString() {
    // show thousands separator
    final intPart = price.floor();
    final fraction = ((price - intPart) * 100).round().toString().padLeft(
      2,
      '0',
    );
    final intStr = intPart.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => ',',
    );
    return '€$intStr.$fraction';
  }

  // parse "€99,999.99" -> 99999.99
  static double _parsePriceString(String raw) {
    try {
      var s = raw.replaceAll('€', '').replaceAll(',', '').trim();
      return double.parse(s);
    } catch (e) {
      return 0.0;
    }
  }
}

// generator yang menggunakan dummyPlayers (asumsi dummy.dart berisi List<Map> dummyPlayers)
List<PlayerModel> generateDummyPlayers({int seed = 0}) {
  final rnd = seed == 0 ? Random() : Random(seed);
  return dummyPlayers.map((m) {
    // initial trend dan direction acak tapi proporsional bisa diatur di sini
    final change = (rnd.nextDouble() * 6) - 3; // -3 .. +3 initial
    return PlayerModel.fromMap(
      m,
      initialTrend: double.parse(change.toStringAsFixed(2)),
      initialIsUp: change >= 0,
    );
  }).toList();
}

// fungsi untuk update tiap interval: mutates list players
void updatePlayerTrends(
  List<PlayerModel> players, {
  Random? random,
  double maxChangePercent = 3,
}) {
  final rnd = random ?? Random();
  for (final p in players) {
    // generate perubahan acak antara -maxChangePercent .. +maxChangePercent
    final changePercent =
        (rnd.nextDouble() * (2 * maxChangePercent)) - maxChangePercent;
    // apply: jika mau trend menunjukkan cumulative atau current change?
    // Di sini kita set trend = changePercent (current tick), dan price berubah mengikuti changePercent.
    p.trend = double.parse(changePercent.toStringAsFixed(2));
    p.isUp = changePercent >= 0;

    // update price: p.price * (1 + changePercent/100)
    final newPrice = p.price * (1 + (changePercent / 100));
    // optional: bataskan price agar tetap realistis
    p.price = newPrice.clamp(1000.0, 1e7);
  }
}
