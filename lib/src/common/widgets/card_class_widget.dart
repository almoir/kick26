import 'package:flutter/material.dart';
import 'package:kick26/src/common/fonts_family.dart';

class CardClassWidget extends StatelessWidget {
  const CardClassWidget({super.key, required this.cardClass});

  final String cardClass;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: getCardClassGradient(cardClass),
        ),
      ),
      child: Center(
        child: Text(
          cardClass,
          style: TextStyle(
            fontFamily: poppinsMedium,
            fontSize: 10,
            color: getCardClassTextColor(cardClass),
            shadows: getCardClassTextShadow(cardClass),
          ),
        ),
      ),
    );
  }

  // ==============================
  // GET CARD CLASS
  // ==============================
  List<Color> getCardClassGradient(String cardClass) {
    switch (cardClass) {
      case 'S':
        // GOLD
        return [
          Color(0xFFAE8625),
          Color(0xFFF7EF8A),
          Color(0xFFD2AC47),
          Color(0xFFEDC967),
        ];

      case 'A':
        // PLATINUM (dingin, bersih, premium)
        return [
          Color(0xFFBFC7CE),
          Color(0xFFF1F3F5),
          Color(0xFFD6DBE0),
          Color(0xFFEEF1F4),
        ];

      case 'B':
        // SILVER KUSAM / BRUSHED
        return [
          Color(0xFF8E9399),
          Color(0xFFB5BAC0),
          Color(0xFFA1A6AC),
          Color(0xFFCACED3),
        ];

      case 'C':
      default:
        // BRONZE
        return [
          Color(0xFF6E4B2A),
          Color(0xFFC08A53),
          Color(0xFF9C6B3E),
          Color(0xFFD3A06C),
        ];
    }
  }

  Color getCardClassTextColor(String cardClass) {
    switch (cardClass) {
      case 'S':
        // Dark gold
        return Color(0xFF7A5A1A);

      case 'A':
        // Platinum dark steel
        return Color(0xFF4A4F55);

      case 'B':
        // Dark silver / charcoal
        return Color(0xFF3F4348);

      case 'C':
      default:
        // Dark bronze
        return Color(0xFF5A3A1E);
    }
  }

  List<Shadow> getCardClassTextShadow(String cardClass) {
    return [
      Shadow(
        offset: Offset(0, 1),
        blurRadius: 2,
        color: Colors.black.withValues(alpha: .6),
      ),
    ];
  }
}
