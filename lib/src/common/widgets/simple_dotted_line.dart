import 'package:flutter/material.dart';

class SimpleDottedLine extends StatelessWidget {
  final Color? color;
  final double dotSize;
  final double gapSize;

  const SimpleDottedLine({
    super.key,
    this.color,
    this.dotSize = 6,
    this.gapSize = 4,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final dotCount = (width / (dotSize + gapSize)).floor();

        return Row(
          children: List.generate(dotCount, (_) {
            return Container(
              width: dotSize,
              height: dotSize / 3,
              margin: EdgeInsets.only(right: gapSize),
              decoration: BoxDecoration(color: color ?? Color(0xff242424)),
            );
          }),
        );
      },
    );
  }
}
