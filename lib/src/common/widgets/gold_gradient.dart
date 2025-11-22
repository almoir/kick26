import 'package:flutter/material.dart';

class GoldGradient extends StatelessWidget {
  final Widget child;

  const GoldGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFAE8625),
        Color(0xFFF7EF8A),
        Color(0xFFD2AC47),
        Color(0xFFEDC967),
      ],
      stops: [0.0, 0.27, 0.75, 1.0],
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback:
          (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
      child: child,
    );
  }
}

class GoldGradientBorder extends StatelessWidget {
  final Widget? child;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const GoldGradientBorder({
    super.key,
    this.child,
    this.borderWidth = 2,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFAE8625), // 0%
        Color(0xFFF7EF8A), // 27%
        Color(0xFFD2AC47), // 75%
        Color(0xFFEDC967), // 100%
      ],
      stops: [0.0, 0.27, 0.75, 1.0],
    );

    return Container(
      decoration: BoxDecoration(
        gradient: gradient, // gradasi untuk border
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth), // untuk "mengurangi" isi border
        decoration: BoxDecoration(
          color: Colors.black, // background hitam di tengah
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
