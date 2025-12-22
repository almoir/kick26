import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';

class LiveMatchWidget extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final String homeLogo;
  final String awayLogo;
  final int homeScore;
  final int awayScore;
  final String league;
  final String time;

  const LiveMatchWidget({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.league,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ConstColors.baseColorDark3,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ConstColors.baseColorDark5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEAGUE + TIME
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(league, style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: ConstColors.goldGradient2.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  time,
                  style: const TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.goldGradient2),
                ),
              ),
            ],
          ),

          const Gap(12),

          /// MATCH ROW
          Row(
            children: [
              /// TEAMS
              Expanded(
                child: Column(children: [_teamRow(homeLogo, homeTeam), const Gap(8), _teamRow(awayLogo, awayTeam)]),
              ),

              /// SCORE
              Column(children: [_scoreText(homeScore), const Gap(8), _scoreText(awayScore)]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamRow(String logo, String name) {
    return Row(
      children: [
        Image.asset(logo, width: 18, height: 18, fit: BoxFit.contain),
        const Gap(8),
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: poppinsRegular, fontSize: 12, color: ConstColors.light),
          ),
        ),
      ],
    );
  }

  Widget _scoreText(int score) {
    return Text(
      score.toString(),
      style: const TextStyle(fontFamily: poppinsSemiBold, fontSize: 14, color: ConstColors.goldGradient2),
    );
  }
}
