import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/buy_player_card/buy_payment_succesful_screen.dart';

class BuyConfirmationScreen extends StatefulWidget {
  const BuyConfirmationScreen({super.key, required this.player});

  final PlayerModel player;

  @override
  State<BuyConfirmationScreen> createState() => _BuyConfirmationScreenState();
}

class _BuyConfirmationScreenState extends State<BuyConfirmationScreen> {
  late PlayerModel player;
  String paymentMethod = "wallet";
  @override
  void initState() {
    super.initState();
    player = widget.player;
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
          "Buy Player Card",
          style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
        ),
        centerTitle: true,
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: ConstColors.baseColorDark3,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(player.image)),
                  border: Border.all(color: getCardClassBorderColor(player.cardClass), width: 2),
                ),
              ),
              Gap(16),
              Text(player.name, style: TextStyle(fontFamily: poppinsMedium, fontSize: 20, color: ConstColors.light)),
              Gap(6),
              Text(
                player.club,
                style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
              ),
              Gap(30),
              OrderSummarySection(player: player),
              Gap(30),
              PaymentMethodSection(),
            ],
          ),
        ),
      ),

      // BOTTOM NAV
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GoldGradientButton(
                  height: 40,
                  text: "Confirm & Pay",
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BuyPaymentSuccesfulScreen(player: player)),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getCardClassBorderColor(String cardClass) {
    switch (cardClass) {
      case 'S':
        return Color(0xFFEDC967);

      case 'A':
        return Color(0xFFEEF1F4);

      case 'B':
        return Color(0xFF8E9399);

      case 'C':
      default:
        return Color(0xFF6E4B2A);
    }
  }
}

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String paymentMethod = "wallet";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method", style: TextStyle(fontFamily: poppinsMedium, fontSize: 16, color: ConstColors.light)),
        Gap(12),
        Column(
          children: [
            _buildPaymentMethodTile(
              icon: IconPaths.general.wallet,
              title: "My Wallet",
              subtitle: Row(
                children: [
                  Text(
                    "Your Balance",
                    style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.darkGray),
                  ),
                  Gap(4),
                  Text(
                    "EUR 1058.70",
                    style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.goldGradient4),
                  ),
                ],
              ),
              isChoosen: paymentMethod == "wallet",
              onTap: () {
                paymentMethod = "wallet";
                setState(() {});
              },
            ),
            Gap(12),
            _buildPaymentMethodTile(
              icon: IconPaths.general.bank,
              title: "Transfer Bank",
              subtitle: Text(
                "Deposit from your bank account",
                style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.darkGray),
              ),
              isChoosen: paymentMethod == "transfer",
              onTap: () {
                paymentMethod = "transfer";
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile({
    required String icon,
    required String title,
    required Widget subtitle,
    required bool isChoosen,
    Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      dense: true,
      minLeadingWidth: 0,
      horizontalTitleGap: 12,
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: ConstColors.baseColorDark5),
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFFAE8625).withValues(alpha: .1),
              Color(0xFFF7EF8A).withValues(alpha: .1),
              Color(0xFFD2AC47).withValues(alpha: .1),
              Color(0xFFEDC967).withValues(alpha: .1),
            ],
          ),
        ),
        child: Center(child: Image.asset(icon, width: 20, height: 20)),
      ),
      title: Text(title, style: TextStyle(fontFamily: poppinsRegular, fontSize: 14, color: ConstColors.light)),
      subtitle: subtitle,
      trailing: Stack(
        children: [
          Checkbox(
            shape: CircleBorder(),
            fillColor: WidgetStatePropertyAll(isChoosen ? ConstColors.gold : Colors.transparent),
            checkColor: ConstColors.baseColorDark,
            value: isChoosen,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key, required this.player});

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order Summary", style: TextStyle(fontFamily: poppinsMedium, fontSize: 16, color: ConstColors.light)),
        Gap(12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ConstColors.baseColorDark5),
          ),
          child: Column(
            children: [
              _summaryTile("Price", "EUR ${player.price.toStringAsFixed(2)}"),
              _summaryTile("Tax", "EUR ${(player.price * 0.1).floor()}"),
              _summaryTile("Platform Fee", "EUR ${(player.price * 0.05).floor()}"),
              Gap(6),
              Container(width: double.infinity, height: 1, color: ConstColors.baseColorDark5),
              Gap(16),
              _summaryTile(
                "Total Payment",
                "EUR ${(player.price + (player.price * 0.1).floor() + (player.price * 0.05).floor()).toStringAsFixed(2)}",
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _summaryTile(String title, String value, {bool isTotal = false}) {
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
            style: TextStyle(fontFamily: poppinsRegular, fontSize: isTotal ? 14 : 12, color: ConstColors.light),
          ),
        ],
      ),
    );
  }
}
