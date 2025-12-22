import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';

class UpcomingMatchWidget extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final String league;
  final String date;
  final String time;

  const UpcomingMatchWidget({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.league,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ConstColors.baseColorDark5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$homeTeam vs $awayTeam",
                style: const TextStyle(fontFamily: poppinsMedium, color: ConstColors.light),
              ),
              const Gap(6),
              Text(league, style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: const TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10)),
              const Gap(4),
              Text(
                time,
                style: const TextStyle(fontFamily: poppinsMedium, fontSize: 12, color: ConstColors.goldGradient2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
