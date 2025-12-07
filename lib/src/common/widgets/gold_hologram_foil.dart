import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GoldFoilOverlay extends StatefulWidget {
  final double opacity;
  final double speed;
  final BorderRadius? borderRadius;

  const GoldFoilOverlay({
    super.key,
    this.opacity = 0.35,
    this.speed = 1.2,
    this.borderRadius,
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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _generateNoise();
  }

  Future<void> _generateNoise() async {
    const int size = 256;
    final rnd = Random();
    final bytes = Uint8List(size * size * 4);

    for (int i = 0; i < bytes.length; i += 4) {
      final hue = rnd.nextDouble();
      Color c;

      if (hue < 0.33) {
        c =
            Color.lerp(
              const Color(0xFFAE8625),
              const Color(0xFFD2AC47),
              rnd.nextDouble(),
            )!;
      } else if (hue < 0.66) {
        c =
            Color.lerp(
              const Color(0xFFF7EF8A),
              const Color(0xFFEDC967),
              rnd.nextDouble(),
            )!;
      } else {
        c =
            Color.lerp(
              const Color(0xFFD2AC47),
              const Color(0xFFAE8625),
              rnd.nextDouble(),
            )!;
      }

      bytes[i] = c.red;
      bytes[i + 1] = c.green;
      bytes[i + 2] = c.blue;
      bytes[i + 3] = rnd.nextInt(80) + 50;
    }

    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
      bytes,
    );

    final descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: size,
      height: size,
      pixelFormat: ui.PixelFormat.rgba8888,
    );

    final codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();

    setState(() => _noise = frame.image);
  }

  @override
  Widget build(BuildContext context) {
    if (_noise == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
        child: IgnorePointer(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                painter: _GoldFoilPainter(
                  progress: _controller.value,
                  noise: _noise!,
                  opacity: widget.opacity,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GoldFoilPainter extends CustomPainter {
  final double progress;
  final ui.Image noise;
  final double opacity;

  _GoldFoilPainter({
    required this.progress,
    required this.noise,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // ✨ Noise fill
    paint.blendMode = BlendMode.plus;
    paint.color = Colors.white.withOpacity(opacity);

    final noiseScale = size.width / noise.width;
    final Matrix4 transform =
        Matrix4.identity()
          ..scale(noiseScale, noiseScale)
          ..translate(progress * 50, progress * 50);

    paint.imageFilter = ui.ImageFilter.matrix(
      transform.storage,
      filterQuality: FilterQuality.high,
    );

    canvas.drawImage(noise, Offset.zero, paint);

    // ✨ Glossy diagonal shine
    final shine =
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(-size.width * 0.5 + progress * size.width * 1.5, 0),
            Offset(size.width * 1.5 + progress * size.width * 1.5, size.height),
            [
              Colors.transparent,
              Colors.white.withOpacity(0.20),
              Colors.transparent,
            ],
          )
          ..blendMode = BlendMode.screen;

    canvas.drawRect(Offset.zero & size, shine);
  }

  @override
  bool shouldRepaint(covariant _GoldFoilPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.noise != noise ||
      oldDelegate.opacity != opacity;
}
