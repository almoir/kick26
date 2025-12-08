import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GoldFoilOverlay extends StatefulWidget {
  final Widget child;
  final double opacity; // intensitas foil subtle
  final double speed;
  final BorderRadius? borderRadius;
  final Duration duration;

  const GoldFoilOverlay({
    super.key,
    required this.child,
    this.opacity = 0.10, // 10% gold tint (super subtle)
    this.speed = 1.0,
    this.borderRadius,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<GoldFoilOverlay> createState() => _GoldFoilOverlayState();
}

class _GoldFoilOverlayState extends State<GoldFoilOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ui.Image? _noise;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _generateNoise();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generateNoise() async {
    const int size = 256;
    final rnd = Random();
    final bytes = Uint8List(size * size * 4);

    for (int i = 0; i < bytes.length; i += 4) {
      final hue = rnd.nextDouble();
      late Color c;

      if (hue < 0.33) {
        c =
            Color.lerp(
              const Color(0xFFAE8625),
              const Color(0xFFD2AC47),
              rnd.nextDouble(),
            ) ??
            const Color(0xFFAE8625);
      } else if (hue < 0.66) {
        c =
            Color.lerp(
              const Color(0xFFF7EF8A),
              const Color(0xFFEDC967),
              rnd.nextDouble(),
            ) ??
            const Color(0xFFF7EF8A);
      } else {
        c =
            Color.lerp(
              const Color(0xFFD2AC47),
              const Color(0xFFAE8625),
              rnd.nextDouble(),
            ) ??
            const Color(0xFFD2AC47);
      }

      bytes[i] = c.red;
      bytes[i + 1] = c.green;
      bytes[i + 2] = c.blue;

      // Slight transparency for subtle overlay
      bytes[i + 3] = rnd.nextInt(40) + 20; // VERY subtle alpha
    }

    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: size,
      height: size,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();

    if (!mounted) return;
    setState(() => _noise = frame.image);
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
            foregroundPainter:
                _noise == null
                    ? null
                    : _GoldFoilPainter(
                      progress: Curves.easeInOut.transform(_controller.value),
                      noise: _noise!,
                      opacity: widget.opacity,
                      speed: widget.speed,
                      // borderRadius: radius,
                    ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _GoldFoilPainter extends CustomPainter {
  final double progress;
  final ui.Image noise;
  final double opacity;
  final double speed;

  _GoldFoilPainter({
    required this.progress,
    required this.noise,
    required this.opacity,
    required this.speed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final rect = Offset.zero & size;

    // ---------------------------------------------------------
    // 1) SUPER SUBTLE GOLD TINT (Gold 10%)
    // ---------------------------------------------------------
    final basePaint =
        Paint()
          ..shader = ui.Gradient.linear(
            rect.topLeft,
            rect.bottomRight,
            const [
              Color(0x00AE8625), // 0% alpha
              Color(0x10FFD27F), // ~6% alpha
              Color(0x18FFEFBB), // ~10% alpha
              Color(0x10FFD27F),
            ],
            const [0.0, 0.35, 0.7, 1.0],
          )
          ..blendMode = BlendMode.softLight;

    canvas.drawRect(rect, basePaint);

    // ---------------------------------------------------------
    // 2) SOFT NOISE (TEXTURE SUBTLE)
    // ---------------------------------------------------------
    final double sx = size.width / noise.width;
    final double sy = size.height / noise.height;

    final noisePaint =
        Paint()
          ..shader = ImageShader(
            noise,
            TileMode.mirror,
            TileMode.mirror,
            Matrix4.identity().scaled(sx, sy).storage,
          )
          ..colorFilter = ColorFilter.mode(
            Colors.white.withOpacity(opacity * 0.35), // sangat halus
            BlendMode.modulate,
          )
          ..blendMode = BlendMode.softLight;

    canvas.drawRect(rect, noisePaint);

    // ---------------------------------------------------------
    // 3) SUBTLE DIAGONAL SHINE (ultra ringan)
    // ---------------------------------------------------------
    final shinePaint = Paint()..blendMode = BlendMode.screen;

    final t = (progress * speed) % 1.0;
    final extra = size.width;
    final dx = ui.lerpDouble(-extra, size.width + extra, t)!;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi / 6);
    canvas.translate(-size.width / 2, -size.height / 2);

    final shineRect = Rect.fromLTWH(
      dx - size.width * 0.5,
      -size.height,
      size.width * 0.8,
      size.height * 3,
    );

    shinePaint.shader = ui.Gradient.linear(
      shineRect.topLeft,
      shineRect.topRight,
      [
        Color(0xFFAE8625).withOpacity(0.0),
        Color(0xFFF7EF8A).withOpacity(0.05),
        Color(0xFFD2AC47).withOpacity(0.1),
        Color(0xFFEDC967).withOpacity(0.0),
      ],
      const [0.0, 0.45, 0.55, 1.0],
    );

    canvas.drawRect(shineRect, shinePaint);
    canvas.restore();

    // ---------------------------------------------------------
    // 4) MICRO GLITTER (random sparkles halus)
    // ---------------------------------------------------------
    final glitter =
        Paint()
          ..color = Colors.white.withOpacity(0.08)
          ..blendMode = BlendMode.plus;

    final rnd = Random(42);
    for (int i = 0; i < (size.width * size.height * 0.003); i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;

      final radius = 0.3 + rnd.nextDouble() * 0.4;
      canvas.drawCircle(Offset(x, y), radius, glitter);
    }
  }

  @override
  bool shouldRepaint(covariant _GoldFoilPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.noise != noise ||
        oldDelegate.opacity != opacity ||
        oldDelegate.speed != speed;
  }
}
