import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/presentation/invite_friends/invite_friends_screen.dart';

class InviteSomeoneSection extends StatelessWidget {
  const InviteSomeoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: ConstColors.baseColorDark3, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const InviteFriendsScreen()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(IconPaths.profile.inviteSomeone, width: 24, height: 24),
                  Gap(16),
                  Text("Invite Someone", style: TextStyle(fontFamily: poppinsRegular, color: ConstColors.light)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
