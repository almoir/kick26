import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/common/dummy.dart';
import 'package:kick24/src/common/fonts_family.dart';
import 'package:kick24/src/common/image_paths.dart';
import 'package:kick24/src/common/widgets/gold_gradient.dart';
import 'package:kick24/src/presentation/portfolio_detail/portfolio_detail_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String choosenMenu = 'Last 7 Days';
  final List<Map<String, dynamic>> _players = dummyPlayers.reversed.toList();

  @override
  void initState() {
    super.initState();
    // Simulasikan perubahan harga tiap beberapa detik
    _simulatePriceChange();
  }

  void _simulatePriceChange() async {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        for (var player in _players) {
          final isUp = Random().nextBool();
          final newPrice =
              (double.tryParse(
                    player['price'].replaceAll('€', '').replaceAll(',', ''),
                  ) ??
                  1000) +
              (isUp ? Random().nextDouble() * 10 : -Random().nextDouble() * 10);
          player['price'] = '€${newPrice.toStringAsFixed(2)}';
          player['isUp'] = isUp;
          player['trend'] =
              '${isUp ? '+' : '-'}${(Random().nextDouble() * 2).toStringAsFixed(2)}%';
          player['flashColor'] =
              isUp
                  ? ConstColors.goldGradient2.withValues(alpha: 0.3)
                  : ConstColors.orange.withValues(alpha: 0.3);
        }
      });
      _simulatePriceChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 TabBar (filter)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ConstColors.goldGradient2),
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorAnimation: TabIndicatorAnimation.linear,
                  indicatorWeight: 1,
                  tabAlignment: TabAlignment.start,
                  labelStyle: const TextStyle(
                    fontFamily: poppinsRegular,
                    color: ConstColors.goldGradient2,
                    fontSize: 12,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: poppinsRegular,
                    color: ConstColors.gray10,
                    fontSize: 12,
                  ),
                  tabs: const [
                    Tab(text: "Last 7 Days"),
                    Tab(text: "Weekly"),
                    Tab(text: "Monthly"),
                    Tab(text: "Yearly"),
                  ],
                ),
              ),

              /// 🔹 Portfolio summary
              // SizedBox(
              //   height: 320,
              //   child: TabBarView(
              //     children: [
              //       Container(
              //         padding: const EdgeInsets.all(20),
              //         margin: const EdgeInsets.all(16),
              //         decoration: BoxDecoration(
              //           color: ConstColors.baseColorDark2,
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: const Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       "Total Portfolio",
              //                       style: TextStyle(
              //                         fontFamily: poppinsRegular,
              //                         color: Colors.white,
              //                       ),
              //                     ),
              //                     SizedBox(height: 4),
              //                     Text(
              //                       "12 May - 17 May 2025",
              //                       style: TextStyle(
              //                         fontFamily: poppinsLight,
              //                         fontSize: 10,
              //                         color: ConstColors.lightGray,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 Icon(Icons.more_horiz,
              //                     color: ConstColors.goldGradient2)
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //       const Center(
              //           child: Text("Weekly",
              //               style: TextStyle(color: Colors.white))),
              //       const Center(
              //           child: Text("Monthly",
              //               style: TextStyle(color: Colors.white))),
              //       const Center(
              //           child: Text("Yearly",
              //               style: TextStyle(color: Colors.white))),
              //     ],
              //   ),
              // ),

              // const Gap(16),

              /// 🔹 Total Balance Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    transform: GradientRotation(-0.6),
                    colors: [
                      ConstColors.baseColorDark2,
                      ConstColors.baseColorDark2,
                      ConstColors.baseColorDark2,
                      ConstColors.goldGradient1,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoldGradient(
                          child: const Text(
                            'Total Balance',
                            style: TextStyle(
                              color: ConstColors.white,
                              fontFamily: poppinsRegular,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        GoldGradient(
                          child: InkWell(
                            onTap:
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const PortfolioDetailsScreen(),
                                  ),
                                ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: ConstColors.white,
                                    fontFamily: poppinsRegular,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: ConstColors.white,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    const Text(
                      '€48.341,77',
                      style: TextStyle(
                        color: ConstColors.white,
                        fontFamily: poppinsSemiBold,
                        fontSize: 24,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ConstColors.gold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_drop_up_sharp,
                            color: ConstColors.goldGradient2,
                          ),
                          Text(
                            '0.73 (-0.73%) Today',
                            style: TextStyle(
                              color: ConstColors.goldGradient2,
                              fontFamily: poppinsSemiBold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Image.asset(
                        ImagePaths.portfolio.chart,
                        color: ConstColors.goldGradient4,
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(10),

              /// 🔹 Player Cards with animated price
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ConstColors.baseColorDark2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'My Player Cards',
                          style: TextStyle(
                            color: ConstColors.light,
                            fontFamily: poppinsRegular,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: ConstColors.darkblue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Show Cards',
                            style: TextStyle(
                              color: ConstColors.white,
                              fontFamily: poppinsRegular,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final player = _players[index];
                        final isUp = player['isUp'] ?? true;
                        final flashColor =
                            player['flashColor'] ?? Colors.transparent;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: flashColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ConstColors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    player['image'] ?? '',
                                    height: 50,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      player['name'] ?? '',
                                      style: const TextStyle(
                                        color: ConstColors.light,
                                        fontFamily: poppinsRegular,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      player['club'] ?? '',
                                      style: const TextStyle(
                                        color: ConstColors.gray10,
                                        fontFamily: poppinsLight,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        player['price'] ?? '',
                                        style: TextStyle(
                                          color:
                                              isUp
                                                  ? ConstColors.goldGradient2
                                                  : ConstColors.orange,
                                          fontFamily: poppinsSemiBold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Icon(
                                        isUp
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color:
                                            isUp
                                                ? ConstColors.goldGradient2
                                                : ConstColors.orange,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    player['trend'].toString(),
                                    style: TextStyle(
                                      color:
                                          isUp
                                              ? ConstColors.goldGradient2
                                              : ConstColors.orange,
                                      fontFamily: poppinsSemiBold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
