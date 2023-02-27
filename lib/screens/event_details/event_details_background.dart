import 'package:flutter/material.dart';
import 'package:local_events/models/event.dart';
import 'package:provider/provider.dart';

class EventDetailsBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final evento = Provider.of<Event>(context);

    return Align(
      alignment: Alignment.topCenter,
      child: Hero(
        tag: evento,
        child: Container(
          child: Image.network(
            evento.imagePath,
            fit: BoxFit.cover,
            height: screenHeight * 0.4,
            width: screenWidth,
            color: Color(0x99000000),
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartingPoint = Offset(0, 40);
    Offset curveEndPoint = Offset(size.width, size.height * 0.95);
    path.lineTo(curveStartingPoint.dx, curveStartingPoint.dy - 5);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.85,
        curveEndPoint.dx - 60, curveEndPoint.dy + 10);
    path.quadraticBezierTo(size.width * 0.99, size.height * 0.99,
        curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
