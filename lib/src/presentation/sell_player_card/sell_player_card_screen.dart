import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/sell_player_card/sell_payment_succesful_screen.dart';

class SellPlayerCardScreen extends StatefulWidget {
  const SellPlayerCardScreen({super.key, required this.player});

  final PlayerModel player;

  @override
  State<SellPlayerCardScreen> createState() => _SellPlayerCardScreenState();
}

class _SellPlayerCardScreenState extends State<SellPlayerCardScreen> {
  late PlayerModel player;
  String payoutMethod = "wallet";

  @override
  void initState() {
    super.initState();
    player = widget.player;
  }

  @override
  Widget build(BuildContext context) {
    final double sellFee = player.price * 0.05;
    final double netReceived = player.price - sellFee;

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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // PLAYER IMAGE
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

              // PLAYER INFO
              Text(player.name, style: TextStyle(fontFamily: poppinsMedium, fontSize: 20, color: ConstColors.light)),
              Gap(6),
              Text(
                player.club,
                style: TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.darkGray),
              ),

              Gap(30),

              // SELL SUMMARY
              SellSummarySection(price: player.price, fee: sellFee, netReceived: netReceived),

              Gap(30),

              // PAYOUT METHOD
              PayoutMethodSection(
                payoutMethod: payoutMethod,
                onChanged: (value) {
                  setState(() {
                    payoutMethod = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),

      // BOTTOM CTA
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GoldGradientButton(
            height: 40,
            text: "Confirm & Sell",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SellPaymentSuccesfulScreen(player: player)),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
    );
  }

  Color getCardClassBorderColor(String cardClass) {
    switch (cardClass) {
      case 'S':
        return const Color(0xFFEDC967);
      case 'A':
        return const Color(0xFFEEF1F4);
      case 'B':
        return const Color(0xFF8E9399);
      case 'C':
      default:
        return const Color(0xFF6E4B2A);
    }
  }
}

class PayoutMethodSection extends StatelessWidget {
  const PayoutMethodSection({super.key, required this.payoutMethod, required this.onChanged});

  final String payoutMethod;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payout Method", style: TextStyle(fontFamily: poppinsMedium, fontSize: 16, color: ConstColors.light)),
        Gap(12),
        _methodTile(
          icon: IconPaths.general.wallet,
          title: "My Wallet",
          subtitle: "Receive instantly to wallet",
          value: "wallet",
        ),
        Gap(12),
        _methodTile(
          icon: IconPaths.general.bank,
          title: "Bank Account",
          subtitle: "Withdraw to your bank",
          value: "bank",
        ),
      ],
    );
  }

  Widget _methodTile({required String icon, required String title, required String subtitle, required String value}) {
    final bool isSelected = payoutMethod == value;

    return ListTile(
      onTap: () => onChanged(value),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: ConstColors.baseColorDark5),
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark3),
        child: Center(child: Image.asset(icon, width: 20, height: 20)),
      ),
      title: Text(title, style: TextStyle(fontFamily: poppinsRegular, fontSize: 14, color: ConstColors.light)),
      subtitle: Text(subtitle, style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.darkGray)),
      trailing: Checkbox(
        shape: const CircleBorder(),
        fillColor: WidgetStatePropertyAll(isSelected ? ConstColors.gold : Colors.transparent),
        checkColor: ConstColors.baseColorDark,
        value: isSelected,
        onChanged: (_) => onChanged(value),
      ),
    );
  }
}

class SellSummarySection extends StatelessWidget {
  const SellSummarySection({super.key, required this.price, required this.fee, required this.netReceived});

  final double price;
  final double fee;
  final double netReceived;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sell Summary", style: TextStyle(fontFamily: poppinsMedium, fontSize: 16, color: ConstColors.light)),
        Gap(12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ConstColors.baseColorDark5),
          ),
          child: Column(
            children: [
              _summaryTile("Sell Price", "EUR ${price.toStringAsFixed(2)}"),
              _summaryTile("Platform Fee", "- EUR ${fee.toStringAsFixed(2)}"),
              Gap(6),
              Container(width: double.infinity, height: 1, color: ConstColors.baseColorDark5),
              Gap(16),
              _summaryTile("Net Received", "EUR ${netReceived.toStringAsFixed(2)}", isTotal: true),
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
