import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/common/fonts_family.dart';
import 'package:kick24/src/common/image_paths.dart';
import 'package:kick24/src/data/models/player_model.dart';

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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: ConstColors.light),
        ),
        title: Text(
          widget.player.name.toUpperCase(),
          style: TextStyle(
            color: ConstColors.light,
            fontFamily: poppinsSemiBold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    player.image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              choosenMenu = 'Overview';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    choosenMenu == 'Overview'
                                        ? ConstColors.lightgreen
                                        : const Color.fromRGBO(0, 0, 0, 0),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Overview',
                                style: TextStyle(
                                  color:
                                      choosenMenu == 'Overview'
                                          ? ConstColors.lightgreen
                                          : ConstColors.gray,
                                  fontFamily: poppinsSemiBold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              choosenMenu = 'Statistics';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    choosenMenu == 'Statistics'
                                        ? ConstColors.lightgreen
                                        : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Statistics',
                                style: TextStyle(
                                  color:
                                      choosenMenu == 'Statistics'
                                          ? ConstColors.lightgreen
                                          : ConstColors.gray,
                                  fontFamily: poppinsSemiBold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              choosenMenu = 'History';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    choosenMenu == 'History'
                                        ? ConstColors.lightgreen
                                        : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'History',
                                style: TextStyle(
                                  color:
                                      choosenMenu == 'History'
                                          ? ConstColors.lightgreen
                                          : ConstColors.gray,
                                  fontFamily: poppinsSemiBold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: widgetTab(),
                  ),
                ],
              ),
            ),
          ),
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

  widgetTab() {
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
        Image.asset(
          ImagePaths.home.mbapeOverview,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        );
    }
  }
}
