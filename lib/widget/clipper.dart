import 'package:flutter/cupertino.dart';

class CharacterCardBGClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path p = Path();
    double curveDistance = 40;

    p.moveTo(0,size.height * 0.4);
    p.lineTo(0, size.height - curveDistance);
    p.quadraticBezierTo(1, size.height - 1, curveDistance, size.height);
    p.lineTo(size.width - curveDistance, size.height);
    p.quadraticBezierTo(size.width + 1, size.height - 1, size.width, size.height - curveDistance);
    p.lineTo(size.width, 0 + curveDistance);
    p.quadraticBezierTo(size.width - 1, 0, size.width - curveDistance - 5, 0 + curveDistance / 3);
    p.lineTo(curveDistance, size.height * 0.29);
    p.quadraticBezierTo(1, (size.height * 0.3) + 10, 0, size.height * 0.4);

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}