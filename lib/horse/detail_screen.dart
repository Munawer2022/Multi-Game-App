import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neopop/utils/color_utils.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);

    return Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      )),

                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: sized.size.height * 0.7,
                  //400
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Container(
                    height: double.infinity,
                    width: double.infinity,
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.2, 0.8, 1],
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/detail_horse.jpg',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // collapseMode: CollapseMode.parallax,

                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(100.0),
                    child: Transform.translate(
                      offset: const Offset(0, 50),
                      child: Column(children: [
                        Padding(
                          padding: bidHorsePadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Wednesday Horse',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: false,
                                      style: theme.textTheme.headline4
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)
                                      // ?.copyWith(color: Colors.black87),
                                      ),
                                  Text(
                                    'data',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Container(
                                width: 90.0,
                                height: 90.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(
                                      width: 1.0, color: Colors.white),
                                ),
                                child: const Center(
                                    child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  child: Center(
                                      child: Text(
                                    '36',
                                    style: TextStyle(
                                        fontSize: 45,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: sized.size.height * 0.05,
                  ),
                  Text(
                    'data',
                    style: TextStyle(color: Colors.white),
                  )
                  // Padding(
                  //   padding: bidHorsePadding,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text('Wednesday Horse'),
                  //       Container(
                  //         width: 90.0,
                  //         height: 90.0,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(100.0),
                  //           border: Border.all(width: 1.0, color: Colors.blue),
                  //         ),
                  //         child: const Center(
                  //             child: CircleAvatar(
                  //           radius: 40,
                  //           child: Center(
                  //               child: Text(
                  //             '36',
                  //             style: TextStyle(
                  //                 fontSize: 45, fontWeight: FontWeight.bold),
                  //           )),
                  //         )),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ]),
              ),
            )));
  }
}

var bidHorsePadding = const EdgeInsets.symmetric(horizontal: 15);
Color bidHorseColor = Colors.brown.withOpacity(0.7);
