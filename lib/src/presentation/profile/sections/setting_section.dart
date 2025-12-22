import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/widgets/simple_dotted_line.dart';
import 'package:kick26/src/presentation/account_setting/account_setting_screen.dart';
import 'package:kick26/src/presentation/preferences/preferences_screen.dart';
import 'package:kick26/src/presentation/profile/widgets/setting_tile_widget.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SettingTileWidget(
            title: "Account Settings",
            image: IconPaths.profile.accountSettings,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountSettingScreen())),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(50, 10, 0, 10), child: SimpleDottedLine()),

          SettingTileWidget(title: "Trading Account", image: IconPaths.profile.tradingAccount, onTap: () {}),
          Padding(padding: const EdgeInsets.fromLTRB(50, 10, 0, 10), child: SimpleDottedLine()),

          SettingTileWidget(
            title: "Preferences",
            image: IconPaths.profile.preferences,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PreferencesScreen())),
          ),
        ],
      ),
    );
  }
}
