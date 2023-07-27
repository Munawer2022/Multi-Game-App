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
                  flexibleSpace: Image.asset(
                    'assets/images/horse_bid_back.jpg',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // title: const Text('NestedScrollView'),
                  pinned: false,
                  expandedHeight: sized.size.height * 0.7,
                  //400
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: bidHorsePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Wednesday Horse'),
                      CircleAvatar(
                        radius: 40,
                        child: Center(
                            child: Text(
                          '36',
                          style: TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                ),
              ]),
            )));
  }
}

var bidHorsePadding = const EdgeInsets.symmetric(horizontal: 15);
Color bidHorseColor = Colors.brown.withOpacity(0.7);
