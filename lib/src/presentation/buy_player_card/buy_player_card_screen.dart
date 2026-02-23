import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/card_model.dart';
import 'package:kick26/src/presentation/buy_player_card/buy_confirmation_screen.dart';
import 'package:kick26/src/presentation/buy_player_card/instant_purchase_screen.dart';

class BuyPlayerCardScreen extends StatefulWidget {
  const BuyPlayerCardScreen({super.key, required this.card});

  final CardModel card;

  @override
  State<BuyPlayerCardScreen> createState() => _BuyPlayerCardScreenState();
}

class _BuyPlayerCardScreenState extends State<BuyPlayerCardScreen> {
  late CardModel card;
  String paymentMethod = "wallet";
  @override
  void initState() {
    super.initState();
    card = widget.card;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ConstColors.baseColorDark,

        // APP BAR
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 72,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ConstColors.baseColorDark5)),
              child: Center(child: GoldGradient(child: const Icon(Icons.chevron_left, size: 28))),
            ),
          ),
          title: Column(
            children: [
              Text(
                "Buy Player Card",
                style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 16),
              ),
              Text(
                "Real-time market & ownership",
                style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 12),
              ),
            ],
          ),
          centerTitle: true,
        ),

        // BODY
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // HEADER
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ConstColors.baseColorDark3),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: ConstColors.baseColorDark3,
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(card.media.images?.playerProfile ?? "")),
                          ),
                        ),
                        Positioned(bottom: 0, right: 0, child: CardClassWidget(cardClass: card.data.cardClass ?? "")),
                      ],
                    ),
                    Gap(8),
                    SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.player.name ?? "",
                            style: TextStyle(
                              color: ConstColors.light,
                              fontFamily: poppinsMedium,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gap(4),
                          Text(
                            "Limited \u00B7 40 cards total",
                            style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Gap(8),
                    Container(height: 43, width: 1, color: ConstColors.baseColorDark5),
                    Gap(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Available 12/40",
                          style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 10),
                        ),
                        Gap(4),
                        GoldGradient(
                          child: Text(
                            "€${card.market.currentPrice?.toStringAsFixed(2)}",
                            style: TextStyle(fontFamily: poppinsRegular, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(12),

              // TAB BAR
              Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ConstColors.baseColorDark3),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
                  labelPadding: EdgeInsets.symmetric(horizontal: 2),
                  labelColor: ConstColors.gold,
                  unselectedLabelColor: ConstColors.gray10,
                  labelStyle: TextStyle(fontFamily: poppinsSemiBold, fontSize: 12),

                  tabs: const [Tab(text: 'Live Price'), Tab(text: 'Bid (Owners)'), Tab(text: 'Limit Order')],
                ),
              ),

              Gap(12),

              // MAIN TAB BAR VIEW
              Expanded(
                child: TabBarView(
                  children: [
                    _buildLivePriceTab(),
                    _buildBidOwners(),
                    ListView(
                      children: [
                        Text(
                          "Order Book",
                          style: TextStyle(color: ConstColors.gray10, fontFamily: poppinsMedium, fontSize: 12),
                        ),
                        Gap(14),
                        Image.asset("assets/images/limit_order.png"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBidOwners() {
    List<Map<String, dynamic>> owners = [
      {"name": "Lucas Moreau", "last_active": "12m", "number_card": "08", "photo": ImagePaths.profile.profileImage},
      {"name": "Matteo Ricci", "last_active": "5m", "number_card": "14", "photo": ""},
      {"name": "Julien Dubois", "last_active": "1h", "number_card": "03", "photo": ""},
      {"name": "Marco Bianchi", "last_active": "30m", "number_card": "21", "photo": ""},
      {"name": "Daniel Schneider", "last_active": "2h", "number_card": "17", "photo": ""},
      {"name": "Alejandro Gómez", "last_active": "45m", "number_card": "05", "photo": ""},
      {"name": "Lukas Weber", "last_active": "3h", "number_card": "09", "photo": ""},
      {"name": "Antoine Lefèvre", "last_active": "8m", "number_card": "01", "photo": ImagePaths.profile.profileImage2},
      {"name": "Tomáš Novák", "last_active": "20m", "number_card": "12", "photo": ""},
      {"name": "Oliver Müller", "last_active": "6h", "number_card": "19", "photo": ""},
    ];
    return ListView(
      children: [
        Text(
          "Current owners in owners biding",
          style: TextStyle(color: ConstColors.gray10, fontFamily: poppinsMedium, fontSize: 12),
        ),
        Gap(12),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder:
              (context, index) => Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(color: Color(0xff2B2B2B), shape: BoxShape.circle),
                      child:
                          owners[index]['photo'] == ""
                              ? Center(child: Icon(Icons.person, size: 28, color: Color(0xff5C5C5C)))
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(owners[index]['photo'], fit: BoxFit.cover),
                              ),
                    ),
                    Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          owners[index]['name'],
                          style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium),
                        ),
                        Gap(4),
                        Text(
                          "Last active ${owners[index]['last_active']}",
                          style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 10),
                        ),
                        Gap(4),
                        Row(
                          children: [
                            Text(
                              "Number card: ",
                              style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 10),
                            ),
                            Text(
                              owners[index]['number_card'],
                              style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GoldGradient(
                            child: Text(
                              card.market.currentPrice?.toStringAsFixed(2) ?? "",
                              style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 12),
                            ),
                          ),
                          Gap(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                (card.market.isUp ?? false) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                                size: 14,
                              ),
                              Text(
                                "(${(card.market.isUp ?? false) ? "+" : ""}${card.market.trend?.toStringAsFixed(2)})",
                                style: TextStyle(
                                  color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                                  fontFamily: poppinsRegular,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Gap(4),
                          GoldGradientButton(
                            height: 33,
                            width: 66,
                            padding: EdgeInsets.zero,
                            textStyle: TextStyle(color: Colors.black, fontFamily: poppinsMedium, fontSize: 10),
                            text: "Bid",
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BuyConfirmationScreen(player: player),
                              //   ),
                              // );
                            },
                          ),
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

  Widget _buildLivePriceTab() {
    return Column(
      children: [
        DefaultTabController(
          length: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "€${card.market.currentPrice?.toStringAsFixed(2)}",
                        style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 16),
                      ),
                      Gap(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            (card.market.isUp ?? false) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                            color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                            size: 20,
                          ),
                          Text(
                            "(${(card.market.isUp ?? false) ? "+" : ""}${card.market.trend?.toStringAsFixed(2)})",
                            style: TextStyle(
                              color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                              fontFamily: poppinsRegular,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(50),
                  Expanded(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ConstColors.baseColorDark3),
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: ConstColors.baseColorDark3,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 2),
                        labelColor: ConstColors.gold,
                        unselectedLabelColor: ConstColors.gray10,
                        labelStyle: TextStyle(fontFamily: poppinsSemiBold, fontSize: 12),

                        tabs: const [
                          Tab(text: '1H'),
                          Tab(text: '24H'),
                          Tab(text: '7D'),
                          Tab(text: '30D'),
                          Tab(text: 'All'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 86,
                child: TabBarView(
                  children: [
                    Image.asset("assets/images/live_price_1h.png"),
                    Image.asset("assets/images/live_price_24h.png"),
                    Image.asset("assets/images/live_price_7d.png"),
                    Image.asset("assets/images/live_price_30d.png"),
                    Image.asset("assets/images/live_price_all.png"),
                  ],
                ),
              ),
            ],
          ),
        ),

        Gap(12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ConstColors.baseColorDark3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Best Available Price",
                style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 12),
              ),
              Gap(8),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(card.media.images?.playerProfile ?? "")),
                    ),
                  ),
                  Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.player.name ?? "",
                        style: TextStyle(
                          color: ConstColors.light,
                          fontFamily: poppinsMedium,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gap(4),
                      Text(
                        "${card.data.sequenceNumber}/${card.data.totalIssued}",
                        style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 10),
                      ),
                    ],
                  ),
                  Gap(20),
                  Spacer(),
                  GoldGradient(
                    child: Text(
                      "€${card.market.currentPrice?.toStringAsFixed(2)}",
                      style: TextStyle(fontFamily: poppinsRegular, fontSize: 12),
                    ),
                  ),
                ],
              ),
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Quantity :",
                    style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 12),
                  ),
                  Text("1", style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 12)),
                ],
              ),
              Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax(10%) :",
                    style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 12),
                  ),
                  Text(
                    "€${((card.market.currentPrice ?? 0) * 0.1).toStringAsFixed(2)}",
                    style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 12),
                  ),
                ],
              ),
              Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Admin Fee :",
                    style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 12),
                  ),
                  Text(
                    "€${((card.market.currentPrice ?? 0) * 0.05).toStringAsFixed(2)}",
                    style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 12),
                  ),
                ],
              ),
              Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estimated Total :",
                    style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 14),
                  ),
                  Text(
                    "€${((card.market.currentPrice ?? 0) + ((card.market.currentPrice ?? 0) * 0.1).floor() + ((card.market.currentPrice ?? 0) * 0.05).floor()).toStringAsFixed(2)}",
                    style: TextStyle(color: ConstColors.light, fontFamily: poppinsMedium, fontSize: 14),
                  ),
                ],
              ),
              Gap(16),
              GoldGradientButton(
                height: 48,
                text: "Buy Instantly",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InstantPurchaseScreen(card: card)));
                },
              ),
              Gap(8),
              Text(
                "Executed at best availabe market price",
                style: TextStyle(color: ConstColors.darkGray, fontFamily: poppinsRegular, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
