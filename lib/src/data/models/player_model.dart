// import 'dart:convert';
// import 'dart:math';

// import 'package:kick26/src/common/dummy.dart';

// class PlayerModel {
//   final String id;
//   final String name;
//   double price; // bukan final -> bisa diupdate
//   final String cardClass;
//   final int owned;
//   final String club;
//   final String image;
//   final String clubImage;
//   final String countryCode;
//   double trend; // current percent change (mis. 2.34)
//   bool isUp;
//   final int height;
//   final int weight;
//   final int age;
//   final int games;
//   final int goals;
//   final int assists;

//   PlayerModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.cardClass,
//     required this.owned,
//     required this.club,
//     required this.image,
//     required this.clubImage,
//     required this.countryCode,
//     required this.trend,
//     required this.isUp,
//     required this.height,
//     required this.weight,
//     required this.age,
//     required this.games,
//     required this.goals,
//     required this.assists,
//   });
//   bool get isOwned => owned > 0;
//   // helper: buat dari map dummy (yang price-nya string seperti "€99,999.99")
//   factory PlayerModel.fromDummyMap(
//     Map<String, dynamic> m, {
//     double? initialTrend,
//     bool? initialIsUp,
//   }) {
//     double parsedPrice = _parsePriceString(m['price'] ?? m['price'].toString());
//     return PlayerModel(
//       id: m['id'] as String,
//       name: m['name'] as String,
//       price: parsedPrice,
//       cardClass: m['cardClass'],
//       owned: m['owned'] as int,
//       club: m['club'] as String,
//       image: m['image'] as String,
//       clubImage: m['clubImage'] as String,
//       countryCode: m['countryCode'] as String,
//       trend: initialTrend ?? 0,
//       isUp: initialIsUp ?? true,
//       height: m['height'] as int,
//       weight: m['weight'] as int,
//       age: m['age'] as int,
//       games: m['games'] as int,
//       goals: m['goals'] as int,
//       assists: m['assists'] as int,
//     );
//   }

//   // format price kembali ke string "€xx,xxx.xx"
//   String toPriceString() {
//     // show thousands separator
//     final intPart = price.floor();
//     final fraction = ((price - intPart) * 100).round().toString().padLeft(
//       2,
//       '0',
//     );
//     final intStr = intPart.toString().replaceAllMapped(
//       RegExp(r'\B(?=(\d{3})+(?!\d))'),
//       (m) => ',',
//     );
//     return '€$intStr.$fraction';
//   }

//   // parse "€99,999.99" -> 99999.99
//   static double _parsePriceString(String raw) {
//     try {
//       var s = raw.replaceAll('€', '').replaceAll(',', '').trim();
//       return double.parse(s);
//     } catch (e) {
//       return 0.0;
//     }
//   }

//   PlayerModel copyWith({
//     String? id,
//     String? name,
//     double? price,
//     String? cardClass,
//     int? owned,
//     String? club,
//     String? image,
//     String? clubImage,
//     String? countryCode,
//     double? trend,
//     bool? isUp,
//     int? height,
//     int? weight,
//     int? age,
//     int? games,
//     int? goals,
//     int? assists,
//   }) {
//     return PlayerModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       price: price ?? this.price,
//       cardClass: cardClass ?? this.cardClass,
//       owned: owned ?? this.owned,
//       club: club ?? this.club,
//       image: image ?? this.image,
//       clubImage: clubImage ?? this.clubImage,
//       countryCode: countryCode ?? this.countryCode,
//       trend: trend ?? this.trend,
//       isUp: isUp ?? this.isUp,
//       height: height ?? this.height,
//       weight: weight ?? this.weight,
//       age: age ?? this.age,
//       games: games ?? this.games,
//       goals: goals ?? this.goals,
//       assists: assists ?? this.assists,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'price': price,
//       'cardClass': cardClass,
//       'owned': owned,
//       'club': club,
//       'image': image,
//       'clubImage': clubImage,
//       'countryCode': countryCode,
//       'trend': trend,
//       'isUp': isUp,
//       'height': height,
//       'weight': weight,
//       'age': age,
//       'games': games,
//       'goals': goals,
//       'assists': assists,
//     };
//   }

