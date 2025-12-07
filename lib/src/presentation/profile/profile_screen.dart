import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';

import 'package:kick26/src/presentation/profile/sections/account_verified_section.dart';
import 'package:kick26/src/presentation/profile/sections/invite_someone_section.dart';
import 'package:kick26/src/presentation/profile/sections/profile_header_section.dart';
import 'package:kick26/src/presentation/profile/sections/setting_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeaderSection(),
            Gap(20),

            AccountVerifiedSection(),
            Gap(20),

            SettingSection(),
            Gap(20),

            InviteSomeoneSection(),
            Gap(20),

            TextButton(
              onPressed: () {},
              child: Text(
                "Rate this app",
                style: TextStyle(
                  fontFamily: poppinsRegular,
                  fontSize: 12,
                  color: ConstColors.gray10,
                  decoration: TextDecoration.underline,
                  decorationColor: ConstColors.gray10,
                ),
              ),
            ),
            Gap(20),

            GoldGradientButton(
              text: "Sign Out",
              suffixIcon: Icon(Icons.logout, color: ConstColors.baseColorDark),
              onTap: () {},
            ),
            Gap(50),
          ],
        ),
      ),
    );
  }
}
