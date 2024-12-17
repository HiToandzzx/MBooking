import 'package:flutter/material.dart';

class TicketSeparator extends StatelessWidget {
  const TicketSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allow children to overflow the stack
      alignment: Alignment.center,
      children: [
        // Dashed horizontal line
        Container(
          width: double.infinity,
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: CustomPaint(
            painter: DashedLinePainter(),
          ),
        ),

        // Left circle
        Positioned(
          left: -35, // Push the circle outside the left edge
          child: ClipOval(
            child: Container(
              width: 40,
              height: 40,
              color: Colors.black,
            ),
          ),
        ),

        // Right circle
        Positioned(
          right: -35, // Push the circle outside the right edge
          child: ClipOval(
            child: Container(
              width: 40,
              height: 40,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    var max = size.width;
    var dashWidth = 5;
    var dashSpace = 3;
    double startX = 0;

    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}