import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/simple_dotted_line.dart';
import 'package:kick26/src/presentation/account_setting/credentials/credentials_screen.dart';
import 'package:kick26/src/presentation/account_setting/personal_info/personal_info_screen.dart';
import 'package:kick26/src/presentation/profile/widgets/setting_tile_widget.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 72,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ConstColors.baseColorDark5)),
            child: Center(child: GoldGradient(child: const Icon(Icons.chevron_left, size: 28))),
          ),
        ),
        title: Text(
          "My Account",
          style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(ImagePaths.profile.profileImage)),
                ),
              ),
              Gap(10),
              Text(
                "Active since 24-12-2022 14:00",
                style: TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.light),
              ),
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Screen Name",
                    style: TextStyle(fontFamily: poppinsMedium, fontSize: 10, color: ConstColors.light),
                  ),
                  Gap(8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ConstColors.gold),
                    ),
                    child: Text(
                      "Calvin Verdonk",
                      style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.white),
                    ),
                  ),
                  Gap(20),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ConstColors.baseColorDark3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SettingTileWidget(
                          title: "Credentials",
                          image: IconPaths.profile.credentials,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CredentialsScreen())),
                        ),
                        Padding(padding: const EdgeInsets.fromLTRB(50, 10, 0, 10), child: SimpleDottedLine()),

                        SettingTileWidget(
                          title: "Personal Info",
                          image: IconPaths.profile.personalInfo,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalInfoScreen())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAV
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstColors.orange,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Delete Account", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.white)),
                Gap(10),
                Image.asset(IconPaths.profile.delete, width: 13, height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
