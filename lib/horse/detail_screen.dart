import 'dart:async';

import 'package:animation/dashboard.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:neopop/utils/color_utils.dart';
import 'package:provider/provider.dart';

import '../navigate.dart';
import 'horse_bid.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);

    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  AppNavigator().push(context, const Dahboard());
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: Colors.white,
                )),

            automaticallyImplyLeading: false,
            pinned: false,
            expandedHeight: sized.size.height * 0.6,
            //400
            forceElevated: innerBoxIsScrolled,
            flexibleSpace: Container(
              height: double.infinity,
              width: double.infinity,
              foregroundDecoration: const BoxDecoration(
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
              preferredSize: const Size.fromHeight(60.0),
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
                            Text('You Won',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: false,
                                style: theme.textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)
                                // ?.copyWith(color: Colors.black87),
                                ),
                            Text('Wednesday Horse Race',
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(color: Colors.white))
                          ],
                        ),
                        Container(
                          width: 90.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(width: 1.0, color: Colors.white),
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
          child: Column(
            children: [
              SizedBox(
                height: sized.size.height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    scale: 22,
                  ),
                  SizedBox(width: sized.size.width * 0.01),
                  Countup(
                      begin: 0,
                      end: 500,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      duration: const Duration(milliseconds: 500),
                      separator: ',',
                      style: theme.textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  // Text('500',
                  //     style: theme.textTheme.headline4?.copyWith(
                  //         fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              SizedBox(
                height: sized.size.height * 0.01,
              ),
              SizedBox(
                  height: sized.size.height * 0.07,
                  child: const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                  )),
              SizedBox(
                height: sized.size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    scale: 22,
                  ),
                  SizedBox(width: sized.size.width * 0.01),
                  Text('+',
                      style: theme.textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(width: sized.size.width * 0.01),
                  Countup(
                      begin: 0,
                      end: 1000,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      duration: const Duration(milliseconds: 500),
                      separator: ',',
                      style: theme.textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  // Text('+ 1000',
                  //     style: theme.textTheme.headline4?.copyWith(
                  //         fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              SizedBox(
                height: sized.size.height * 0.03,
              ),
              Padding(
                padding: bidHorsePadding,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            theme.primaryColor.withOpacity(0.7))),
                    onPressed: () {
                      // AppNavigator().push(context, const HorseBid());
                    },
                    label: Text(
                      'Again ?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    icon: Icon(
                      Icons.settings_backup_restore_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

var bidHorsePadding = const EdgeInsets.symmetric(horizontal: 15);
Color bidHorseColor = Colors.brown.withOpacity(0.7);
