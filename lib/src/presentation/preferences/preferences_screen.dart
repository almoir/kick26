import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/common/widgets/simple_dotted_line.dart';
import 'package:kick26/src/presentation/profile/widgets/setting_tile_widget.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
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
          "My Preferences",
          style: TextStyle(color: ConstColors.light, fontFamily: poppinsSemiBold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: ConstColors.baseColorDark2,
                child: Text(
                  "The My Preferences page lets you customize your experience by managing notification settings and enhancing your account security. Choose how you want to receive alerts and updates, and adjust security preferences to keep your account safe and tailored to your needs.",
                  style: TextStyle(fontFamily: poppinsRegular, fontSize: 10, color: ConstColors.gray10),
                  textAlign: TextAlign.justify,
                ),
              ),
              Gap(20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SettingTileWidget(title: "Notification", image: IconPaths.profile.notificationsPref, onTap: () {}),
                    Padding(padding: const EdgeInsets.fromLTRB(50, 10, 0, 10), child: SimpleDottedLine()),
                    SettingTileWidget(title: "Security", image: IconPaths.profile.security, onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
