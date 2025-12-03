import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';

import '../../../common/widgets/gold_gradient.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GoldGradientBorder(
      padding: EdgeInsets.zero,
      borderRadius: 8,
      child: TextFormField(
        cursorColor: ConstColors.gray,
        style: TextStyle(
          fontFamily: poppinsLight,
          color: ConstColors.light,
          fontSize: 10,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: ConstColors.baseColorDark3,
          isDense: true,
          hintText: "Search",
          hintStyle: TextStyle(
            fontFamily: poppinsLight,
            color: ConstColors.gray20,
            fontSize: 10,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          prefixIconConstraints: BoxConstraints(minWidth: 13, minHeight: 13),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Image.asset(IconPaths.market.search, width: 13, height: 13),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}
