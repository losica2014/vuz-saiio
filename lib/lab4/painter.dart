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
    double factor = 100;
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

    final points = <Offset>{};

    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.translate(0, size.height);
    // canvas.translate(200, -200);
    canvas.scale(factor, -factor);

    // canvas.drawLine(Offset(0, 0), Offset(size.width, 0), axesPaint);
    // canvas.drawLine(Offset(0, 0), Offset(0, size.height), axesPaint);

    for(double i = 0; i < 10; i++) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), axesPaint);
      canvas.drawLine(Offset(0, i), Offset(size.width, i), axesPaint);
    }

    for(int i = 0; i < constraints.length; i++) {
      final constraint = constraints[i];
      final constraintSign = constraintSigns[i];
      final constraintValue = constraintValues[i];

      Offset p1 = Offset(0, min(constraintValue/constraint[1], 1000));
      Offset p2 = Offset(min(constraintValue/constraint[0], 1000), 0);

      print("Boundaries of ${constraint.toString()}=$constraintValue: ${p1.toString()} - ${p2.toString()}");

      if(!p1.isFinite) {
        p1 = Offset(0, 1000);
      }
      if(!p2.isFinite) {
        p2 = Offset(1000, 0);
      }

      canvas.drawLine(p1, p2, constraintsPaint);

      for(int j = 0; j < constraints.length; j++) {
        if(i == j) continue;
        final constraint2 = constraints[j];
        final constraintValue2 = constraintValues[j];

        Offset? intersectionPoint = _calculateIntersectionPoint(-constraint[0]/constraint[1], constraintValue/constraint[1], -constraint2[0]/constraint2[1], constraintValue2/constraint2[1]);

        if(constraint2[1] == 0)
          intersectionPoint = Offset(0, constraintValue/constraint[1]);

        if(constraint[1] == 0)
          intersectionPoint = Offset(0, constraintValue2/constraint2[1]);

        if(intersectionPoint != null && intersectionPoint.isFinite) {
          print("Intersection of ${constraint.toString()}=$constraintValue and ${constraint2.toString()}=$constraintValue2: ${intersectionPoint.toString()}");
          points.add(intersectionPoint);
        } else {
          print("No intersection of ${constraint.toString()}=$constraintValue and ${constraint2.toString()}=$constraintValue2: ${intersectionPoint.toString()}");
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
        print("Intersection of ${constraint.toString()}=$constraintValue and ${targetEquation.toString()}=$targetValue: ${intersectionPoint.toString()}");
        targetPoints.add(intersectionPoint);
      } else {
        print("No intersection of ${constraint.toString()}=$constraintValue and ${targetEquation.toString()}=$targetValue: ${intersectionPoint.toString()}");
      }
    }

    canvas.drawPoints(PointMode.points, points.toList(), intersectionPaint);
    canvas.drawPoints(PointMode.points, targetPoints.toList(), targetIntersectionPaint);
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