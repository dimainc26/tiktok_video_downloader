// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:developer';
import 'package:tikidown/CORE/core.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    readStorage();
  }

  RxInt videosLenght = 0.obs;
  RxInt coversLenght = 0.obs;
  RxInt musicsLenght = 0.obs;
  RxInt total = 0.obs;

  readStorage() {
    RxList<dynamic> datas = [].obs;
    if (box.hasData("dataList")) {
      datas.value = jsonDecode(box.read("dataList"));
      log(datas.toString());
      total.value = datas.length;
      videosLenght.value =
          datas.where((p) => p["type"] == ".mp4").toList().length;
      musicsLenght.value =
          datas.where((type) => type["type"] == ".mp3").toList().length;
      coversLenght.value =
          datas.where((type) => type["type"] == ".jpg").toList().length;
    } else {
      datas.value = [];
    }
  }

  tutorial() {
    Get.offNamed("/tutor");
  }

  Future<void> shareApp() async {
    const String appLink =
        'https://play.google.com/store/apps/details?id=inc.dima.tikidown';

    await Share.share(appLink);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
