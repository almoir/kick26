import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/helper.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/data/models/player_model.dart';

class AuthenticityTab extends StatelessWidget {
  final PlayerModel player;

  const AuthenticityTab({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // HEADER PLAYER SECTION
          // ============================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  player.image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(
                        fontFamily: poppinsBold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        Image.asset(player.clubImage, height: 22),
                        const Gap(6),
                        Text(
                          player.club,
                          style: const TextStyle(
                            fontFamily: poppinsRegular,
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    // Trend (up/down)
                    Row(
                      children: [
                        Icon(
                          player.isUp ? Icons.trending_up : Icons.trending_down,
                          color: player.isUp ? Colors.green : Colors.red,
                          size: 18,
                        ),
                        const Gap(6),
                        Text(
                          "${player.trend.toStringAsFixed(2)}%",
                          style: TextStyle(
                            fontFamily: poppinsMedium,
                            color:
                                player.isUp ? Colors.green : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(28),

          // ============================================================
          // PLAYER INFORMATION SECTION
          // ============================================================
          GoldGradient(
            child: const Text(
              "Player Information",
              style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 18),
            ),
          ),

          const Gap(14),

          _infoBox(player),

          const Gap(32),

          // ============================================================
          // NEWS & UPDATES SECTION
          // ============================================================
          GoldGradient(
            child: const Text(
              "News & Authenticity Updates",
              style: TextStyle(fontFamily: poppinsSemiBold, fontSize: 18),
            ),
          ),

          const Gap(16),

          ..._dummyNews(player),
        ],
      ),
    );
  }

  // =============================================================================
  // PLAYER INFO BOX
  // =============================================================================
  Widget _infoBox(PlayerModel p) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ConstColors.gold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          _infoRow("Nationality", p.countryCode.toFlag),
          _infoRow("Age", "${p.age} years"),
          _infoRow("Height", "${p.height} cm"),
          _infoRow("Weight", "${p.weight} kg"),
          _infoRow("Matches Played", p.games.toString()),
          _infoRow("Goals", p.goals.toString()),
          _infoRow("Assists", p.assists.toString()),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: poppinsRegular,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: poppinsMedium,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================================
  // DUMMY NEWS GENERATOR
  // =============================================================================
  List<Widget> _dummyNews(PlayerModel p) {
    return [
      _newsCard(
        title: "${p.name} Shines in Latest Match",
        description:
            "${p.name} delivered an impressive performance, contributing heavily to the team's offensive plays.",
        time: "1 hour ago",
        image: p.image,
      ),
      const Gap(12),
      _newsCard(
        title: "${p.name} Training Progress",
        description:
            "Coaching staff confirms that ${p.name} is showing significant improvements in stamina and finishing.",
        time: "Yesterday",
        image: p.image,
      ),
      const Gap(12),
      _newsCard(
        title: "Authenticity Certificate Updated",
        description:
            "All authenticity data and blockchain records for ${p.name} have been fully verified.",
        time: "2 days ago",
        image: ImagePaths.general.kick26Logo,
        isLogo: true,
      ),
      const Gap(12),
      _newsCard(
        title: "Market Value Trend",
        description:
            "${p.name}'s market valuation shows a ${p.trend}% ${p.isUp ? 'increase' : 'decrease'} this week.",
        time: "3 days ago",
        image: p.image,
      ),
      const Gap(12),
      _newsCard(
        title: "Tactical Role Enhancement",
        description:
            "Analysts note ${p.name}'s evolving role in creating attacking depth and build-up transitions.",
        time: "5 days ago",
        image: p.image,
      ),
      const Gap(12),
      _newsCard(
        title: "Health & Injury Status",
        description:
            "${p.name} is currently in excellent physical condition with no injury concerns reported.",
        time: "1 week ago",
        image: p.image,
      ),
    ];
  }

  // =============================================================================
  // NEWS CARD UI
  // =============================================================================
  Widget _newsCard({
    required String title,
    required String description,
    required String time,
    required String image,
    bool isLogo = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ConstColors.gold.withValues(alpha: .3)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              color: isLogo ? Colors.white : null,
            ),
          ),

          const Gap(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: poppinsSemiBold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const Gap(4),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: poppinsRegular,
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const Gap(6),
                Text(
                  time,
                  style: TextStyle(
                    fontFamily: poppinsRegular,
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
