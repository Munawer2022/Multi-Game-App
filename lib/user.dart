import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'navigate.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var sized = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colors.blueAccent.shade100.withOpacity(.3),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                AppNavigator().push(context, const Dahboard());
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 43,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(height: sized.size.height * 0.02),
              Text('Riko Sipto Dimo',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: theme.textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white)
                  // ?.copyWith(color: Colors.black87),
                  ),
              SizedBox(height: sized.size.height * 0.03),
              const Text(
                '+92 10237 1798217',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Transfer on Oct 21, 2023',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(height: sized.size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/coin.png',
                    scale: 15,
                  ),
                  SizedBox(width: sized.size.width * 0.01),
                  Countup(
                      begin: 0,
                      end: 22.00,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      duration: const Duration(milliseconds: 500),
                      separator: ',',
                      style: theme.textTheme.headline1?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              const Text(
                'Available coin',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: sized.size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: sized.size.width * 0.3,
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 15,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: -22,
                                  end: 0,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                          const Text(
                            'Loss coin',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sized.size.width * 0.3,
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 15,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 20,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                          const Text(
                            'Withdraw coin',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sized.size.width * 0.3,
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 15,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 10,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline1?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                          const Text(
                            'Win coin',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
