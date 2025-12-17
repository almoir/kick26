import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/bottom_navigation/bottom_navigation.dart';

class BuyPaymentSuccesfulScreen extends StatefulWidget {
  const BuyPaymentSuccesfulScreen({super.key, required this.player});
  final PlayerModel player;

  @override
  State<BuyPaymentSuccesfulScreen> createState() => _BuyPaymentSuccesfulScreenState();
}

class _BuyPaymentSuccesfulScreenState extends State<BuyPaymentSuccesfulScreen> {
  late PlayerModel player;
  @override
  void initState() {
    super.initState();
    player = widget.player;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,

      // BODY
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark3),
                        child: Center(child: Image.asset(IconPaths.general.successPayment, width: 70, height: 70)),
                      ),

                      Gap(20),

                      Text(
                        "Payment Successful",
                        style: TextStyle(fontFamily: poppinsMedium, fontSize: 20, color: ConstColors.light),
                      ),

                      Gap(4),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
                            children: [
                              const TextSpan(text: "Your order for "),
                              TextSpan(text: player.name, style: TextStyle(color: ConstColors.light)),
                              const TextSpan(text: " has been successfully placed."),
                            ],
                          ),
                        ),
                      ),

                      Gap(40),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ConstColors.baseColorDark3,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Detail",
                              style: TextStyle(fontFamily: poppinsMedium, fontSize: 16, color: ConstColors.light),
                            ),

                            Gap(16),
                            _orderDetailTile("Order ID", "KICK26161225KLMBP70"),
                            _orderDetailTile(
                              "Execution Time",
                              DateFormat("h:mm a, MMMM d, yyyy").format(DateTime.now()),
                            ),
                            _orderDetailTile("Number Card", "17"),

                            Gap(6),
                            Divider(color: ConstColors.baseColorDark5),

                            Gap(16),
                            _orderDetailTile("Price", "EUR ${player.price.toStringAsFixed(2)}"),
                            _orderDetailTile("Tax", "EUR ${(player.price * 0.1).floor()}"),
                            _orderDetailTile("Platform Fee", "EUR ${(player.price * 0.05).floor()}"),

                            Gap(6),
                            Divider(color: ConstColors.baseColorDark5),

                            Gap(16),
                            _orderDetailTile(
                              "Total Payment",
                              "EUR ${(player.price + (player.price * 0.1).floor() + (player.price * 0.05).floor()).toStringAsFixed(2)}",
                              isTotal: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

      // BOTTOM NAV
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GoldGradientButton(height: 48, text: "Go to Portfolio", onTap: () => navigateToTab(context, 2)),
              Gap(8),
              GestureDetector(
                onTap: () => navigateToTab(context, 1),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: GoldGradientBorder(
                    borderRadius: 10,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: GoldGradient(child: Text("Buy More Cards", style: TextStyle(fontFamily: poppinsMedium))),
                    ),
                  ),
                ),
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

  Widget _orderDetailTile(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontFamily: poppinsRegular, fontSize: isTotal ? 14 : 12, color: ConstColors.darkGray),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: poppinsRegular,
              fontSize: isTotal ? 14 : 12,
              color: isTotal ? ConstColors.goldGradient4 : ConstColors.light,
            ),
          ),
        ],
      ),
    );
  }
}
