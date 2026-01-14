import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/player_card_widget.dart';
import 'package:kick26/src/data/models/player_model.dart';

class SellPlayerCardScreen extends StatefulWidget {
  const SellPlayerCardScreen({super.key, required this.player});

  final PlayerModel player;

  @override
  State<SellPlayerCardScreen> createState() => _SellPlayerCardScreenState();
}

class _SellPlayerCardScreenState extends State<SellPlayerCardScreen> {
  late PlayerModel player;
  String payoutMethod = "wallet";
  late int selectedPrice;
  late double sellPrice;

  @override
  void initState() {
    super.initState();
    player = widget.player;
    selectedPrice = 3;
    sellPrice = player.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Sell Player Card",
          style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
        ),
        centerTitle: true,
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
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
                            image: DecorationImage(image: AssetImage(player.image)),
                          ),
                        ),
                        Positioned(bottom: 0, right: 0, child: CardClassWidget(cardClass: player.cardClass)),
                      ],
                    ),
                    Gap(8),
                    SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.name,
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
                            "€${player.price.toStringAsFixed(2)}",
                            style: TextStyle(fontFamily: poppinsRegular, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(12),
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ConstColors.baseColorDark3),
                ),
                child: Center(
                  child: GoldGradient(
                    child: Text("Summary", style: TextStyle(fontSize: 12, fontFamily: poppinsRegular)),
                  ),
                ),
              ),

              Gap(16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayerCardWidget(player: player),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SummaryCardWidget(title: "Price", player: player),
                          Gap(4),
                          SummaryCardWidget(title: "Average", subtitle: "Refreshed Now", player: player),
                        ],
                      ),
                      Gap(4),

                      Row(
                        children: [
                          SummaryCardWidget(title: "Recent", subtitle: "2h ago", player: player),
                          Gap(4),
                          SummaryCardWidget(title: "Your Activity", subtitle: "Bought For", player: player),
                        ],
                      ),
                      Gap(4),

                      Row(
                        children: [
                          SummaryCardWidget(
                            title: "Rarity Serial",
                            content: "1/40",
                            subtitle: "(#1 Mint)",
                            player: player,
                          ),
                          Gap(4),
                          SummaryCardWidget(
                            title: "Rarity Serial",
                            content: "1/40",
                            subtitle: "(#1 Mint)",
                            player: player,
                          ),
                        ],
                      ),
                      Gap(4),
                    ],
                  ),
                ],
              ),
              Gap(16),

              // SELL PRICE
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ConstColors.baseColorDark3),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sell Price",
                          style: TextStyle(fontSize: 10, fontFamily: poppinsRegular, color: ConstColors.gray10),
                        ),
                        GoldGradient(
                          child: Text(
                            "€${sellPrice.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 10, fontFamily: poppinsRegular, color: ConstColors.gray10),
                          ),
                        ),
                      ],
                    ),
                    Gap(4),
                    Container(width: double.infinity, height: 1, color: ConstColors.baseColorDark5),
                    Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SellPriceWidget(
                          isSelected: selectedPrice == 1,
                          price: (player.price - player.price * .5).toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 1;
                            sellPrice = player.price - player.price * .5;
                            setState(() {});
                          },
                        ),
                        SellPriceWidget(
                          isSelected: selectedPrice == 2,
                          price: (player.price - player.price * .25).toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 2;
                            sellPrice = player.price - player.price * .25;
                            setState(() {});
                          },
                        ),
                        SellPriceWidget(
                          isSelected: selectedPrice == 3,
                          price: (player.price).toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 3;
                            setState(() {});
                          },
                        ),
                        SellPriceWidget(
                          isSelected: selectedPrice == 4,
                          price: (player.price + player.price * .15).toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 4;
                            sellPrice = player.price + player.price * .15;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(20),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
                  children: [
                    const TextSpan(text: "Estimated Payout: "),
                    TextSpan(text: sellPrice.toStringAsFixed(2), style: TextStyle(color: ConstColors.gold)),
                  ],
                ),
              ),
              Gap(6),
              Text(
                "2% Platform Fee: -€${(sellPrice * 2 / 100).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 10, fontFamily: poppinsRegular, color: ConstColors.gray10),
              ),

              Gap(50),

              // BUTTON CONFRIM LISTING
              GoldGradientButton(height: 48, text: "Confrim Listing", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class SellPriceWidget extends StatelessWidget {
  const SellPriceWidget({super.key, required this.isSelected, required this.price, required this.onTap});

  final bool isSelected;
  final String price;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          isSelected
              ? GoldGradientBorder(
                backgroundColor: ConstColors.baseColorDark3,
                borderRadius: 6,
                borderWidth: 1,
                padding: EdgeInsets.all(4),
                child: Center(
                  child: GoldGradient(
                    child: Text(
                      "€$price",
                      style: TextStyle(color: ConstColors.gray10, fontSize: 12, fontFamily: poppinsRegular),
                    ),
                  ),
                ),
              )
              : Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: ConstColors.baseColorDark5, width: 1),
                ),
                child: Center(
                  child: Text(
                    "€$price",
                    style: TextStyle(color: ConstColors.gray10, fontSize: 12, fontFamily: poppinsRegular),
                  ),
                ),
              ),
    );
  }
}

class SummaryCardWidget extends StatelessWidget {
  const SummaryCardWidget({super.key, required this.title, this.subtitle, this.content, required this.player});

  final String title;
  final String? subtitle;
  final String? content;
  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      constraints: BoxConstraints(minWidth: 78),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ConstColors.baseColorDark3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 10, fontFamily: poppinsRegular, color: ConstColors.gray10)),
          GoldGradient(
            child: Text(
              content ?? "€${player.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 12, fontFamily: poppinsRegular),
            ),
          ),
          Gap(4),
          subtitle != null
              ? Text(subtitle!, style: TextStyle(fontSize: 8, fontFamily: poppinsRegular, color: ConstColors.gray10))
              : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    player.isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: player.isUp ? ConstColors.green : ConstColors.orange,
                    size: 10,
                  ),
                  Text(
                    "(${player.isUp ? "+" : ""}${player.trend.toStringAsFixed(2)})",
                    style: TextStyle(
                      color: player.isUp ? ConstColors.green : ConstColors.orange,
                      fontFamily: poppinsRegular,
                      fontSize: 8,
                    ),
                  ),
                  Text(" (24h)", style: TextStyle(fontSize: 8, fontFamily: poppinsRegular, color: ConstColors.gray10)),
                ],
              ),
        ],
      ),
    );
  }
}
