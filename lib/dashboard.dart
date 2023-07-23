import 'package:animation/hourse_running.dart';
import 'package:animation/text.dart';
import 'package:animation/wheel_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dahboard extends StatefulWidget {
  const Dahboard({super.key});

  @override
  State<Dahboard> createState() => _DahboardState();
}

class _DahboardState extends State<Dahboard> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            toolbarHeight: 120.0,
            centerTitle: true,
            title: Text(
              'Dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xff3F4373),
                    child: Center(child: Icon(CupertinoIcons.person)))),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Color(0xff3F4373),
                      child:
                          Center(child: Icon(CupertinoIcons.cart_badge_plus))))
            ],
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(255, 4, 9, 58),
                      Color(0xff05092C)
                    ]),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [Color(0xffE8E7F7), Color(0xff9E9FD2)],
                  radius: 0.75,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 4, 9, 58),
                                )),
                                onPressed: () {},
                                child: Text(
                                  'Real Money',
                                  style: TextStyle(color: Colors.white),
                                ))),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        // SizedBox(
                        //     height: 40,
                        //     width: 80,
                        //     child: ElevatedButton(
                        //         style: ButtonStyle(
                        //             backgroundColor: MaterialStateProperty.all(
                        //           Color.fromARGB(255, 4, 9, 58),
                        //         )),
                        //         onPressed: () {},
                        //         child: Text(
                        //           'Real Money',
                        //           style: TextStyle(color: Colors.white),
                        //         ))),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Sport Games',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Color.fromARGB(255, 4, 9, 58),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        container(context, 'assets/images/horse.jpg',
                            HorseRaceScreen()),
                        SizedBox(
                          width: 10,
                        ),
                        container(
                            context, 'assets/images/cat.jpg', MyHomePage()),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: container(
                            context, 'assets/images/wheel.jpeg', WheelGame())),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text('Version 1.0.0.1',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: Color.fromARGB(255, 4, 9, 58),
                                  fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget container(BuildContext context, image, page) {
  return InkWell(
    borderRadius: BorderRadius.circular(60),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: ExactAssetImage(image),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 143, 121, 175),
            blurRadius: 17,
            // offset: Offset(4, 8),
          ),
        ],
      ),
    ),
  );
}
