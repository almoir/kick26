import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';

class DetailPlayerCardWidget extends StatelessWidget {
  const DetailPlayerCardWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String name;
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ConstColors.baseColorDark3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff252525),
                ),
                child: Center(child: Image.asset(icon, width: 14, height: 14)),
              ),
              Gap(8),
              Text(
                name,
                style: TextStyle(
                  fontFamily: poppinsMedium,
                  fontSize: 12,
                  color: ConstColors.light,
                ),
              ),
            ],
          ),
          Gap(30),
          Text(
            title,
            style: TextStyle(
              fontFamily: poppinsMedium,
              fontSize: 12,
              color: ConstColors.light,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: poppinsMedium,
              fontSize: 12,
              color: ConstColors.light,
            ),
          ),
        ],
      ),
    );
  }
}
