import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/data/models/player_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.player});

  final PlayerModel player;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String choosenMenu = 'Overview';
  late PlayerModel player;

  @override
  void initState() {
    super.initState();
    player = widget.player;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.baseColorDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: ConstColors.light),
        ),
        title: Text(
          player.name.toUpperCase(),
          style: TextStyle(
            color: ConstColors.light,
            fontFamily: poppinsSemiBold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),

      // BODY
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // =======================
                  // HERO ENLARGE IMAGE
                  // =======================
                  Hero(
                    tag: "player_${widget.player.hashCode}",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        player.image,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const Gap(10),

                  // =======================
                  // MENU TABS
                  // =======================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        _buildMenuButton('Overview'),
                        const Gap(5),
                        _buildMenuButton('Statistics'),
                        const Gap(5),
                        _buildMenuButton('History'),
                      ],
                    ),
                  ),

                  // =======================
                  // TAB CONTENT
                  // =======================
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: widgetTab(),
                  ),
                ],
              ),
            ),
          ),

          // =======================
          // BUY BUTTON
          // =======================
          Container(
            margin: const EdgeInsets.all(15),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ConstColors.lightgreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: ConstColors.light,
                  fontFamily: poppinsSemiBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MENU BUTTON BUILDER
  // ============================================================
  Widget _buildMenuButton(String label) {
    final bool active = choosenMenu == label;

    return InkWell(
      onTap: () {
        setState(() {
          choosenMenu = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: active ? ConstColors.lightgreen : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: active ? ConstColors.lightgreen : ConstColors.gray,
              fontFamily: poppinsSemiBold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TAB CONTENT
  // ============================================================
  Widget widgetTab() {
    switch (choosenMenu) {
      case 'Overview':
        return Image.asset(
          ImagePaths.home.mbapeOverview,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );

      case 'Statistics':
        return Image.asset(
          ImagePaths.home.mbapeStatistic,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );

      case 'History':
        return Image.asset(
          ImagePaths.home.mbapeHistory,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );

      default:
        return Image.asset(
          ImagePaths.home.mbapeOverview,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );
    }
  }
}
