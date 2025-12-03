import 'package:flutter/material.dart';
import 'package:kick26/src/common/colors.dart';
import 'package:kick26/src/common/fonts_family.dart';
import 'package:kick26/src/data/models/player_model.dart';

class ListTilePlayersWidget extends StatelessWidget {
  const ListTilePlayersWidget({super.key, required this.players});

  final List<PlayerModel> players;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: players.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: ConstColors.baseColorDark2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: ConstColors.white,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(players[index].image)),
              ),
            ),
            title: Text(
              players[index].name,
              style: const TextStyle(
                color: ConstColors.light,
                fontFamily: poppinsRegular,
                fontSize: 12,
              ),
            ),
            subtitle: Text(
              players[index].club,
              style: const TextStyle(
                color: ConstColors.gray10,
                fontFamily: poppinsLight,
                fontSize: 10,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 🎯 Animasi nilai harga
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color:
                        players[index].isUp
                            ? ConstColors.gold.withValues(alpha: .2)
                            : ConstColors.orange.withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Text(
                    "€${players[index].price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: ConstColors.light,
                      fontFamily: poppinsMedium,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 2),

                // 🎯 Animasi tren naik/turun
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: players[index].trend,
                    end: players[index].trend,
                  ),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    final isUp = players[index].isUp;
                    final color = isUp ? ConstColors.gold : ConstColors.orange;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (child, animation) => ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                          child: Icon(
                            isUp
                                ? Icons.arrow_drop_up_sharp
                                : Icons.arrow_drop_down_sharp,
                            key: ValueKey(isUp),
                            color: color,
                          ),
                        ),
                        Text(
                          value.toStringAsFixed(2),
                          style: TextStyle(
                            color: color,
                            fontFamily: poppinsSemiBold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
