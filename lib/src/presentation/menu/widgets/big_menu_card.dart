import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';

class BigMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const BigMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: ConstColors.baseColorDark3,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ConstColors.gold.withValues(alpha: .4),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            GoldGradient(child: Icon(icon, color: Colors.white, size: 26)),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: poppinsMedium,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const Gap(3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: poppinsRegular,
                      color: ConstColors.gray10,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GoldGradient(
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
