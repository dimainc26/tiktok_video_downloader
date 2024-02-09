// ignore_for_file: unnecessary_overrides

import 'dart:async';

import '/CORE/core.dart';

class SplashController extends GetxController {
  Duration duration = const Duration(milliseconds: 2500);

  next() {
    Timer(duration, () {
      Get.offNamed('/onboard');
    });
  }

  @override
  void onInit() {
    super.onInit();
    next();
  }

  loadData() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
