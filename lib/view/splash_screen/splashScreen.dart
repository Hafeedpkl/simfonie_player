// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simfonie/view/bottom_navigation/BottomNavScreen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 7),
        (() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => ScreenHome())))));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 5, 39),
        body: SafeArea(
          child: Stack(children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/simfonie_image.png'),
                        const Text(
                          'make your life more live',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'poppins'),
                        )
                      ]),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/images/splashScreen_images/grouped_image.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
            Positioned(
                top: 200,
                left: 100,
                right: 100,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 40,
                      left: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 58,
                      ),
                    ),
                    Lottie.asset('assets/lottie/real-splash-animation.json',
                        height: 200),
                  ],
                ))
          ]),
        ));
  }
}
