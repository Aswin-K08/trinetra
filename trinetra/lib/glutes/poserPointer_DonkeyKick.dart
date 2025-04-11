import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:trinetraflutter/translator.dart';
import 'package:trinetraflutter/values.dart';

class PosePointer_DonkeyKick extends CustomPainter {
  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final int minangle;
  final int minangle2;
  final int maxangle;
  final int maxangle2;
  final PoseLandmarkType leftpos1;
  final PoseLandmarkType leftpos2;
  final PoseLandmarkType leftpos3;
  final PoseLandmarkType rightpos1;
  final PoseLandmarkType rightpos2;
  final PoseLandmarkType rightpos3;

  PosePointer_DonkeyKick(
    this.poses,
    this.absoluteImageSize,
    this.rotation,
    this.minangle,
    this.minangle2,
    this.maxangle,
    this.maxangle2,
    this.leftpos1,
    this.leftpos2,
    this.leftpos3,
    this.rightpos1,
    this.rightpos2,
    this.rightpos3,
  );

  @override
  void paint(Canvas canvas, Size size) {
    const double PI = 3.141592653589793238;
    Color color;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    final dot = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30.0
      ..color = Colors.yellow;

    for (var pose in poses) {
      final landmark1 = pose.landmarks[leftpos1]!; //hip
      final landmark2 = pose.landmarks[leftpos2]!; //knee
      final landmark3 = pose.landmarks[leftpos3]!; //ankle

      final landmark4 = pose.landmarks[rightpos1]!; //hip
      final landmark5 = pose.landmarks[rightpos2]!; //knee
      final landmark6 = pose.landmarks[rightpos3]!; //ankle

      angle = (atan2(landmark2.y - landmark3.y, landmark2.x - landmark3.x)) *
          180 ~/
          PI;
      angler = (atan2(landmark5.y - landmark6.y, landmark5.x - landmark6.x)) *
          180 ~/
          PI;

      if (angle < 0) {
        angle = angle + 360;
      }
      if (angler < 0) {
        angler = angler + 360;
      }
      print("Angle: $angle");
      print("Angler: $angler");
      if ((angle > 55 && angle < 75 && angler > 0 && angler < 20 && stage != "down") || (angle > 95 && angle < 115 && angler > 170 && angler < 190 && stage != "down")) {
        stage = "down";
        color = Colors.green;
      }
      if (stage == "down") {
        color = Colors.green;
        align = true;
      } else {
        color = Colors.deepPurple;
        align = false;
      }
      if ((angle > 0 && angle < 20 && angler > 55 && angler < 75 && stage == "down") || (angle > 170 && angle < 190 && angler > 95 && angler < 115 && stage == "down")) {
        counter++;
        stage = "up";
      }

      canvas.drawCircle(
        Offset(
          translateX(landmark1.x, rotation, size, absoluteImageSize),
          translateY(landmark1.y, rotation, size, absoluteImageSize),
        ),
        1,
        dot,
      );

      canvas.drawCircle(
        Offset(
          translateX(landmark2.x, rotation, size, absoluteImageSize),
          translateY(landmark2.y, rotation, size, absoluteImageSize),
        ),
        1,
        dot,
      );

      canvas.drawCircle(
        Offset(
          translateX(landmark3.x, rotation, size, absoluteImageSize),
          translateY(landmark3.y, rotation, size, absoluteImageSize),
        ),
        1,
        dot,
      );

      canvas.drawCircle(
        Offset(
          translateX(landmark4.x, rotation, size, absoluteImageSize),
          translateY(landmark4.y, rotation, size, absoluteImageSize),
        ),
        1,
        dot,
      );

      canvas.drawCircle(
        Offset(
          translateX(landmark5.x, rotation, size, absoluteImageSize),
          translateY(landmark5.y, rotation, size, absoluteImageSize),
        ),
        1,
        dot,
      );

      canvas.drawCircle(
        Offset(
          translateX(landmark6.x, rotation, size, absoluteImageSize),
          translateY(landmark6.y, rotation, size, absoluteImageSize),
        ),
        1,
        dot,
      );

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        PoseLandmark joint1 = pose.landmarks[type1]!;
        PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
          Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
              translateY(joint1.y, rotation, size, absoluteImageSize)),
          Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
              translateY(joint2.y, rotation, size, absoluteImageSize)),
          paintType,
        );
      }

      //Draw arms
      paintLine(leftpos1, leftpos2, paint..color = color);
      paintLine(leftpos2, leftpos3, paint);
      paintLine(rightpos1, rightpos2, paint..color = color);
      paintLine(rightpos2, rightpos3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant PosePointer_DonkeyKick oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
