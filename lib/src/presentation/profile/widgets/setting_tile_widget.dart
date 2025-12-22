import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';

class SettingTileWidget extends StatelessWidget {
  const SettingTileWidget({super.key, required this.title, required this.image, required this.onTap});

  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(image, width: 24, height: 24),
                Gap(16),
                Text(title, style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.light)),
                Spacer(),
                GoldGradient(child: Image.asset(IconPaths.home.arrowRight2, height: 11, width: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
