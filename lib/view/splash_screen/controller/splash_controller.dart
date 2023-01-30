import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simfonie/view/bottom_navigation/BottomNavScreen.dart';

class SplashController extends GetxController {
  Future<void> gotoBottomNavigation(BuildContext context) async {
    Timer(const Duration(seconds: 7), () {
      Get.off(const ScreenHome());
    });
  }
}
