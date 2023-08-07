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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  AppNavigator().push(context, const Dahboard());
                },
                icon: const Icon(
                  CupertinoIcons.right_chevron,
                  color: Colors.white,
                ))
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      backgroundColor: Colors.black87,
                      maxRadius: 40,
                      child: Icon(
                        CupertinoIcons.person_solid,
                        color: Colors.white,
                        size: 60,
                      )),
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
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                const Text(
                  'Transfer on Oct 21, 2023',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: sized.size.height * 0.05),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/coin.png',
                        scale: 15,
                      ),
                      SizedBox(width: sized.size.width * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Countup(
                              begin: 0,
                              end: 22.00,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              duration: const Duration(milliseconds: 500),
                              separator: ',',
                              style: theme.textTheme.headline1?.copyWith(
                                  fontFamily: 'BebasNeue',
                                  // fontStyle: FontStyle.italic,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(width: sized.size.width * 0.01),
                          const Text(
                            '/Available coin',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //  const Text(
                //       'Available coin',
                //       style: TextStyle(color: Colors.white, fontSize: 20),
                //     ),
                SizedBox(height: sized.size.height * 0.02),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: sized.size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'won coin',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 25,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 522,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'BebasNeue',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: sized.size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'loss coin',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 25,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 1000,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'BebasNeue',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: sized.size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'withdraw coin',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                scale: 25,
                              ),
                              SizedBox(width: sized.size.width * 0.01),
                              Countup(
                                  begin: 0,
                                  end: 500,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  duration: const Duration(milliseconds: 500),
                                  separator: ',',
                                  style: theme.textTheme.headline3?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'BebasNeue',
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sized.size.height * 0.02),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: sized.size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red.withOpacity(.7))),
                        onPressed: () {},
                        child: Text(
                          'Log out',
                          style: theme.textTheme.titleLarge?.copyWith(
                              fontFamily: 'BebasNeue', color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
