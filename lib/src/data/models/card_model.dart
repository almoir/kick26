class CardModel {
  final CardInfo? card;
  final PlayerInfo? player;
  final ClubInfo? club;
  final Media? media;
  final Market? market;
  final List<Transaction>? transactions;
  final Metadata? metadata;

  CardModel({this.card, this.player, this.club, this.media, this.market, this.transactions, this.metadata});

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    card: json["card"] == null ? null : CardInfo.fromJson(json["card"]),
    player: json["player"] == null ? null : PlayerInfo.fromJson(json["player"]),
    club: json["club"] == null ? null : ClubInfo.fromJson(json["club"]),
    media: json["media"] == null ? null : Media.fromJson(json["media"]),
    market: json["market"] == null ? null : Market.fromJson(json["market"]),
    transactions:
        json["Transactions"] == null
            ? []
            : List<Transaction>.from(json["Transactions"]!.map((x) => Transaction.fromJson(x))),
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "card": card?.toJson(),
    "player": player?.toJson(),
    "club": club?.toJson(),
    "media": media?.toJson(),
    "market": market?.toJson(),
    "Transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "metadata": metadata?.toJson(),
  };
}

class CardInfo {
  final String? id;
  final String? edition;
  final int? totalIssued;
  final int? sequenceHnumber;
  final String? type;
  final DateTime? issuedAt;
  final String? issuerId;
  final String? issuerName;
  final String? approverId;
  final String? approverName;

  CardInfo({
    this.id,
    this.edition,
    this.totalIssued,
    this.sequenceHnumber,
    this.type,
    this.issuedAt,
    this.issuerId,
    this.issuerName,
    this.approverId,
    this.approverName,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) => CardInfo(
    id: json["id"],
    edition: json["edition"],
    totalIssued: json["totalIssued"],
    sequenceHnumber: json["sequenceHnumber"],
    type: json["type"],
    issuedAt: json["issuedAt"] == null ? null : DateTime.parse(json["issuedAt"]),
    issuerId: json["issuerId"],
    issuerName: json["issuerName"],
    approverId: json["approverId"],
    approverName: json["approverName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "edition": edition,
    "totalIssued": totalIssued,
    "sequenceHnumber": sequenceHnumber,
    "type": type,
    "issuedAt": issuedAt?.toIso8601String(),
    "issuerId": issuerId,
    "issuerName": issuerName,
    "approverId": approverId,
    "approverName": approverName,
  };
}

class ClubInfo {
  final String? name;
  final String? id;
  final String? country;
  final String? city;

  ClubInfo({this.name, this.id, this.country, this.city});

  factory ClubInfo.fromJson(Map<String, dynamic> json) =>
      ClubInfo(name: json["name"], id: json["id"], country: json["country"], city: json["city"]);

  Map<String, dynamic> toJson() => {"name": name, "id": id, "country": country, "city": city};
}

class Market {
  final int? currentPrice;
  final double? lastTransactionPrice;
  final double? low;
  final double? high;
  final String? currency;
  final bool? isOnMarket;
  final bool? isTradable;
  final bool? isBidEnabled;
  final int? floorPrice;
  final double? highestBid;
  final int? totalTrades;
  final int? uniqueOwners;
  final double? priceChange24H;
  final bool? isUp;
  final DateTime? lastTradedAt;

  Market({
    this.currentPrice,
    this.lastTransactionPrice,
    this.low,
    this.high,
    this.currency,
    this.isOnMarket,
    this.isTradable,
    this.isBidEnabled,
    this.floorPrice,
    this.highestBid,
    this.totalTrades,
    this.uniqueOwners,
    this.priceChange24H,
    this.isUp,
    this.lastTradedAt,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
    currentPrice: json["currentPrice"],
    lastTransactionPrice: json["lastTransactionPrice"]?.toDouble(),
    low: json["Low"]?.toDouble(),
    high: json["High"]?.toDouble(),
    currency: json["currency"],
    isOnMarket: json["isOnMarket"],
    isTradable: json["isTradable"],
    isBidEnabled: json["isBidEnabled"],
    floorPrice: json["floorPrice"],
    highestBid: json["highestBid"]?.toDouble(),
    totalTrades: json["totalTrades"],
    uniqueOwners: json["uniqueOwners"],
    priceChange24H: json["priceChange24h"]?.toDouble(),
    isUp: json["isUp"],
    lastTradedAt: json["lastTradedAt"] == null ? null : DateTime.parse(json["lastTradedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "currentPrice": currentPrice,
    "lastTransactionPrice": lastTransactionPrice,
    "Low": low,
    "High": high,
    "currency": currency,
    "isOnMarket": isOnMarket,
    "isTradable": isTradable,
    "isBidEnabled": isBidEnabled,
    "floorPrice": floorPrice,
    "highestBid": highestBid,
    "totalTrades": totalTrades,
    "uniqueOwners": uniqueOwners,
    "priceChange24h": priceChange24H,
    "isUp": isUp,
    "lastTradedAt": lastTradedAt?.toIso8601String(),
  };
}

class Media {
  final Images? images;
  final Videos? videos;

  Media({this.images, this.videos});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    images: json["images"] == null ? null : Images.fromJson(json["images"]),
    videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
  );

  Map<String, dynamic> toJson() => {"images": images?.toJson(), "videos": videos?.toJson()};
}

class Images {
  final String? playerProfile;
  final String? player1;
  final String? clubImage;
  final String? clubLogo;

  Images({this.playerProfile, this.player1, this.clubImage, this.clubLogo});

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    playerProfile: json["playerProfile"],
    player1: json["player1"],
    clubImage: json["clubImage"],
    clubLogo: json["clubLogo"],
  );

  Map<String, dynamic> toJson() => {
    "playerProfile": playerProfile,
    "player1": player1,
    "clubImage": clubImage,
    "clubLogo": clubLogo,
  };
}

class Videos {
  final String? goals;

  Videos({this.goals});

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(goals: json["goals"]);

  Map<String, dynamic> toJson() => {"goals": goals};
}

class Metadata {
  final MetadataCard? card;
  final MetadataPlayer? player;
  final MetadataClub? club;

  Metadata({this.card, this.player, this.club});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    card: json["card"] == null ? null : MetadataCard.fromJson(json["card"]),
    player: json["player"] == null ? null : MetadataPlayer.fromJson(json["player"]),
    club: json["club"] == null ? null : MetadataClub.fromJson(json["club"]),
  );

  Map<String, dynamic> toJson() => {"card": card?.toJson(), "player": player?.toJson(), "club": club?.toJson()};
}

class MetadataCard {
  final double? rarity;
  final double? popularity;

  MetadataCard({this.rarity, this.popularity});

  factory MetadataCard.fromJson(Map<String, dynamic> json) =>
      MetadataCard(rarity: json["rarity"]?.toDouble(), popularity: json["popularity"]?.toDouble());

  Map<String, dynamic> toJson() => {"rarity": rarity, "popularity": popularity};
}

class MetadataClub {
  final DateTime? allOtherPlayerData;
  final Match? match;

  MetadataClub({this.allOtherPlayerData, this.match});

  factory MetadataClub.fromJson(Map<String, dynamic> json) => MetadataClub(
    allOtherPlayerData:
        json["all other player data.."] == null ? null : DateTime.parse(json["all other player data.."]),
    match: json["match"] == null ? null : Match.fromJson(json["match"]),
  );

  Map<String, dynamic> toJson() => {
    "all other player data..": allOtherPlayerData?.toIso8601String(),
    "match": match?.toJson(),
  };
}

class Match {
  final String? last;
  final String? upcoming;
  final Highlights? highlights;

  Match({this.last, this.upcoming, this.highlights});

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    last: json["last"],
    upcoming: json["upcoming"],
    highlights: json["highlights"] == null ? null : Highlights.fromJson(json["highlights"]),
  );

  Map<String, dynamic> toJson() => {"last": last, "upcoming": upcoming, "highlights": highlights?.toJson()};
}

class Highlights {
  Highlights();

