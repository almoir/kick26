import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';

class MenuCardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuCardItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ConstColors.baseColorDark3,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ConstColors.gold.withValues(alpha: .4),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoldGradient(child: Icon(icon, size: 28, color: ConstColors.light)),
            const Gap(12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: poppinsRegular,
                color: ConstColors.light,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
