import 'package:flutter/material.dart';

class HourseRunning extends StatefulWidget {
  const HourseRunning({super.key});

  @override
  State<HourseRunning> createState() => _HourseRunningState();
}

class _HourseRunningState extends State<HourseRunning> {
  Offset _end = Offset(600, 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 650,
              child: Image.asset(
                'assets/images/line.png',
                scale: 5,
                // color: Colors.red,
              ),
            ),
            TweenAnimationBuilder(
              tween: BezierTween(
                  begin: Offset(0, 0), control: Offset(0, 0), end: _end),
              duration: Duration(seconds: 4),
              builder: (BuildContext context, Offset value, Widget? child) {
                return Positioned(
                  left: value.dx,
                  top: value.dy,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text('99'),
                          Image.asset(
                            'assets/images/horse.gif',
                            // color: Colors.red,
                            scale: 10,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: value.dx * 1),
                        child: Column(
                          children: [
                            Text('11'),
                            Image.asset(
                              'assets/images/horse.gif',
                              // color: Colors.amber,
                              scale: 10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: value.dx * 1),
                        child: Column(
                          children: [
                            Text('03'),
                            Image.asset(
                              'assets/images/horse.gif',
                              // color: Colors.green,
                              scale: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _end = Offset.zero;
            });
          },
        ),
      ),
    );
  }
}

class BezierTween extends Tween<Offset> {
  final Offset begin;
  final Offset end;
  final Offset control;

  BezierTween({required this.begin, required this.end, required this.control})
      : super(begin: begin, end: end);

  @override
  Offset lerp(double t) {
    final t1 = 1 - t;
    return begin * t1 * t1 + control * 2 * t1 * t + end * t * t;
  }
}
// Positioned(
//                   left: value.dx,
//                   top: value.dy,
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         'assets/images/horse.gif',
//                         // color: Colors.red,
//                         scale: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 50),
//                         child: Image.asset(
//                           'assets/images/horse.gif',
//                           // color: Colors.amber,
//                           scale: 10,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 50),
//                         child: Image.asset(
//                           'assets/images/horse.gif',
//                           // color: Colors.amber,
//                           scale: 10,
//                         ),
//                       )
//                     ],
//                   ),
//                 );