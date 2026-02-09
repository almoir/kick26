import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/card_class_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/player_card_widget.dart';
import 'package:kick26/src/data/models/card_model.dart';

class SellPlayerCardScreen extends StatefulWidget {
  const SellPlayerCardScreen({super.key, required this.card});

  final CardModel card;

  @override
  State<SellPlayerCardScreen> createState() => _SellPlayerCardScreenState();
}

class _SellPlayerCardScreenState extends State<SellPlayerCardScreen> {
  late CardModel card;
  String payoutMethod = "wallet";
  late int selectedPrice;
  late double sellPrice;

  @override
  void initState() {
    super.initState();
    card = widget.card;
    selectedPrice = 3;
    sellPrice = card.market.currentPrice ?? 0;
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
                            "Limited \u00B7 ${card.data.totalIssued ?? 0} cards total",
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
                  PlayerCardWidget(card: card),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SummaryCardWidget(title: "Price", card: card),
                          Gap(4),
                          SummaryCardWidget(title: "Average", subtitle: "Refreshed Now", card: card),
                        ],
                      ),
                      Gap(4),

                      Row(
                        children: [
                          SummaryCardWidget(title: "Recent", subtitle: "2h ago", card: card),
                          Gap(4),
                          SummaryCardWidget(title: "Your Activity", subtitle: "Bought For", card: card),
                        ],
                      ),
                      Gap(4),

                      Row(
                        children: [
                          SummaryCardWidget(title: "Rarity Serial", content: "1/40", subtitle: "(#1 Mint)", card: card),
                          Gap(4),
                          SummaryCardWidget(title: "Rarity Serial", content: "1/40", subtitle: "(#1 Mint)", card: card),
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
                          price: ((card.market.currentPrice ?? 0) - (card.market.currentPrice ?? 0) * .5)
                              .toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 1;
                            sellPrice = (card.market.currentPrice ?? 0) - (card.market.currentPrice ?? 0) * .5;
                            setState(() {});
                          },
                        ),
                        SellPriceWidget(
                          isSelected: selectedPrice == 2,
                          price: ((card.market.currentPrice ?? 0) - (card.market.currentPrice ?? 0) * .25)
                              .toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 2;
                            sellPrice = (card.market.currentPrice ?? 0) - (card.market.currentPrice ?? 0) * .25;
                            setState(() {});
                          },
                        ),
                        SellPriceWidget(
                          isSelected: selectedPrice == 3,
                          price: card.market.currentPrice?.toStringAsFixed(2) ?? "",
                          onTap: () {
                            selectedPrice = 3;
                            setState(() {});
                          },
                        ),
                        SellPriceWidget(
                          isSelected: selectedPrice == 4,
                          price: ((card.market.currentPrice ?? 0) + (card.market.currentPrice ?? 0) * .15)
                              .toStringAsFixed(2),
                          onTap: () {
                            selectedPrice = 4;
                            sellPrice = (card.market.currentPrice ?? 0) + (card.market.currentPrice ?? 0) * .15;
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
  const SummaryCardWidget({super.key, required this.title, this.subtitle, this.content, required this.card});

  final String title;
  final String? subtitle;
  final String? content;
  final CardModel card;

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
              content ?? "€${card.market.currentPrice?.toStringAsFixed(2) ?? 0}",
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
                    (card.market.isUp ?? false) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                    size: 10,
                  ),
                  Text(
                    "(${(card.market.isUp ?? false) ? "+" : ""}${card.market.trend?.toStringAsFixed(2) ?? 0})",
                    style: TextStyle(
                      color: (card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
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
