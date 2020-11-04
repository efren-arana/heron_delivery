
import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controllPoint = Offset(size.height, 150);
    var endPoint = Offset(size.width, size.height / 4);
    var path = Path();

    path.moveTo(0, size.height - 100);
    //path.lineTo(size.height - 200, 0);

    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0, size.width * 1000);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}