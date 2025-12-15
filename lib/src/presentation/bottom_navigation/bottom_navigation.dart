import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/common/icon_paths.dart';
import 'package:kick26/src/common/image_paths.dart';
import 'package:kick26/src/common/widgets/gold_gradient.dart';
import 'package:kick26/src/presentation/menu/menu_screen.dart';
import 'package:kick26/src/presentation/profile/profile_screen.dart';

import '../home/home_screen.dart';
import '../market/market_screen.dart';
import '../news/news_screen.dart';
import '../portfolio/portfolio_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  List<Widget> _widgetOptions() => <Widget>[
    HomeScreen(onTapTrending: _onTapMyPlayerCard),
    MarketScreen(),
    const PortfolioScreen(),
    const NewsScreen(),
    MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapMyPlayerCard() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  String appBarTitle(int selectedIndex) {
    switch (selectedIndex) {
      case 1:
        return "Market";
      case 2:
        return "Portfolio";
      case 3:
        return "News & Update";
      case 4:
        return "Menu";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title:
            _selectedIndex == 0
                ? Image.asset(ImagePaths.general.kick26Logo, height: 24)
                : Text(
                  appBarTitle(_selectedIndex),
                  style: const TextStyle(
                    fontFamily: poppinsMedium,
                    fontSize: 16,
                    color: ConstColors.light,
                  ),
                ),
        actions: [
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                ),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: ConstColors.gold),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: GoldGradient(
                  child: Image.asset(
                    IconPaths.general.profile,
                    height: 18,
                    width: 18,
                  ),
                ),
              ),
            ),
          ),
          const Gap(16),
        ],
      ),

      body: _widgetOptions()[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0C0C0C),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  _selectedIndex == 0
                      ? GoldGradient(
                        child: Image.asset(
                          IconPaths.general.homeBottomNav,
                          width: 20,
                          height: 20,
                        ),
                      )
                      : Image.asset(
                        IconPaths.general.homeBottomNav,
                        width: 20,
                        height: 20,
                      ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  _selectedIndex == 1
                      ? GoldGradient(
                        child: Image.asset(
                          IconPaths.general.cardsBottomNav,
                          width: 20,
                          height: 20,
                        ),
                      )
                      : Image.asset(
                        IconPaths.general.cardsBottomNav,
                        width: 20,
                        height: 20,
                      ),
            ),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  _selectedIndex == 2
                      ? GoldGradient(
                        child: Image.asset(
                          IconPaths.general.portfolioBottomNav,
                          width: 20,
                          height: 20,
                        ),
                      )
                      : Image.asset(
                        IconPaths.general.portfolioBottomNav,
                        width: 20,
                        height: 20,
                      ),
            ),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  _selectedIndex == 3
                      ? GoldGradient(
                        child: Image.asset(
                          IconPaths.general.newsBottomNav,
                          width: 20,
                          height: 20,
                        ),
                      )
                      : Image.asset(
                        IconPaths.general.newsBottomNav,
                        width: 20,
                        height: 20,
                      ),
            ),
            label: 'News',
          ),

          /// INDEX 4 → OPEN DRAWER
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  _selectedIndex == 4
                      ? GoldGradient(
                        child: Image.asset(
                          IconPaths.general.menuBottomNav,
                          width: 20,
                          height: 20,
                        ),
                      )
                      : Image.asset(
                        IconPaths.general.menuBottomNav,
                        width: 20,
                        height: 20,
                      ),
            ),
            label: 'Menu',
          ),
        ],
        selectedItemColor: ConstColors.gold,
        selectedLabelStyle: const TextStyle(
          fontFamily: poppinsRegular,
          fontSize: 12,
        ),
        unselectedItemColor: ConstColors.gray,
        unselectedLabelStyle: const TextStyle(
          fontFamily: poppinsRegular,
          fontSize: 12,
        ),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
