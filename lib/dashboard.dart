import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dahboard extends StatelessWidget {
  const Dahboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   actions: [
        //     IconButton(
        //         onPressed: () {}, icon: Icon(CupertinoIcons.cart_badge_plus))
        //   ],
        // ),
        body: Center(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/game.png',
                // color:
                //     const Color.fromRGBO(255, 255, 255, 0.5).withOpacity(0.3),
                // colorBlendMode: BlendMode.modulate,
                height: 1200,
                width: 1200,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.cart_badge_plus),
                    color: Colors.white,
                    iconSize: 50,
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(60),
                        onTap: () {},
                        child: CircleAvatar(
                            radius: 60,
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/images/horse.png'))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(60),
                        onTap: () {},
                        child: CircleAvatar(
                            radius: 60,
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/images/cat.png'))),
                      )
                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(60),
                    onTap: () {},
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.3),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/wheel.jpeg'))),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.8),
                    child: Center(
                      child: Text(
                        'Game Zone',
                        style: GoogleFonts.bahiana()
                            .copyWith(fontSize: 70, color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
