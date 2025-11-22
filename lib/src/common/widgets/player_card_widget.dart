import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/common/fonts_family.dart';
import 'package:kick24/src/common/helper.dart';
import 'package:kick24/src/common/icon_paths.dart';
import 'package:kick24/src/common/image_paths.dart';
import 'package:kick24/src/common/widgets/gold_gradient.dart';
import 'package:kick24/src/data/models/player_model.dart';
import 'package:kick24/src/presentation/detail/detail_screen.dart';

class PlayerCardWidget extends StatelessWidget {
  const PlayerCardWidget({super.key, required this.player});

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(player: player),
            ),
          ),
      child: Container(
        width: 140,
        height: 180,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ConstColors.baseColorDark3, ConstColors.baseColorDark4],
          ),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(ImagePaths.home.borderCard),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(player.image, fit: BoxFit.contain),
                ),
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  // SS SECTION
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Image.asset(IconPaths.home.ss, height: 24),
                            Gap(4),
                            Image.asset(player.clubImage, height: 16),
                            Text(player.countryCode.toFlag),
                          ],
                        ),
                        Column(
                          children: [
                            GoldGradient(
                              child: Text(
                                "41",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: poppinsRegular,
                                ),
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 1,
                              color: ConstColors.darkGray2,
                            ),
                            Text(
                              "60",
                              style: TextStyle(
                                color: ConstColors.darkGray,
                                fontSize: 10,
                                fontFamily: poppinsRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // PLAYER DETAILS
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            ConstColors.baseColorDark4,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoldGradient(
                            child: Text(
                              player.name,
                              style: TextStyle(
                                fontFamily: poppinsRegular,
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gap(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: player.price,
                                  end: player.price,
                                ),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, value, child) {
                                  return Text(
                                    "€${formatPrice(value)}",
                                    style: const TextStyle(
                                      color: ConstColors.light,
                                      fontFamily: poppinsMedium,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: player.trend,
                                  end: player.trend,
                                ),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, value, child) {
                                  final isUp = player.isUp;
                                  final color =
                                      isUp
                                          ? ConstColors.green
                                          : ConstColors.orange;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        transitionBuilder:
                                            (child, animation) =>
                                                ScaleTransition(
                                                  scale: animation,
                                                  child: child,
                                                ),
                                        child: Icon(
                                          isUp
                                              ? Icons.arrow_drop_up_sharp
                                              : Icons.arrow_drop_down_sharp,
                                          key: ValueKey(isUp),
                                          color: color,
                                          size: 10,
                                        ),
                                      ),
                                      Text(
                                        "${value.toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          color: color,
                                          fontFamily: poppinsSemiBold,
                                          fontSize: 6,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
