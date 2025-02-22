import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class LPPPainter extends CustomPainter {
  List<double> targetEquation;
  double targetValue;
  List<List<double>> constraints;
  List<Sign> constraintSigns;
  List<double> constraintValues;

  LPPPainter({required this.targetEquation, required this.targetValue, required this.constraints, required this.constraintSigns, required this.constraintValues});

  @override
  void paint(Canvas canvas, Size size) {
    double factor = 10;
    final constraintsPaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 0.1
    ..strokeCap = StrokeCap.round;

    final axesPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 0.05
    ..strokeCap = StrokeCap.round;

    final targetPaint = Paint()
    ..color = Colors.green
    ..strokeWidth = 0.1
    ..strokeCap = StrokeCap.round;

    final intersectionPaint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 0.2;

    final targetIntersectionPaint = Paint()
    ..color = Colors.pink
    ..strokeWidth = 0.2;

    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.translate(0, size.height);
    canvas.translate(200, -200);
    canvas.scale(factor, -factor);

    final limitX = size.width / factor;
    final limitY = size.height / factor;

    // canvas.drawLine(Offset(0, 0), Offset(size.width, 0), axesPaint);
    // canvas.drawLine(Offset(0, 0), Offset(0, size.height), axesPaint);

    final points = <Offset>{};
    final polygon = <Offset>[
      Offset(0, 0),
      Offset(limitX, 0),
      Offset(limitX, limitY),
      Offset(0, limitY),
    ];

    for(double i = 0; i < 10; i++) {
      canvas.drawLine(Offset(i, 0), Offset(i, limitY), axesPaint);
      canvas.drawLine(Offset(0, i), Offset(limitX, i), axesPaint);
    }

    for(int i = 0; i < constraints.length; i++) {
      final constraint = constraints[i];
      final constraintSign = constraintSigns[i];
      final constraintValue = constraintValues[i];

      Offset p1 = Offset(0, min(constraintValue/constraint[1], limitY));
      Offset p2 = Offset(min(constraintValue/constraint[0], limitX), 0);

      print("Boundaries of ${constraint.toString()}=$constraintValue: ${p1.toString()} - ${p2.toString()}");

      if(!p1.isFinite) {
        p1 = Offset(0, limitY);
      }
      if(!p2.isFinite) {
        p2 = Offset(limitX, 0);
      }

      final a1 = -constraint[0]/constraint[1];
      final b1 = constraintValue/constraint[1];

      if(p1.dx < p2.dx && [Sign.greater, Sign.greaterOrEqual].contains(constraintSign) || p1.dx > p2.dx && [Sign.less, Sign.lessOrEqual].contains(constraintSign)) {
        (p1, p2) = (p2, p1);
      }
      
      int pos = 0;
      int? cutoffStartPos;
      Offset start, end;
      int protection = 0;
      while(pos < polygon.length && protection < 100) {
        protection++;
        start = polygon[pos];
        end = polygon[(pos + 1) % polygon.length];

        final a2 = (end.dy - start.dy)/(end.dx - start.dx);
        final b2 = start.dy - a2 * start.dx;

        Offset? intersectionPoint = _calculateIntersectionPoint(a1, b1, a2, b2);

        if(intersectionPoint == null || !intersectionPoint.isFinite) {
          pos++;
          continue;
        }

        if(cutoffStartPos == null) {
          polygon.insert(pos + 1, intersectionPoint);
          cutoffStartPos = pos + 1;
          pos += 2;
        } else {
          polygon.removeRange(cutoffStartPos + 1, pos + 1);
          polygon.insert(cutoffStartPos + 1, intersectionPoint);
          pos = cutoffStartPos + 1;
          cutoffStartPos = null;
        }
      }
      print(polygon);

      canvas.drawLine(p1, p2, constraintsPaint);

      for(int j = 0; j < constraints.length; j++) {
        if(i == j) continue;
        final constraint2 = constraints[j];
        final constraintValue2 = constraintValues[j];

        final a2 = -constraint2[0]/constraint2[1];
        final b2 = constraintValue2/constraint2[1];

        Offset? intersectionPoint = _calculateIntersectionPoint(a1, b1, a2, b2);

        if(constraint2[1] == 0)
          intersectionPoint = Offset(0, b1);

        if(constraint[1] == 0)
          intersectionPoint = Offset(0, b2);

        if(intersectionPoint != null && intersectionPoint.isFinite) {
          // print("Intersection of ${constraint.toString()}=$constraintValue and ${constraint2.toString()}=$constraintValue2: ${intersectionPoint.toString()}");
          points.add(intersectionPoint);
        } else {
          // print("No intersection of ${constraint.toString()}=$constraintValue and ${constraint2.toString()}=$constraintValue2: ${intersectionPoint.toString()}");
        }
      }
    }
    
    final p1 = Offset(0, targetValue/targetEquation[1]);
    final p2 = Offset(targetValue/targetEquation[0], 0);
    canvas.drawLine(p1, p2, targetPaint);

    final targetPoints = <Offset>{};

    for(int i = 0; i < constraints.length; i++) {
      final constraint = constraints[i];
      final constraintSign = constraintSigns[i];
      final constraintValue = constraintValues[i];

      Offset? intersectionPoint = _calculateIntersectionPoint(-constraint[0]/constraint[1], constraintValue/constraint[1], -targetEquation[0]/targetEquation[1], targetValue/targetEquation[1]);

      if(targetEquation[1] == 0)
        intersectionPoint = Offset(0, constraintValue/constraint[1]);

      if(constraint[1] == 0)
        intersectionPoint = Offset(0, targetValue/targetEquation[1]);

      if(intersectionPoint != null && intersectionPoint.isFinite) {
        // print("Intersection of ${constraint.toString()}=$constraintValue and ${targetEquation.toString()}=$targetValue: ${intersectionPoint.toString()}");
        targetPoints.add(intersectionPoint);
      } else {
        // print("No intersection of ${constraint.toString()}=$constraintValue and ${targetEquation.toString()}=$targetValue: ${intersectionPoint.toString()}");
      }
    }

    // final a1 = -targetEquation[0]/targetEquation[1];
    // final b1 = targetValue/targetEquation[1];
    // int pos = 0;
    // int? cutoffStartPos;
    // Offset start, end;
    // int protection = 0;
    // while(pos < polygon.length && protection < 100) {
    //   protection++;
    //   start = polygon[pos];
    //   end = polygon[(pos + 1) % polygon.length];

    //   final a2 = (end.dy - start.dy)/(end.dx - start.dx);
    //   final b2 = start.dy - a2 * start.dx;

    //   Offset? intersectionPoint = _calculateIntersectionPoint(a1, b1, a2, b2);

    //   if(intersectionPoint == null || !intersectionPoint.isFinite) {
    //     pos++;
    //     continue;
    //   }

    //   if(cutoffStartPos == null) {
    //     polygon.insert(pos + 1, intersectionPoint);
    //     cutoffStartPos = pos + 1;
    //     pos += 2;
    //   } else {
    //     polygon.removeRange(cutoffStartPos + 1, pos + 1);
    //     polygon.insert(cutoffStartPos + 1, intersectionPoint);
    //     pos = cutoffStartPos + 1;
    //     cutoffStartPos = null;
    //   }
    // }

    canvas.drawPoints(PointMode.points, points.toList(), intersectionPaint);
    canvas.drawPoints(PointMode.points, targetPoints.toList(), targetIntersectionPaint);

    canvas.drawPath(Path()..addPolygon(polygon, true), Paint()..color = Colors.blue.withAlpha(100));
    canvas.drawPoints(PointMode.points, polygon, Paint()..color = Colors.orange..strokeWidth = 0.3);
  }

  @override
  bool shouldRepaint(covariant LPPPainter oldDelegate) {
    return oldDelegate.constraints != constraints || oldDelegate.targetEquation != targetEquation || oldDelegate.targetValue != targetValue || oldDelegate.constraintSigns != constraintSigns || oldDelegate.constraintValues != constraintValues;
  }

  // /// coef1 * x + coef2 * y = target
  // /// y = (target - coef1 * x) / coef2
  // double _calculate(double x, double coef1, double coef2, double targetValue) {
  //   if(coef2 == 0) return 999;
  //   return (targetValue - x * coef1) / coef2;
  // }

  /// f(x) = a1 * x + b1,
  /// g(x) = a2 * x + b2.
  Offset? _calculateIntersectionPoint(double a1, double b1, double a2, double b2) {
    if(a1 == a2) return null;
    double x = (b2 - b1) / (a1 - a2);
    return Offset(
      x,
      a1 * x + b1
    );
  }
}

enum Sign {equal, less, greater, lessOrEqual, greaterOrEqual}