  factory Highlights.fromJson(Map<String, dynamic> json) => Highlights();

  Map<String, dynamic> toJson() => {};
}

class MetadataPlayer {
  final DateTime? allOtherPlayerData;

  MetadataPlayer({this.allOtherPlayerData});

  factory MetadataPlayer.fromJson(Map<String, dynamic> json) => MetadataPlayer(
    allOtherPlayerData:
        json["all other player data.."] == null ? null : DateTime.parse(json["all other player data.."]),
  );

  Map<String, dynamic> toJson() => {"all other player data..": allOtherPlayerData?.toIso8601String()};
}

class PlayerInfo {
  final String? playerId;
  final String? name;
  final SnapshotBio? snapshotBio;

  PlayerInfo({this.playerId, this.name, this.snapshotBio});

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => PlayerInfo(
    playerId: json["playerId"],
    name: json["name"],
    snapshotBio: json["snapshotBio"] == null ? null : SnapshotBio.fromJson(json["snapshotBio"]),
  );

  Map<String, dynamic> toJson() => {"playerId": playerId, "name": name, "snapshotBio": snapshotBio?.toJson()};
}

class SnapshotBio {
  final String? position;
  final int? age;
  final int? height;
  final int? weight;
  final int? games;
  final int? goals;
  final int? assists;

  SnapshotBio({this.position, this.age, this.height, this.weight, this.games, this.goals, this.assists});

  factory SnapshotBio.fromJson(Map<String, dynamic> json) => SnapshotBio(
    position: json["position"],
    age: json["age"],
    height: json["height"],
    weight: json["weight"],
    games: json["games"],
    goals: json["goals"],
    assists: json["assists"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "age": age,
    "height": height,
    "weight": weight,
    "games": games,
    "goals": goals,
    "assists": assists,
  };
}

class Transaction {
  final Buyer? seller;
  final Buyer? buyer;
  final DateTime? timestamp;
  final String? type;
  final double? price;
  final double? priceDelta;

  Transaction({this.seller, this.buyer, this.timestamp, this.type, this.price, this.priceDelta});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    seller: json["seller"] == null ? null : Buyer.fromJson(json["seller"]),
    buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    type: json["type"],
    price: json["price"]?.toDouble(),
    priceDelta: json["priceDelta"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "seller": seller?.toJson(),
    "buyer": buyer?.toJson(),
    "timestamp": timestamp?.toIso8601String(),
    "type": type,
    "price": price,
    "priceDelta": priceDelta,
  };
}

class Buyer {
  final String? id;
  final String? name;
  final String? icon;

  Buyer({this.id, this.name, this.icon});

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(id: json["ID"], name: json["Name"], icon: json["icon"]);

  Map<String, dynamic> toJson() => {"ID": id, "Name": name, "icon": icon};
}
