import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/player_card_widget.dart';
import 'package:kick26/src/data/models/card_model.dart';
import 'package:kick26/src/presentation/bottom_navigation/bottom_navigation.dart';

class BuyPaymentSuccesfulScreen extends StatefulWidget {
  const BuyPaymentSuccesfulScreen({super.key, required this.card});
  final CardModel card;

  @override
  State<BuyPaymentSuccesfulScreen> createState() => _BuyPaymentSuccesfulScreenState();
}

class _BuyPaymentSuccesfulScreenState extends State<BuyPaymentSuccesfulScreen> {
  late CardModel card;
  @override
  void initState() {
    super.initState();
    card = widget.card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,

      // BODY
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GoldGradient(child: Icon(Icons.check_circle_outline_outlined, size: 44)),

              Gap(10),

              GoldGradient(
                child: Text(
                  "Card Purchased!",
                  style: TextStyle(fontFamily: poppinsMedium, fontSize: 20, color: ConstColors.light),
                ),
              ),

              Gap(4),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
                    children: [
                      TextSpan(text: card.player.name, style: TextStyle(color: ConstColors.light)),
                      TextSpan(text: " 1/40 ", style: TextStyle(color: ConstColors.light)),
                      const TextSpan(text: "card successfully bought for "),
                      TextSpan(
                        text: "€${card.market.currentPrice?.toStringAsFixed(2)}",
                        style: TextStyle(color: ConstColors.gold),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(30),

              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ConstColors.baseColorDark2,
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Color(0xffFFD24C).withValues(alpha: 0.1), ConstColors.baseColorDark],
                        ),
                      ),
                    ),
                    Center(child: PlayerCardWidget(card: card)),
                  ],
                ),
              ),

              Gap(30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
                    children: [
                      const TextSpan(text: "Balance Updated"),
                      TextSpan(text: " €43.520", style: TextStyle(color: ConstColors.gold)),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),
              ),
              Gap(4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
                    children: [const TextSpan(text: "Your card is now in your collection")],
                  ),
                ),
              ),

              Gap(30),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GoldGradientButton(height: 48, text: "View In My Cards", onTap: () => navigateToTab(context, 2)),
                  Gap(8),
                  GestureDetector(
                    onTap: () => navigateToTab(context, 0),
                    child: SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: GoldGradientBorder(
                        borderRadius: 10,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: GoldGradient(child: Text("Done", style: TextStyle(fontFamily: poppinsMedium))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToTab(BuildContext context, int index) {
    Navigator.of(
      context,
    ).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => BottomNavigation(initialIndex: index)), (route) => false);
  }
}
