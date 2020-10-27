import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetBomb extends StatefulWidget {
  const BudgetBomb({Key key}) : super(key: key);

  @override
  _BudgetBombState createState() => _BudgetBombState();
}

class _BudgetBombState extends State<BudgetBomb>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bombSize = 330.w;
    return Center(
      child: SizedBox(
        width: bombSize,
        height: bombSize,
        child: CustomPaint(
          isComplex: true,
          painter: const BombPainter(),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: RepaintBoundary(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipPath(
                    clipper: WaveClipper(
                      amplitude: 5,
                      anim: _controller,
                      direction: WaveDirection.left,
                      waveShift: .1,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[200],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(
                      amplitude: 5,
                      direction: WaveDirection.right,
                      anim: _controller,
                      waveShift: 1,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  const WaveClipper({
    @required this.anim,
    @required this.waveShift,
    @required this.amplitude,
    @required this.direction,
  }) : super(reclip: anim);

  final double waveShift;
  final WaveDirection direction;
  final Animation<double> anim;
  final double verticalShift = .5;
  final double amplitude;

  @override
  Path getClip(Size size) {
    final List<Offset> _points = [];

    final vertShift = size.height * (1 - verticalShift);
    final period = size.width;
    final lambda = 2 * pi / period;
    final shift = (direction == WaveDirection.right)
        ? lambda * period * anim.value + (waveShift * period)
        : lambda * period * anim.value - (waveShift * period);

    double getY(double x) {
      return (direction == WaveDirection.right)
          ? amplitude * sin(lambda * x - shift) + vertShift
          : amplitude * sin(lambda * x + shift) + vertShift;
    }

    for (double i = 0; i <= size.width; i++) {
      _points.add(Offset(i, getY(i)));
    }

    final wavePath = Path()
      ..moveTo(0, size.height)
      ..addPolygon(_points, false)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return wavePath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BombPainter extends CustomPainter {
  const BombPainter();
  // double _degreeToRadians(double angle) {
  //   return angle * pi / 180;
  // }
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final radius = w / 2;

    final bombRect =
        Rect.fromCircle(center: Offset(w / 2, h / 2), radius: radius);

    final bombPaint = Paint()..color = Colors.white54;

    final bombShadow = Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawOval(bombRect.inflate(0), bombShadow);
    canvas.drawOval(bombRect, bombPaint);
  }

  @override
  bool shouldRepaint(BombPainter oldDelegate) => false;
}

enum WaveDirection {
  left,
  right,
}

// ---------- TEXT -------------------------------------------------------------------

// final budgetText = TextPainter()
//   ..textDirection = TextDirection.ltr
//   ..text = TextSpan(text: budgetValue, style: textStyle);

// budgetText.layout();

// final textCenter = budgetText.width / 2;

// budgetText.paint(
//     canvas, Offset(size.width / 2 - textCenter, size.height / 2));
