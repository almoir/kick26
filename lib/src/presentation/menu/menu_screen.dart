import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/presentation/menu/favorites/favorites_screen.dart';
import 'package:kick26/src/presentation/menu/history/history_screen.dart';
import 'package:kick26/src/presentation/menu/widgets/big_menu_card.dart';
import 'package:kick26/src/presentation/menu/widgets/menu_card_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // =======================================================
          // BIG CARD — TRENDS
          // =======================================================
          BigMenuCard(title: "Trends", subtitle: "Track real time market trends", icon: Icons.show_chart, onTap: () {}),
          const Gap(14),

          // =======================================================
          // BIG CARD — SCAN QR
          // =======================================================
          BigMenuCard(
            title: "Scan QR",
            subtitle: "Quick login with QR code",
            icon: Icons.qr_code_scanner,
            onTap: () {},
          ),
          const Gap(20),

          // =======================================================
          // GRID MENU — 8 ITEMS
          // =======================================================
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.15,
            children: [
              MenuCardItem(
                title: "History",
                icon: Icons.history,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen())),
              ),
              MenuCardItem(title: "Collections", icon: Icons.collections_bookmark_outlined, onTap: () {}),
              MenuCardItem(
                title: "Favorites",
                icon: Icons.favorite_border,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen())),
              ),
              MenuCardItem(title: "Notifications", icon: Icons.notifications_none, onTap: () {}),
              MenuCardItem(title: "Legal", icon: Icons.shield_outlined, onTap: () {}),
              MenuCardItem(title: "Reports", icon: Icons.insert_chart_outlined, onTap: () {}),
              MenuCardItem(title: "Assistant", icon: Icons.assistant_outlined, onTap: () {}),
              MenuCardItem(title: "About App", icon: Icons.info_outline, onTap: () {}),
            ],
          ),

          const Gap(50),
        ],
      ),
    );
  }
}
