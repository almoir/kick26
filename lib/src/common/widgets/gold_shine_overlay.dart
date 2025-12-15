import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GoldShineOverlay extends StatefulWidget {
  final Widget child;
  final double speed;
  final BorderRadius? borderRadius;
  final Duration duration;

  const GoldShineOverlay({
    super.key,
    required this.child,
    this.speed = 1.0,
    this.borderRadius,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<GoldShineOverlay> createState() => _GoldShineOverlayState();
}

class _GoldShineOverlayState extends State<GoldShineOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(16);

    return ClipRRect(
      borderRadius: radius,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            foregroundPainter: _GoldShinePainter(
              progress: Curves.easeInOut.transform(_controller.value),
              speed: widget.speed,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _GoldShinePainter extends CustomPainter {
  final double progress;
  final double speed;

  _GoldShinePainter({required this.progress, required this.speed});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()..blendMode = BlendMode.screen;

    // Shine movement range
    final t = (progress * speed) % 1.0;
    final extra = size.width;
    final dx = ui.lerpDouble(-extra, size.width + extra, t)!;

    canvas.save();

    // rotate sedikit biar diagonal
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi / 6);
    canvas.translate(-size.width / 2, -size.height / 2);

    final shineRect = Rect.fromLTWH(
      dx - size.width * 0.5,
      -size.height * 0.5,
      size.width * 0.4,
      size.height * 2,
    );

    // Pure gold shine (lebih vibrant)
    paint.shader = ui.Gradient.linear(
      shineRect.topLeft,
      shineRect.topRight,
      [
        Color(0xFFAE8625).withValues(alpha: 0.05),
        Color(0xFFF7EF8A).withValues(alpha: 0.2),
        Color(0xFFD2AC47).withValues(alpha: 0.25),
        Color(0xFFEDC967).withValues(alpha: 0.05),
      ],
      const [0.0, 0.45, 0.55, 1.0],
    );

    canvas.drawRect(shineRect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GoldShinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.speed != speed;
  }
}
