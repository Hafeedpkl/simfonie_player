// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simfonie/view/bottom_navigation/view/BottomNavScreen.dart';
import 'package:simfonie/view/splash_screen/controller/splash_controller.dart';

class ScreenSplash extends StatelessWidget {
  SplashController splashController = Get.put(SplashController());
  ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    splashController.gotoBottomNavigation(context);
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
