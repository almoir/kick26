import 'dart:math';
import 'dart:async';
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

class FlipPlayerCardWidget extends StatefulWidget {
  const FlipPlayerCardWidget({super.key, required this.player});

  final PlayerModel player;

  @override
  State<FlipPlayerCardWidget> createState() => _FlipPlayerCardWidgetState();
}

class _FlipPlayerCardWidgetState extends State<FlipPlayerCardWidget>
    with TickerProviderStateMixin {
  late AnimationController flipController;
  late Animation<double> flipAnim;

  Timer? _tapTimer;
  bool showFront = true;

  @override
  void initState() {
    super.initState();

    flipController = AnimationController(
      duration: const Duration(milliseconds: 650), // lebih smooth & panjang
      vsync: this,
    );

    flipAnim = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(parent: flipController, curve: Curves.easeInOutCubic),
    );

    flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showFront = !showFront);
        flipController.reset(); // penting agar Hero tidak glitch
      }
    });
  }

  @override
  void dispose() {
    flipController.dispose();
    _tapTimer?.cancel();
    super.dispose();
  }

  // ===============================
  // DOUBLE TAP → FLIP
  // ===============================
  void flipCard() {
    if (!flipController.isAnimating) flipController.forward();
  }

  // ===============================
  // SINGLE TAP → ENLARGE + NAVIGATE
  // ===============================
  void goToDetail() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 550),
        reverseTransitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, anim1, __) {
          return FadeTransition(
            opacity: anim1,
            child: DetailScreen(player: widget.player),
          );
        },
      ),
    );
  }

  // ===============================
  // HANDLE TAP LOGIC
  // ===============================
  void handleTap() {
    if (_tapTimer != null && _tapTimer!.isActive) {
      _tapTimer!.cancel();
      flipCard(); // DOUBLE TAP
    } else {
      _tapTimer = Timer(const Duration(milliseconds: 230), () {
        goToDetail(); // SINGLE TAP
      });
    }
  }

  // ===============================
  // WIDGET
  // ===============================
  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: handleTap,
      child: Hero(
        tag: "player_${widget.player.hashCode}",
        flightShuttleBuilder: _flightBuilder,
        child: AnimatedBuilder(
          animation: flipAnim,
          builder: (_, __) {
            final angle = flipAnim.value;
            final isBack = angle > pi / 2;

            return Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
              child:
                  isBack
                      ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: _buildBack(player),
                      )
                      : _buildFront(player),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // FRONT PART (Styled Card from your original design)
  // =========================================================
  Widget _buildFront(PlayerModel player) {
    return Container(
      width: 140,
      height: 180,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ConstColors.baseColorDark3, ConstColors.baseColorDark4],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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

          // CONTENT FRONT
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(IconPaths.home.ss, height: 24),
                          const Gap(4),
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
                                fontFamily: poppinsRegular,
                                fontSize: 10,
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
                              fontFamily: poppinsRegular,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ConstColors.baseColorDark4,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),

                    // Bottom player info
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoldGradient(
                          child: Text(
                            player.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: poppinsRegular,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "€${formatPrice(player.price)}",
                              style: TextStyle(
                                color: ConstColors.light,
                                fontFamily: poppinsMedium,
                                fontSize: 10,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  player.isUp
                                      ? Icons.arrow_drop_up_sharp
                                      : Icons.arrow_drop_down_sharp,
                                  color:
                                      player.isUp
                                          ? ConstColors.green
                                          : ConstColors.orange,
                                  size: 12,
                                ),
                                Text(
                                  "${player.trend.toStringAsFixed(2)}%",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontFamily: poppinsSemiBold,
                                    color:
                                        player.isUp
                                            ? ConstColors.green
                                            : ConstColors.orange,
                                  ),
                                ),
                              ],
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
    );
  }

  // =========================================================
  // BACK PART (Stats)
  // =========================================================
  Widget _buildBack(PlayerModel player) {
    return Container(
      width: 140,
      height: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ConstColors.baseColorDark4,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ConstColors.gold, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoldGradient(
            child: Text(
              "STATS",
              style: TextStyle(fontSize: 12, fontFamily: poppinsSemiBold),
            ),
          ),
          const Gap(10),
          _tile("PAC", player.stats["pac"]),
          _tile("SHO", player.stats["sho"]),
          _tile("PAS", player.stats["pas"]),
          _tile("DRI", player.stats["dri"]),
          _tile("DEF", player.stats["def"]),
          _tile("PHY", player.stats["phy"]),
        ],
      ),
    );
  }

  Widget _tile(String title, dynamic val) {
    final value = val ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ConstColors.light,
              fontFamily: poppinsRegular,
              fontSize: 10,
            ),
          ),
          Text(
            "$value",
            style: TextStyle(
              color: Colors.white,
              fontFamily: poppinsSemiBold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HERO – Prevent glitch during flip
  // =========================================================
  Widget _flightBuilder(
    BuildContext context,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromHero,
    BuildContext toHero,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: toHero.widget,
    );
  }
}
