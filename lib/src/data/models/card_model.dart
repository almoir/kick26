class CardModel {
  final String? id;
  final CardModelCard? card;
  final CardModelPlayer? player;
  final CardModelClub? club;
  final Media? media;
  final Market? market;
  final List<Transaction>? transactions;
  final Metadata? metadata;

  CardModel({this.id, this.card, this.player, this.club, this.media, this.market, this.transactions, this.metadata});

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json["id"],
    card: json["card"] == null ? null : CardModelCard.fromJson(json["card"]),
    player: json["player"] == null ? null : CardModelPlayer.fromJson(json["player"]),
    club: json["club"] == null ? null : CardModelClub.fromJson(json["club"]),
    media: json["media"] == null ? null : Media.fromJson(json["media"]),
    market: json["market"] == null ? null : Market.fromJson(json["market"]),
    transactions:
        json["transactions"] == null
            ? []
            : List<Transaction>.from(json["transactions"]!.map((x) => Transaction.fromJson(x))),
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "card": card?.toJson(),
    "player": player?.toJson(),
    "club": club?.toJson(),
    "media": media?.toJson(),
    "market": market?.toJson(),
    "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x.toJson())),
    "metadata": metadata?.toJson(),
  };
}

class CardModelCard {
  final String? edition;
  final int? totalIssued;
  final int? sequenceNumber;
  final String? type;
  final String? cardClass;
  final DateTime? issuedAt;
  final String? issuerId;
  final String? issuerName;
  final String? approverId;
  final String? approverName;
  final int? owned;

  CardModelCard({
    this.edition,
    this.totalIssued,
    this.sequenceNumber,
    this.type,
    this.cardClass,
    this.issuedAt,
    this.issuerId,
    this.issuerName,
    this.approverId,
    this.approverName,
    this.owned,
  });

  factory CardModelCard.fromJson(Map<String, dynamic> json) => CardModelCard(
    edition: json["edition"],
    totalIssued: json["totalIssued"],
    sequenceNumber: json["sequenceNumber"],
    type: json["type"],
    cardClass: json["class"],
    issuedAt: json["issuedAt"] == null ? null : DateTime.parse(json["issuedAt"]),
    issuerId: json["issuerId"],
    issuerName: json["issuerName"],
    approverId: json["approverId"],
    approverName: json["approverName"],
    owned: json["owned"],
  );

  Map<String, dynamic> toJson() => {
    "edition": edition,
    "totalIssued": totalIssued,
    "sequenceNumber": sequenceNumber,
    "type": type,
    "class": cardClass,
    "issuedAt": issuedAt?.toIso8601String(),
    "issuerId": issuerId,
    "issuerName": issuerName,
    "approverId": approverId,
    "approverName": approverName,
    "owned": owned,
  };
}

class CardModelClub {
  final String? id;
  final String? name;
  final String? country;
  final String? city;

  CardModelClub({this.id, this.name, this.country, this.city});

  factory CardModelClub.fromJson(Map<String, dynamic> json) =>
      CardModelClub(id: json["id"], name: json["name"], country: json["country"], city: json["city"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "country": country, "city": city};
}

class Market {
  final int? currentPrice;
  final double? lastTransactionPrice;
  final int? low;
  final int? high;
  final String? currency;
  final double? trend;
  final bool? isUp;
  final int? floorPrice;
  final double? highestBid;
  final int? totalTrades;
  final int? uniqueOwners;
  final bool? isOnMarket;
  final bool? isTradable;
  final bool? isBidEnabled;
  final DateTime? lastTradedAt;

