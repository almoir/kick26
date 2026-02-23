import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/player_card_widget.dart';
import 'package:kick26/src/data/models/card_model.dart';

class InstantPurchaseScreen extends StatefulWidget {
  const InstantPurchaseScreen({super.key, required this.card});

  final CardModel card;

  @override
  State<InstantPurchaseScreen> createState() => _InstantPurchaseScreenState();
}

class _InstantPurchaseScreenState extends State<InstantPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.baseColorDark,

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ConstColors.baseColorDark5),
                      ),
                      child: Center(child: GoldGradient(child: const Icon(Icons.chevron_left, size: 28))),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Instant Purchase",
                    style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark2,
                      gradient: RadialGradient(
                        colors: [Color(0xffFFD24C).withValues(alpha: 0.1), ConstColors.baseColorDark],
                      ),
                    ),
                  ),
                  Center(child: PlayerCardWidget(card: widget.card)),
                ],
              ),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.card.player.name ?? "",
                        style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(8),
                      GoldGradient(
                        child: Text(
                          "Only ${widget.card.data.totalIssued} Cards",
                          style: TextStyle(fontFamily: poppinsRegular, fontSize: 12),
                        ),
                      ),
                      Gap(12),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: ConstColors.lightGray),
                            ),
                            child: Text(
                              widget.card.player.snapshotBio?.position ?? "",
                              style: TextStyle(color: ConstColors.lightGray, fontFamily: poppinsRegular, fontSize: 10),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: ConstColors.lightGray),
                            ),
                            child: Text(
                              "${widget.card.player.snapshotBio?.age ?? 0} y.o",
                              style: TextStyle(color: ConstColors.lightGray, fontFamily: poppinsRegular, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: ConstColors.baseColorDark3,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ConstColors.baseColorDark5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Floor Price",
                            style: TextStyle(color: ConstColors.lightGray, fontFamily: poppinsRegular, fontSize: 10),
                          ),
                          Gap(4),
                          Text(
                            "€${widget.card.market.floorPrice?.toStringAsFixed(2) ?? "0.00"}",
                            style: TextStyle(color: ConstColors.white, fontFamily: poppinsRegular, fontSize: 10),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 36,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        color: ConstColors.baseColorDark5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "(24h)",
                                style: TextStyle(
                                  color: ConstColors.lightGray,
                                  fontFamily: poppinsRegular,
                                  fontSize: 10,
                                ),
                              ),
                              Icon(
                                (widget.card.market.isUp ?? false)
                                    ? Icons.arrow_drop_up_sharp
                                    : Icons.arrow_drop_down_sharp,

                                color: (widget.card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                                size: 12,
                              ),

                              Text(
                                "${widget.card.market.trend?.toStringAsFixed(2)}%",
                                style: TextStyle(
                                  color: (widget.card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                                  fontFamily: poppinsSemiBold,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                          Gap(4),
                          Text(
                            "€${widget.card.market.floorPrice?.toStringAsFixed(2) ?? "0.00"}",
                            style: TextStyle(
                              color: (widget.card.market.isUp ?? false) ? ConstColors.green : ConstColors.orange,
                              fontFamily: poppinsRegular,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
