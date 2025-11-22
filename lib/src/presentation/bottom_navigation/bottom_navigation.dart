import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick24/src/common/colors.dart';
import 'package:kick24/src/common/fonts_family.dart';
import 'package:kick24/src/common/icon_paths.dart';
import 'package:kick24/src/common/image_paths.dart';
import 'package:kick24/src/common/widgets/gold_gradient.dart';

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
  int _selectedIndex = 0;
  int _marketTabIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  List<Widget> _widgetOptions({int marketTabIndex = 0}) => <Widget>[
    HomeScreen(onTapTrending: _onTapTrending),
    MarketScreen(initialTab: marketTabIndex),
    const PortfolioScreen(),
    // const Center(child: Text('Portfolio', style: optionStyle)),
    const NewsScreen(),
    const Center(child: Text('Profile', style: optionStyle)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _marketTabIndex = 0;
      _selectedIndex = index;
    });
  }

  void _onTapTrending() {
    setState(() {
      _marketTabIndex = 1;
      _selectedIndex = 1;
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
        return "Profile";

      case 5:
        return "News";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title:
            _selectedIndex == 0
                ? Image.asset(ImagePaths.general.kick24Logo, height: 24)
                : Text(
                  appBarTitle(_selectedIndex),
                  style: const TextStyle(
                    fontFamily: poppinsMedium,
                    fontSize: 16,
                    color: ConstColors.light,
                  ),
                ),
        actions: [
          Image.asset(IconPaths.home.notifications, height: 40, width: 40),
          const Gap(15),
        ],
      ),
      body: _widgetOptions(marketTabIndex: _marketTabIndex)[_selectedIndex],
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
                        color: null,
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
                        color: null,
                      ),
            ),
            label: 'Cards',
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
                        color: null,
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
                        color: null,
                      ),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child:
                  _selectedIndex == 4
                      ? GoldGradient(
                        child: Image.asset(
                          IconPaths.general.profileBottomNav,
                          width: 20,
                          height: 20,
                        ),
                      )
                      : Image.asset(
                        IconPaths.general.profileBottomNav,
                        width: 20,
                        height: 20,
                        color: null,
                      ),
            ),
            label: 'Profile',
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
