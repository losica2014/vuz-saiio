import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saiio_lab/lab4/lpp_model.dart';

import 'shader.dart';

class LPPPainter extends CustomPainter {
  final LPPModel model;

  final double scale;

  LPPPainter({required this.model, this.scale = 1});

  @override
  void paint(Canvas canvas, Size size) {
    double factor = 10 * scale;
    
    final constraintsPaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 0.1
    ..strokeCap = StrokeCap.round;

    final axesPaint = Paint()
    ..color = Colors.red;

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
    // canvas.translate(200, -200);
    canvas.scale(factor, -factor);

    final limitX = size.width / factor;
    final limitY = size.height / factor;

    final points = <Offset>{};

    for(double i = 0; i < max(limitX, limitY).ceil(); i++) {
      canvas.drawLine(Offset(i, 0), Offset(i, limitY), axesPaint..strokeWidth = (i % 10 == 0) ? 0.05 : 0.02);
      canvas.drawLine(Offset(0, i), Offset(limitX, i), axesPaint..strokeWidth = (i % 10 == 0) ? 0.05 : 0.02);
    }

    drawSolution(canvas, limitX, limitY);

    for(int i = 0; i < model.constraints.length; i++) {
      final constraint = model.constraints[i];
      final constraintValue = model.constraintValues[i];

      Offset p1 = Offset(0, constraintValue/constraint[1]);
      Offset p2 = Offset(constraintValue/constraint[0], 0);

      // print("Boundaries of ${constraint.toString()}=$constraintValue: ${p1.toString()} - ${p2.toString()}");

      if(!p1.isFinite) {
        p1 = Offset(0, limitY);
      }
      if(!p2.isFinite) {
        p2 = Offset(limitX, 0);
      }

      final a1 = -constraint[0]/constraint[1];
      final b1 = constraintValue/constraint[1];

      canvas.drawLine(p1, p2, constraintsPaint);

      for(int j = 0; j < model.constraints.length; j++) {
        if(i == j) continue;
        final constraint2 = model.constraints[j];
        final constraintValue2 = model.constraintValues[j];

        final a2 = -constraint2[0]/constraint2[1];
        final b2 = constraintValue2/constraint2[1];

        Offset? intersectionPoint = _calculateIntersectionPoint(a1, b1, a2, b2);

        if(constraint2[1] == 0) {
          intersectionPoint = Offset(0, b1);
        }

        if(constraint[1] == 0) {
          intersectionPoint = Offset(0, b2);
        }

        if(intersectionPoint != null && intersectionPoint.isFinite) {
          // print("Intersection of ${constraint.toString()}=$constraintValue and ${constraint2.toString()}=$constraintValue2: ${intersectionPoint.toString()}");
          points.add(intersectionPoint);
        } else {
          // print("No intersection of ${constraint.toString()}=$constraintValue and ${constraint2.toString()}=$constraintValue2: ${intersectionPoint.toString()}");
        }
      }
    }
    
    final p1 = Offset(0, model.targetValue/model.targetEquation[1]);
    final p2 = Offset(model.targetValue/model.targetEquation[0], 0);
    canvas.drawLine(p1, p2, targetPaint);

    final targetPoints = <Offset>{};

    for(int i = 0; i < model.constraints.length; i++) {
      final constraint = model.constraints[i];
      final constraintValue = model.constraintValues[i];

      Offset? intersectionPoint = _calculateIntersectionPoint(-constraint[0]/constraint[1], constraintValue/constraint[1], -model.targetEquation[0]/model.targetEquation[1], model.targetValue/model.targetEquation[1]);

      if(model.targetEquation[1] == 0) {
        intersectionPoint = Offset(0, constraintValue/constraint[1]);
      }

      if(constraint[1] == 0) {
        intersectionPoint = Offset(0, model.targetValue/model.targetEquation[1]);
      }

      if(intersectionPoint != null && intersectionPoint.isFinite) {
        // print("Intersection of ${constraint.toString()}=$constraintValue and ${targetEquation.toString()}=$targetValue: ${intersectionPoint.toString()}");
        targetPoints.add(intersectionPoint);
      } else {
        // print("No intersection of ${constraint.toString()}=$constraintValue and ${targetEquation.toString()}=$targetValue: ${intersectionPoint.toString()}");
      }
    }

    canvas.drawPoints(PointMode.points, points.toList(), intersectionPaint);
    canvas.drawPoints(PointMode.points, targetPoints.toList(), targetIntersectionPaint);
  }

  @override
  bool shouldRepaint(LPPPainter oldDelegate) {
    return oldDelegate.model != model
    || oldDelegate.scale != scale;
  }

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

  void drawSolution(Canvas canvas, limitX, limitY) {
    final shader = lab4Shader.fragmentShader();

    final color = Colors.orange.withAlpha(127);

    shader.setFloat(0, color.r * color.a);
    shader.setFloat(1, color.g * color.a);
    shader.setFloat(2, color.b * color.a);
    shader.setFloat(3, color.a);
    shader.setFloat(4, model.constraints.length.toDouble());
    for(int i = 0; i < model.constraints.length; i++) {
      bool shouldInvert = [Sign.greater, Sign.greaterOrEqual].contains(model.constraintSigns[i]);
      shader.setFloat(5 + i * 3, model.constraints[i][0] * (shouldInvert ? -1 : 1));
      shader.setFloat(5 + i * 3 + 1, model.constraints[i][1] * (shouldInvert ? -1 : 1));
      shader.setFloat(5 + i * 3 + 2, model.constraintValues[i] * (shouldInvert ? -1 : 1));
    }

    canvas.drawRect(Offset.zero & Size(limitX, limitY), Paint()..shader = shader);
  }
}