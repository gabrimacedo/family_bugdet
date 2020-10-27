import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';
import 'themeData.dart';

class PersonalProgress extends StatelessWidget {
  const PersonalProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
      height: 500.h,
      child: CustomPaint(
        painter: PersonalGastoPainter(),
      ),
    );
  }
}

class PersonalGastoPainter extends CustomPainter {
  final gabrielPercentage = .1;
  final luPercentage = .22;
  final patPercentage = .5;
  final marcosPercentage = .18;

  final graphRotationAngle = 45 * pi / 180;

  final percentagestyle = TextStyle(
    fontFamily: 'Metropolis Light',
    fontStyle: FontStyle.italic,
    fontSize: 40.sp,
    color: Colors.white,
  );

  static const startAngle = 'startAngle';
  static const sweepAngle = 'sweepAngle';
  static const endAngle = 'endAngle';

  // double _degreeToRadians(double angle) => angle * pi / 180;

  Offset _angleToPoint(double angle, double radius, Offset center) =>
      Offset(center.dx + cos(angle) * radius, center.dy + sin(angle) * radius);

  TextPainter getPercentPainter(double percent) {
    return TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '${(percent * 100).truncate().toString()}\%',
        style: percentagestyle,
      ),
    );
  }

  Offset _getArcMidPoint(Map<String, double> arc, double inRadius,
      double outRadius, Offset center) {
    final arc1MidAngle = (arc[startAngle] + arc[endAngle]) / 2;
    final arc1OutterMidPoint = _angleToPoint(arc1MidAngle, outRadius, center);
    final arc1InnerMidPoint = _angleToPoint(arc1MidAngle, inRadius, center);

    return Offset((arc1OutterMidPoint.dx + arc1InnerMidPoint.dx) / 2,
        (arc1OutterMidPoint.dy + arc1InnerMidPoint.dy) / 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    assert(
      gabrielPercentage + luPercentage + patPercentage + marcosPercentage == 1,
      'Total pizza chart value != 100 %',
    );

    final w = size.width;
    final h = size.height;
    final outterRadius = h / 2;
    final innerRadius = h / 4.2;
    final circleCenter = Offset(outterRadius + 20, h / 2);

    final outterRect =
        Rect.fromCircle(center: circleCenter, radius: outterRadius);
    final innerRect =
        Rect.fromCircle(center: circleCenter, radius: innerRadius);

    // ------------- GRAPH ARCS --------------------------------------------------

    final Map<String, double> firstArc = {
      startAngle: 0 + graphRotationAngle,
      sweepAngle: patPercentage * 2 * pi,
      endAngle: 0 + graphRotationAngle + patPercentage * 2 * pi,
    };
    final Map<String, double> secondArc = {
      startAngle: firstArc[endAngle],
      sweepAngle: marcosPercentage * 2 * pi,
      endAngle: firstArc[endAngle] + marcosPercentage * 2 * pi,
    };
    final Map<String, double> thirdArc = {
      startAngle: secondArc[endAngle],
      sweepAngle: luPercentage * 2 * pi,
      endAngle: secondArc[endAngle] + luPercentage * 2 * pi
    };
    final Map<String, double> fourthArc = {
      startAngle: thirdArc[endAngle],
      sweepAngle: gabrielPercentage * 2 * pi,
      endAngle: thirdArc[endAngle] + gabrielPercentage * 2 * pi
    };

    final fourthArcPaint = Paint()..color = AppColors.graphRed;
    final thirdArcPaint = Paint()..color = AppColors.graphGreen;
    final secondArcPaint = Paint()..color = AppColors.graphBlue;
    final firstArcPaint = Paint()..color = Colors.red[200];

    final firstArcPath = Path()
      ..addArc(
          outterRect.inflate(6), firstArc[startAngle], firstArc[sweepAngle])
      ..arcTo(innerRect, firstArc[endAngle], -firstArc[sweepAngle], false)
      ..close();

    final secondArcPath = Path()
      ..addArc(
          outterRect.inflate(3), secondArc[startAngle], secondArc[sweepAngle])
      ..arcTo(innerRect, secondArc[endAngle], -secondArc[sweepAngle], false)
      ..close();

    final thirdArcPath = Path()
      ..addArc(outterRect, thirdArc[startAngle], thirdArc[sweepAngle])
      ..arcTo(innerRect, thirdArc[endAngle], -thirdArc[sweepAngle], false)
      ..close();

    final fourthArcPath = Path()
      ..addArc(
          outterRect.deflate(3), fourthArc[startAngle], fourthArc[sweepAngle])
      ..arcTo(innerRect, fourthArc[endAngle], -fourthArc[sweepAngle], false)
      ..close();

    canvas.drawPath(firstArcPath, firstArcPaint);
    canvas.drawPath(secondArcPath, secondArcPaint);
    canvas.drawPath(thirdArcPath, thirdArcPaint);
    canvas.drawPath(fourthArcPath, fourthArcPaint);

    // // ----- TEXT --------------------------------------------------------------

    final arc1MidPoint =
        _getArcMidPoint(firstArc, innerRadius, outterRadius, circleCenter);
    final arc2MidPoint =
        _getArcMidPoint(secondArc, innerRadius, outterRadius, circleCenter);
    final arc3MidPoint =
        _getArcMidPoint(thirdArc, innerRadius, outterRadius, circleCenter);
    final arc4MidPoint =
        _getArcMidPoint(fourthArc, innerRadius, outterRadius, circleCenter);

    final firstArcValue = getPercentPainter(patPercentage);
    firstArcValue.layout();

    final secondArcValue = getPercentPainter(marcosPercentage);
    secondArcValue.layout();

    final thirdArcValue = getPercentPainter(luPercentage);
    thirdArcValue.layout();

    final fourthArcValue = getPercentPainter(gabrielPercentage);
    fourthArcValue.layout();

    firstArcValue.paint(
        canvas,
        Offset(arc1MidPoint.dx - firstArcValue.width / 2,
            arc1MidPoint.dy - firstArcValue.height / 2));

    secondArcValue.paint(
        canvas,
        Offset(arc2MidPoint.dx - secondArcValue.width / 2,
            arc2MidPoint.dy - secondArcValue.height / 2));

    thirdArcValue.paint(
        canvas,
        Offset(arc3MidPoint.dx - thirdArcValue.width / 2,
            arc3MidPoint.dy - thirdArcValue.height / 2));

    fourthArcValue.paint(
        canvas,
        Offset(arc4MidPoint.dx - fourthArcValue.width / 2,
            arc4MidPoint.dy - fourthArcValue.height / 2));

    final middleText = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: 'Gasto por pessoa',
        style: CustomTextTheme.subtitle2,
      ),
    );
    middleText.layout(maxWidth: innerRect.width);

    middleText.paint(
        canvas,
        Offset(outterRect.center.dx - middleText.width / 2,
            outterRect.center.dy - middleText.height / 2));

    // -----------------------------------------------------------

    final separatorRect = outterRect.inflate(40);
    final separatorArc = {
      startAngle: .15 * 2 * pi,
      sweepAngle: -(.30 * pi * 2),
      endAngle: (.15 * 2 * pi) + (-.30 * pi * 2),
    };

    // final separatorPath = Path()
    //   ..addArc(
    //       separatorRect, separatorArc[startAngle], separatorArc[sweepAngle]);
    // final separatorPaint = Paint()
    //   ..color = Colors.black38
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 3;
    // canvas.drawPath(separatorPath, separatorPaint);

    final label1Point = _angleToPoint(
        separatorArc[sweepAngle] / 2 - separatorArc[sweepAngle] / 5,
        separatorRect.width / 2,
        circleCenter);

    final label2Point = _angleToPoint(
        separatorArc[sweepAngle] / 2 - separatorArc[sweepAngle] / 5 * 2,
        separatorRect.width / 2,
        circleCenter);

    final label3Point = _angleToPoint(
        separatorArc[sweepAngle] / 2 - separatorArc[sweepAngle] / 5 * 3,
        separatorRect.width / 2,
        circleCenter);

    final label4Point = _angleToPoint(
        separatorArc[sweepAngle] / 2 - separatorArc[sweepAngle] / 5 * 4,
        separatorRect.width / 2,
        circleCenter);

    canvas.drawCircle(label1Point, 10, firstArcPaint);
    canvas.drawCircle(label2Point, 10, secondArcPaint);
    canvas.drawCircle(label3Point, 10, thirdArcPaint);
    canvas.drawCircle(label4Point, 10, fourthArcPaint);

    final label1Painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: [
            TextSpan(text: 'Patricia\n', style: CustomTextTheme.smallNames),
            TextSpan(text: 'R\$ 1.800,99', style: CustomTextTheme.subtitle2),
          ],
        ));
    label1Painter.layout();
    label1Painter.paint(canvas,
        Offset(label1Point.dx + 20, label1Point.dy - label1Painter.height / 2));

    final label2Painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: [
            TextSpan(text: 'Luisa\n', style: CustomTextTheme.smallNames),
            TextSpan(text: 'R\$ 1.340,00', style: CustomTextTheme.subtitle2),
          ],
        ));
    label2Painter.layout();
    label2Painter.paint(canvas,
        Offset(label2Point.dx + 20, label2Point.dy - label2Painter.height / 2));

    final label3Painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: [
            TextSpan(text: 'Marcos\n', style: CustomTextTheme.smallNames),
            TextSpan(text: 'R\$ 800,23', style: CustomTextTheme.subtitle2),
          ],
        ));
    label3Painter.layout();
    label3Painter.paint(canvas,
        Offset(label3Point.dx + 20, label3Point.dy - label3Painter.height / 2));

    final label4Painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: [
            TextSpan(text: 'Gabriel\n', style: CustomTextTheme.smallNames),
            TextSpan(text: 'R\$200,10', style: CustomTextTheme.subtitle2),
          ],
        ));
    label4Painter.layout();
    label4Painter.paint(canvas,
        Offset(label4Point.dx + 20, label4Point.dy - label4Painter.height / 2));
  }

  @override
  bool shouldRepaint(PersonalGastoPainter oldDelegate) => true;
}
