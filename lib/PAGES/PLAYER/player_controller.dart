import 'dart:io';
import 'dart:ui';

import '/CORE/core.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends GetxController {
  dynamic videoData;
  final String labelSign = "\u00A9 by TikiDowns";

  late VideoPlayerController videoPlayerController;
  RxBool pausedContent = false.obs;

  Duration animationDuration = const Duration(milliseconds: 300);
  RxBool disableClick = false.obs;
  RxList list = [].obs;
  RxInt index = 0.obs;

  RxBool goRefresh = false.obs;

  @override
  void onInit() {
    super.onInit();
    list = Get.arguments["list"];
    index.value = Get.arguments["index"];
    videoData = list[index.value];
    initializeVideo();
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
  }

  initializeVideo() async {
    if (videoData["path"] != null) {
      videoPlayerController =
          VideoPlayerController.file(File(list[index.value]["path"]))
            ..initialize().then((_) async {
              goRefresh.value = true;
              videoPlayerController.play();
              pausedContent.value = false;
              videoPlayerController.addListener(() {
                if (videoPlayerController.value.position ==
                    videoPlayerController.value.duration) {
                  // Get.back();
                }
              });
            });
    }
  }

  nextVideo() async {
    if (list.length - 1 > index.value) {
      goRefresh.value = false;
      index.value = index.value + 1;
      videoPlayerController.dispose();
      await initializeVideo();
    }
  }

  prevVideo() async {
    if (index.value > 0) {
      goRefresh.value = false;
      index.value = index.value - 1;
      videoPlayerController.dispose();
      await initializeVideo();
    }
  }

  loopVideo() {
    videoPlayerController.addListener(() {
      // if (videoPlayerController.value.position ==
      //     videoPlayerController.value.duration) {
      //   videoPlayerController.play();
      // }
      videoPlayerController.setLooping(true);
    });
  }

  musicBackground() {
    // if (videoPlayerController.value.isPlaying) {
    //   Get.back();
    // }
  }

  onOffVolume() {
    if (videoPlayerController.value.volume > 0.0) {
      videoPlayerController.setVolume(0.0);
    } else {
      videoPlayerController.setVolume(0.5);
    }
    pausedContent.value = false;
    videoPlayerController.play();
  }

  formattedTime() {
    int sec = videoPlayerController.value.duration.inSeconds % 60;
    int min = (videoPlayerController.value.duration.inSeconds / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  disableTouch() {
    disableClick.value = !disableClick.value;
    pausedContent.value = false;
    videoPlayerController.play();
  }

  shareFile() async {
    await Share.shareXFiles([XFile(videoData["path"])], text: labelSign);
  }

  details({required details}) {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width,
          height: Get.height / 2.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white38,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: 50,
                    // padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      "title: ${details["title"]}",
                      style: miniTitle.copyWith(
                          decoration: TextDecoration.none,
                          fontSize: 24,
                          color: white,
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    width: Get.width - 12,
                    height: 2,
                    color: firstColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.network(
                          details["avatar"],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              width: Get.width - 200,
                              height: 50,
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                "name: ${details["name"]}",
                                style: miniTitle.copyWith(
                                    decoration: TextDecoration.none,
                                    color: white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: Get.width - 200,
                              height: 50,
                              child: Text(
                                "username: ${details["username"]}",
                                style: miniTitle.copyWith(
                                    decoration: TextDecoration.none,
                                    color: white),
                              ),
                            ),
                            SizedBox(
                              width: Get.width - 200,
                              height: 50,
                              child: Row(
                                children: [
                                  SvgPicture.asset(settings_icon),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                      details["country"] ?? "World",
                                      style: miniTitle.copyWith(
                                          color: firstColor, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: Get.width - 24,
                    height: 2,
                    color: firstColor,
                    margin: const EdgeInsets.only(right: 12),
                  ),
                  Image.asset(
                    logoImg,
                    width: 70,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
