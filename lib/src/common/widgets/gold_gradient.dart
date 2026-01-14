import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kick26/src/common/colors.dart';

class GoldGradient extends StatelessWidget {
  final Widget child;

  const GoldGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFAE8625), Color(0xFFF7EF8A), Color(0xFFD2AC47), Color(0xFFEDC967)],
      stops: [0.0, 0.27, 0.75, 1.0],
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: child,
    );
  }
}

class GoldGradientBorder extends StatelessWidget {
  final Widget? child;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  const GoldGradientBorder({
    super.key,
    this.child,
    this.borderWidth = 2,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(12),
    this.backgroundColor,
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
          color: backgroundColor ?? ConstColors.baseColorDark, // background hitam di tengah
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}

class GoldGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double borderRadius;
  final double height;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const GoldGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius = 10,
    this.height = 60,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFAE8625), Color(0xFFF7EF8A), Color(0xFFD2AC47), Color(0xFFEDC967)],
    stops: [0.0, 0.27, 0.75, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    final bool disabled = onTap == null;

    return AnimatedOpacity(
      duration: Duration(milliseconds: 250),
      opacity: disabled ? 0.4 : 1.0,
      child: Container(
        padding: EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: BoxDecoration(gradient: _gradient, borderRadius: BorderRadius.circular(borderRadius)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: disabled ? null : onTap,
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // OPTIONAL ICON
                  if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 10)],
                  Gap(12),
                  Text(
                    text,
                    style: textStyle ?? TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Gap(12),
                  if (suffixIcon != null) ...[suffixIcon!, const SizedBox(width: 10)],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
