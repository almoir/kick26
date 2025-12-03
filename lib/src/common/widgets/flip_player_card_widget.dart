import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';
import 'package:kick26/src/presentation/detail/detail_screen.dart';

class FlipPlayerCardWidget extends StatefulWidget {
  const FlipPlayerCardWidget({super.key, required this.player});

  final PlayerModel player;

  @override
  State<FlipPlayerCardWidget> createState() => _FlipPlayerCardWidgetState();
}

class _FlipPlayerCardWidgetState extends State<FlipPlayerCardWidget>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _angleAnimation;

  Timer? _tapTimer;

  /// sudut posisi kartu saat ini (dalam radian)
  /// 0        = front menghadap user
  /// pi       = back menghadap user
  /// berputar ±pi setiap flip
  double _angle = 0.0;

  /// true: posisi istirahat di front, false: di back
  bool _isFront = true;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    // default, angle diem di 0 (front)
    _angleAnimation = AlwaysStoppedAnimation(_angle);
  }

  @override
  void dispose() {
    _flipController.dispose();
    _tapTimer?.cancel();
    super.dispose();
  }

  // ===============================
  // DOUBLE TAP → FLIP
  // ===============================
  void _flipCard() {
    if (_flipController.isAnimating) return;

    final double start = _angle;
    // FRONT → BACK : +pi (flip ke kanan)
    // BACK  → FRONT: -pi (flip ke kiri)
    final double end = _isFront ? start + pi : start - pi;

    _angleAnimation = Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    );

    _flipController
      ..reset()
      ..forward().then((_) {
        setState(() {
          _angle = end;
          _isFront = !_isFront;
        });
      });
  }

  // ===============================
  // SINGLE TAP → ENLARGE + NAVIGATE
  // ===============================
  void _goToDetail() {
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
  // HANDLE TAP LOGIC (single vs double)
  // ===============================
  void _handleTap() {
    if (_tapTimer != null && _tapTimer!.isActive) {
      _tapTimer!.cancel();
      _flipCard(); // DOUBLE TAP
    } else {
      _tapTimer = Timer(const Duration(milliseconds: 230), () {
        _goToDetail(); // SINGLE TAP
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Hero(
          tag: "player_${player.name}", // pastikan unique per player
          flightShuttleBuilder: _flightBuilder,
          child: AnimatedBuilder(
            animation: _flipController,
            builder: (_, __) {
              // sudut aktual: kalau lagi animasi pakai animasi, kalau tidak pakai _angle terakhir
              double rawAngle =
                  _flipController.isAnimating ? _angleAnimation.value : _angle;

              // normalisasi ke 0..2π
              double normalized = rawAngle % (2 * pi);
              if (normalized < 0) normalized += 2 * pi;

              // tentukan sisi mana yang kelihatan:
              //  0°   → front
              //  90°  → pinggir
              // 180°  → back
              // 270°  → pinggir
              // 360°  → front
              final bool showFront =
                  normalized <= pi / 2 || normalized >= 3 * pi / 2;

              // progress dalam setengah putaran (0..pi)
              final double halfTurn =
                  normalized <= pi ? normalized : (2 * pi - normalized);
              // depth shadow puncak di tengah
              final double depth = sin(halfTurn); // 0..1

              // bayangan 3D
              final double shadowOffsetX =
                  (_isFront ? 1.0 : -1.0) *
                  4.0 *
                  depth; // arah tergantung sisi rest
              final double shadowBlur = 10.0 + 10.0 * depth;

              Widget cardChild;
              if (showFront) {
                cardChild = _buildFront(player);
              } else {
                // back di-rotate balik biar tidak mirror
                cardChild = Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: _buildBack(player),
                );
              }

              return Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.0015)
                      ..rotateY(normalized),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45 * depth),
                        offset: Offset(shadowOffsetX, 8 * depth),
                        blurRadius: shadowBlur,
                        spreadRadius: 1.5 * depth,
                      ),
                    ],
                  ),
                  child: cardChild,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FRONT PART (Card tampilan utama)
  // =========================================================
  Widget _buildFront(PlayerModel player) {
    return Container(
      width: 140,
      height: 180,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
          // Player image di belakang, bottom-center
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(player.image, fit: BoxFit.contain),
              ),
            ),
          ),

          // Content atas + bawah
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // Badge & club & negara
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
                            child: const Text(
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
                          const Text(
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

                // Info bawah (nama, harga, trend)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ConstColors.baseColorDark4,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoldGradient(
                          child: Text(
                            player.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
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
                              style: const TextStyle(
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoldGradient(
            child: const Text(
              "STATS",
              style: TextStyle(fontSize: 12, fontFamily: poppinsSemiBold),
            ),
          ),
          const Gap(10),
          _statTile("PAC", player.stats["pac"]),
          _statTile("SHO", player.stats["sho"]),
          _statTile("PAS", player.stats["pas"]),
          _statTile("DRI", player.stats["dri"]),
          _statTile("DEF", player.stats["def"]),
          _statTile("PHY", player.stats["phy"]),
        ],
      ),
    );
  }

  Widget _statTile(String title, dynamic val) {
    final value = val ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ConstColors.light,
              fontFamily: poppinsRegular,
              fontSize: 10,
            ),
          ),
          Text(
            "$value",
            style: const TextStyle(
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
