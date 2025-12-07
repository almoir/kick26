import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/simple_dotted_line.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstColors.baseColorDark3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(ImagePaths.profile.profileImage),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Calvin Verdonk",
                      style: TextStyle(
                        fontFamily: poppinsMedium,
                        color: ConstColors.light,
                      ),
                    ),
                    Text(
                      "Advisor",
                      style: TextStyle(
                        fontFamily: poppinsRegular,
                        fontSize: 12,
                        color: ConstColors.gray10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(12),
          SimpleDottedLine(),
          Gap(12),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "34.2k",
                  style: TextStyle(
                    fontFamily: poppinsMedium,
                    fontSize: 12,
                    color: ConstColors.light,
                  ),
                ),
                Text(
                  " Followers",
                  style: TextStyle(
                    fontFamily: poppinsRegular,
                    fontSize: 12,
                    color: ConstColors.gray10,
                  ),
                ),
                Gap(10),
                Container(width: 1, height: 16, color: Color(0xff242424)),
                Gap(10),
                Text(
                  "4.9",
                  style: TextStyle(
                    fontFamily: poppinsMedium,
                    fontSize: 12,
                    color: ConstColors.light,
                  ),
                ),
                Gap(4),
                Icon(Icons.star, color: Color(0xffFFD736), size: 12),
                Gap(4),
                Text(
                  "(10.4k Ratings)",
                  style: TextStyle(
                    fontFamily: poppinsRegular,
                    fontSize: 12,
                    color: ConstColors.gray10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