  Market({
    this.currentPrice,
    this.lastTransactionPrice,
    this.low,
    this.high,
    this.currency,
    this.trend,
    this.isUp,
    this.floorPrice,
    this.highestBid,
    this.totalTrades,
    this.uniqueOwners,
    this.isOnMarket,
    this.isTradable,
    this.isBidEnabled,
    this.lastTradedAt,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
    currentPrice: json["currentPrice"],
    lastTransactionPrice: json["lastTransactionPrice"]?.toDouble(),
    low: json["low"],
    high: json["high"],
    currency: json["currency"],
    trend: json["trend"]?.toDouble(),
    isUp: json["isUp"],
    floorPrice: json["floorPrice"],
    highestBid: json["highestBid"]?.toDouble(),
    totalTrades: json["totalTrades"],
    uniqueOwners: json["uniqueOwners"],
    isOnMarket: json["isOnMarket"],
    isTradable: json["isTradable"],
    isBidEnabled: json["isBidEnabled"],
    lastTradedAt: json["lastTradedAt"] == null ? null : DateTime.parse(json["lastTradedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "currentPrice": currentPrice,
    "lastTransactionPrice": lastTransactionPrice,
    "low": low,
    "high": high,
    "currency": currency,
    "trend": trend,
    "isUp": isUp,
    "floorPrice": floorPrice,
    "highestBid": highestBid,
    "totalTrades": totalTrades,
    "uniqueOwners": uniqueOwners,
    "isOnMarket": isOnMarket,
    "isTradable": isTradable,
    "isBidEnabled": isBidEnabled,
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
  final String? playerCard;
  final String? clubImage;
  final String? clubLogo;

  Images({this.playerProfile, this.playerCard, this.clubImage, this.clubLogo});

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    playerProfile: json["playerProfile"],
    playerCard: json["playerCard"],
    clubImage: json["clubImage"],
    clubLogo: json["clubLogo"],
  );

  Map<String, dynamic> toJson() => {
    "playerProfile": playerProfile,
    "playerCard": playerCard,
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
  final DateTime? lastUpdated;
  final Match? match;

  MetadataClub({this.lastUpdated, this.match});

  factory MetadataClub.fromJson(Map<String, dynamic> json) => MetadataClub(
    lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]),
    match: json["match"] == null ? null : Match.fromJson(json["match"]),
  );

  Map<String, dynamic> toJson() => {"lastUpdated": lastUpdated?.toIso8601String(), "match": match?.toJson()};
}

class Match {
  final String? last;
  final String? upcoming;
  final dynamic highlights;

  Match({this.last, this.upcoming, this.highlights});

  factory Match.fromJson(Map<String, dynamic> json) =>
      Match(last: json["last"], upcoming: json["upcoming"], highlights: json["highlights"]);

  Map<String, dynamic> toJson() => {"last": last, "upcoming": upcoming, "highlights": highlights};
}

class MetadataPlayer {
  final DateTime? lastUpdated;

  MetadataPlayer({this.lastUpdated});

  factory MetadataPlayer.fromJson(Map<String, dynamic> json) =>
      MetadataPlayer(lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]));

  Map<String, dynamic> toJson() => {"lastUpdated": lastUpdated?.toIso8601String()};
}

class CardModelPlayer {
  final String? playerId;
  final String? name;
  final String? countryCode;
  final SnapshotBio? snapshotBio;

  CardModelPlayer({this.playerId, this.name, this.countryCode, this.snapshotBio});

  factory CardModelPlayer.fromJson(Map<String, dynamic> json) => CardModelPlayer(
    playerId: json["playerId"],
    name: json["name"],
    countryCode: json["countryCode"],
    snapshotBio: json["snapshotBio"] == null ? null : SnapshotBio.fromJson(json["snapshotBio"]),
  );

  Map<String, dynamic> toJson() => {
    "playerId": playerId,
    "name": name,
    "countryCode": countryCode,
    "snapshotBio": snapshotBio?.toJson(),
  };
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
  final String? type;
  final DateTime? timestamp;
  final double? price;
  final double? priceDelta;
  final Buyer? seller;
  final Buyer? buyer;

  Transaction({this.type, this.timestamp, this.price, this.priceDelta, this.seller, this.buyer});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    type: json["type"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    price: json["price"]?.toDouble(),
    priceDelta: json["priceDelta"]?.toDouble(),
    seller: json["seller"] == null ? null : Buyer.fromJson(json["seller"]),
    buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "timestamp": timestamp?.toIso8601String(),
    "price": price,
    "priceDelta": priceDelta,
    "seller": seller?.toJson(),
    "buyer": buyer?.toJson(),
  };
}

class Buyer {
  final String? id;
  final String? name;
  final String? icon;

  Buyer({this.id, this.name, this.icon});

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(id: json["id"], name: json["name"], icon: json["icon"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "icon": icon};
}
