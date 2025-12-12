import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/dummy.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/flip_player_card_widget.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/detail/detail_screen.dart';
import 'package:kick26/src/presentation/transcations_history/transactions_history_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _players = dummyPlayers.reversed.toList();

  late List<PlayerModel> players;
  late AnimationController _controller;
  bool isCardView = true;

  @override
  void initState() {
    super.initState();
    _simulatePriceChange();
    players = generateDummyPlayers();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  void flipView() {
    if (_controller.isCompleted) {
      _controller.reverse();
      isCardView = !isCardView;
    } else {
      _controller.forward();
      isCardView = !isCardView;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              padding: const EdgeInsets.all(14),
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
                          'Total Value',
                          style: TextStyle(
                            color: ConstColors.white,
                            fontFamily: poppinsRegular,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      GoldGradient(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => TransactionsHistoryScreen(
                                      players: players.reversed.toList(),
                                    ),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Transaction History',
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
                    padding: const EdgeInsets.all(4),
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
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isCardView ? 0 : 220,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Image.asset(
                        ImagePaths.portfolio.chart,
                        color: ConstColors.goldGradient4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(10),

            /// 🔹 Player Cards with animated price
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
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
                          border: Border.all(color: ConstColors.gold),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            flipView();
                            setState(() {});
                          },
                          child: GoldGradient(
                            child: Text(
                              isCardView
                                  ? "Show Financial View"
                                  : "Show Card View",
                              style: TextStyle(
                                color: ConstColors.black,
                                fontFamily: poppinsRegular,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      final angle = _controller.value * pi;
                      final isFrontSide = angle <= (pi / 2);

                      return Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(angle),
                        child:
                            isFrontSide
                                ? GridView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.82,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2,
                                      ),
                                  itemBuilder: (context, index) {
                                    final reversePlayer =
                                        players.reversed.toList();
                                    final player = reversePlayer[index];
                                    return FlipPlayerCardWidget(
                                      player: player,
                                      players: players,
                                      tag: "portfolio_screen_card_view",
                                    );
                                  },
                                )
                                : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()..rotateY(pi),
                                  child: _buildFinancialView(),
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
    );
  }

  Widget _buildFinancialView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        final player = _players[index];
        final isUp = player['isUp'] ?? true;
        final flashColor = player['flashColor'] ?? Colors.transparent;
        final reversePlayer = players.reversed.toList();
        final playerModel = reversePlayer[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => DetailScreen(
                      player: playerModel,
                      players: players,
                      tag: "portfolio_screen_financial_view",
                    ),
              ),
            );
          },
          child: AnimatedContainer(
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
                    child: Image.asset(player['image'] ?? '', height: 50),
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
                          isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
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
          ),
        );
      },
    );
  }
}
