import 'package:flutter/material.dart';

class GoldShimmerOverlay extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double opacity;
  final BorderRadius? borderRadius;

  const GoldShimmerOverlay({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.opacity = 0.35,
    this.borderRadius,
  });

  @override
  State<GoldShimmerOverlay> createState() => _GoldShimmerOverlayState();
}

class _GoldShimmerOverlayState extends State<GoldShimmerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Gradient _goldGradient = const LinearGradient(
    colors: [
      Color(0xFFAE8625),
      Color(0xFFF7EF8A),
      Color(0xFFD2AC47),
      Color(0xFFEDC967),
    ],
    stops: [0.0, 0.45, 0.55, 1.0],
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
  );

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
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;

        return Stack(
          children: [
            // CHILD
            widget.child,

            // SHIMMER CLIPPED
            Positioned.fill(
              child: ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      final dx = (width * 2) * _controller.value - width;

                      return Opacity(
                        opacity: widget.opacity,
                        child: Transform.translate(
                          offset: Offset(dx, 0),
                          child: Container(
                            decoration: BoxDecoration(gradient: _goldGradient),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