//   factory PlayerModel.fromMap(Map<String, dynamic> map) {
//     return PlayerModel(
//       id: map['id'] ?? '',
//       name: map['name'] ?? '',
//       price: map['price']?.toDouble() ?? 0.0,
//       cardClass: map['cardClass'] ?? '',
//       owned: map['owned'] ?? 0,
//       club: map['club'] ?? '',
//       image: map['image'] ?? '',
//       clubImage: map['clubImage'] ?? '',
//       countryCode: map['countryCode'] ?? '',
//       trend: map['trend']?.toDouble() ?? 0.0,
//       isUp: map['isUp'] ?? false,
//       height: map['height']?.toInt() ?? 0,
//       weight: map['weight']?.toInt() ?? 0,
//       age: map['age']?.toInt() ?? 0,
//       games: map['games']?.toInt() ?? 0,
//       goals: map['goals']?.toInt() ?? 0,
//       assists: map['assists']?.toInt() ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory PlayerModel.fromJson(String source) =>
//       PlayerModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'PlayerModel(id: $id, name: $name, price: $price, cardClass: $cardClass, isOwned: $owned, club: $club, image: $image, clubImage: $clubImage, countryCode: $countryCode, trend: $trend, isUp: $isUp, height: $height, weight: $weight, age: $age, games: $games, goals: $goals, assists: $assists)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is PlayerModel &&
//         other.id == id &&
//         other.name == name &&
//         other.price == price &&
//         other.cardClass == cardClass &&
//         other.owned == owned &&
//         other.club == club &&
//         other.image == image &&
//         other.clubImage == clubImage &&
//         other.countryCode == countryCode &&
//         other.trend == trend &&
//         other.isUp == isUp &&
//         other.height == height &&
//         other.weight == weight &&
//         other.age == age &&
//         other.games == games &&
//         other.goals == goals &&
//         other.assists == assists;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         price.hashCode ^
//         cardClass.hashCode ^
//         owned.hashCode ^
//         club.hashCode ^
//         image.hashCode ^
//         clubImage.hashCode ^
//         countryCode.hashCode ^
//         trend.hashCode ^
//         isUp.hashCode ^
//         height.hashCode ^
//         weight.hashCode ^
//         age.hashCode ^
//         games.hashCode ^
//         goals.hashCode ^
//         assists.hashCode;
//   }
// }

// // generator yang menggunakan dummyPlayers (asumsi dummy.dart berisi List<Map> dummyPlayers)
// List<PlayerModel> generateDummyPlayers({int seed = 0}) {
//   final rnd = seed == 0 ? Random() : Random(seed);
//   return dummyPlayers.map((m) {
//     // initial trend dan direction acak tapi proporsional bisa diatur di sini
//     final change = (rnd.nextDouble() * 6) - 3; // -3 .. +3 initial
//     return PlayerModel.fromDummyMap(
//       m,
//       initialTrend: double.parse(change.toStringAsFixed(2)),
//       initialIsUp: change >= 0,
//     );
//   }).toList();
// }

// // fungsi untuk update tiap interval: mutates list players
// void updatePlayerTrends(
//   List<PlayerModel> players, {
//   Random? random,
//   double maxChangePercent = 3,
// }) {
//   final rnd = random ?? Random();
//   for (final p in players) {
//     // generate perubahan acak antara -maxChangePercent .. +maxChangePercent
//     final changePercent =
//         (rnd.nextDouble() * (2 * maxChangePercent)) - maxChangePercent;
//     // apply: jika mau trend menunjukkan cumulative atau current change?
//     // Di sini kita set trend = changePercent (current tick), dan price berubah mengikuti changePercent.
//     p.trend = double.parse(changePercent.toStringAsFixed(2));
//     p.isUp = changePercent >= 0;

//     // update price: p.price * (1 + changePercent/100)
//     final newPrice = p.price * (1 + (changePercent / 100));
//     // optional: bataskan price agar tetap realistis
//     final minPrice = p.price * 0.5;
//     final maxPrice = p.price * 2;

//     p.price = newPrice.clamp(minPrice, maxPrice);
//   }
// }
