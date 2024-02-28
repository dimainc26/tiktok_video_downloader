// ignore_for_file: unused_import, unnecessary_overrides

import 'dart:async';

import 'package:tikidown/CORE/core.dart';

class TutorController extends GetxController {
  RxInt currentStep = 0.obs;
  tapped(int step) {
    currentStep.value = step;
  }

  continued() {
    currentStep.value < 2 ? currentStep.value += 1 : null;
    if (currentStep.value == 2) {
      Timer(const Duration(seconds: 6), () {
        Get.back();
      });
    }
  }

  cancel() {
    currentStep.value > 0 ? currentStep.value -= 1 : null;
  }

  @override
  void onInit() {
    super.onInit();
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
