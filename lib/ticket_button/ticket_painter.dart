// import 'package:flutter/material.dart';

// class TicketPainter extends CustomPainter {
//   final Color borderColor;
//   final Color bgColor;

//   static const _cornerGap = 20.0;
//   static const _cutoutRadius = 20.0;
//   static const _cutoutDiameter = _cutoutRadius * 2;

//   TicketPainter({required this.bgColor, required this.borderColor});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final maxWidth = size.width;
//     final maxHeight = size.height;

//     final cutoutStartPos = maxHeight - maxHeight * 0.2;
//     final leftCutoutStartY = cutoutStartPos;
//     final rightCutoutStartY = cutoutStartPos - _cutoutDiameter;
//     final dottedLineY = cutoutStartPos - _cutoutRadius;
//     double dottedLineStartX = _cutoutRadius;
//     final double dottedLineEndX = maxWidth - _cutoutRadius;
//     const double dashWidth = 8.2;
//     const double dashSpace = 4;

//     final paintBg = Paint()
//       ..style = PaintingStyle.fill
//       ..strokeCap = StrokeCap.round
//       ..color = bgColor;

//     final paintBorder = Paint()
//       ..strokeWidth = 1
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round
//       ..color = borderColor;

//     final paintDottedLine = Paint()
//       ..color = borderColor.withOpacity(0.5)
//       ..strokeWidth = 1.2;

//     var path = Path();

//     path.moveTo(_cornerGap, 0);
//     path.lineTo(maxWidth - _cornerGap, 0);
//     _drawCornerArc(path, maxWidth, _cornerGap);
//     path.lineTo(maxWidth, rightCutoutStartY);
//     _drawCutout(path, maxWidth, rightCutoutStartY + _cutoutDiameter);
//     path.lineTo(maxWidth, maxHeight - _cornerGap);
//     _drawCornerArc(path, maxWidth - _cornerGap, maxHeight);
//     path.lineTo(_cornerGap, maxHeight);
//     _drawCornerArc(path, 0, maxHeight - _cornerGap);
//     path.lineTo(0, leftCutoutStartY);
//     _drawCutout(path, 0.0, leftCutoutStartY - _cutoutDiameter);
//     path.lineTo(0, _cornerGap);
//     _drawCornerArc(path, _cornerGap, 0);

//     canvas.drawPath(path, paintBg);
//     canvas.drawPath(path, paintBorder);

//     while (dottedLineStartX < dottedLineEndX) {
//       canvas.drawLine(
//         Offset(dottedLineStartX, dottedLineY),
//         Offset(dottedLineStartX + dashWidth, dottedLineY),
//         paintDottedLine,
//       );
//       dottedLineStartX += dashWidth + dashSpace;
//     }
//   }

//   _drawCutout(Path path, double startX, double endY) {
//     path.arcToPoint(
//       Offset(startX, endY),
//       radius: const Radius.circular(_cutoutRadius),
//       clockwise: false,
//     );
//   }

//   _drawCornerArc(Path path, double endPointX, double endPointY) {
//     path.arcToPoint(
//       Offset(endPointX, endPointY),
//       radius: const Radius.circular(_cornerGap),
//     );
//   }

//   @override
//   bool shouldRepaint(TicketPainter oldDelegate) => false;

//   @override
//   bool shouldRebuildSemantics(TicketPainter oldDelegate) => false;
// }
