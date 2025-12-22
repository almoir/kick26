import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:uuid/uuid.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(ImagePaths.profile.inviteFriend, height: MediaQuery.of(context).size.height * 0.3),
              Gap(40),
              Text(
                "Invite your friends and earn an extra 10% in credits!",
                style: TextStyle(fontFamily: poppinsRegular, fontSize: 24, color: ConstColors.light),
              ),
              Gap(10),
              Text(
                "Got a friend curious about crypto? Invite them to FluxTrade and earn 10% of the fees they generate. By sharing your link, you accept our terms.",
                style: TextStyle(fontFamily: poppinsLight, color: ConstColors.gray10),
              ),
              Gap(40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Copy referral link", style: TextStyle(fontFamily: poppinsMedium, color: ConstColors.white)),
                    IconButton(
                      onPressed:
                          () => _copyTextToClipboard(
                            context,
                            textToCopy: "https://kick26.com/referral?code=${Uuid().v4()}",
                          ),
                      icon: const Icon(Icons.copy, size: 20, color: ConstColors.white),
                    ),
                  ],
                ),
              ),
              Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark3),
                    child: Center(child: Image.asset('assets/icons/whatsapp_icon.png', width: 28, height: 28)),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark3),
                    child: Center(child: Image.asset('assets/icons/telegram_icon.png', width: 28, height: 28)),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: ConstColors.baseColorDark3),
                    child: Center(child: Image.asset('assets/icons/share_icon.png', width: 28, height: 28)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyTextToClipboard(BuildContext context, {required String textToCopy}) async {
    await Clipboard.setData(ClipboardData(text: textToCopy));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        margin: EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        backgroundColor: ConstColors.baseColorDark3,
        dismissDirection: DismissDirection.horizontal,
        content: GoldGradient(
          child: Text('Copied to clipboard', style: TextStyle(fontFamily: poppinsMedium), textAlign: TextAlign.end),
        ),
      ),
    );
  }

  // Example Usage:
  // In a widget build method:
  // ElevatedButton(
  //   onPressed: () {
  //     _copyTextToClipboard("Your text here");
  //   },
  //   child: Text("Copy Text"),
  // )
}
