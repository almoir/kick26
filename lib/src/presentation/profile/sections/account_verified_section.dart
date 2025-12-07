import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';

class AccountVerifiedSection extends StatelessWidget {
  const AccountVerifiedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: ConstColors.baseColorDark3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Congratutions! Your account is verified.",
            style: TextStyle(
              fontFamily: poppinsRegular,
              fontSize: 12,
              color: ConstColors.gray10,
            ),
          ),
          Icon(Icons.check_circle, color: ConstColors.green2, size: 16),
        ],
      ),
    );
  }
}
