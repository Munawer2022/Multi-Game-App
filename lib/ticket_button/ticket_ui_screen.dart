import 'package:animation/ticket_button/ticket_painter.dart';
import 'package:flutter/material.dart';

class TicketUiScreen extends StatelessWidget {
  TicketUiScreen({Key? key}) : super(key: key);
  var color = Colors.brown;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100.withOpacity(.3),
      body: SafeArea(
          child: Container(
        height: 220,
        margin: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter:
              TicketPainter(borderColor: Colors.black, bgColor: Colors.white),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DEA-HYD',
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'BH07',
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$140',
                      style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'May 30, 2022',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                      child: Icon(
                        color: color,
                        Icons.circle_outlined,
                        size: 18,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomPaint(
                                // painter: HorizontalDottedLinePainter(),
                                size: const Size(double.infinity, 1),
                              ),
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/horse_num.png',
                              color: Colors.white,
                              scale: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 8, 4),
                      child: Icon(
                        color: color,
                        Icons.circle_outlined,
                        size: 18,
                      ),
                    ),
                    Text(
                      'May 30, 2022',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '10:40AM',
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '1h 30m',
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '12:50AM',
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Indigo',
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Text(
                          'Cheapest',
                          style: TextStyle(
                            color: color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
