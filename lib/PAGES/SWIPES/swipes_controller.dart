import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_video_downloader/MODELS/videos_class.dart';
import 'package:tiktok_video_downloader/MYPACKAGES/VerifyStorage.dart';
import 'package:tiktok_video_downloader/WIDGETS/popup.dart';

import '../../MODELS/VideoModel.dart';
import '../../MYPACKAGES/PhoneInfos.dart';
import '/CORE/core.dart';

class SwipeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Controllers
  late PageController pageController;
  late PageController downPageController;
  late TabController tabBarController;
  final linkController = TextEditingController();

  // Variables
  Duration duration = const Duration(milliseconds: 500);
  RxInt tabSelectedPage = 0.obs;
  RxInt currentIndicator = 0.obs;
  RxDouble downloadProgress = 0.0.obs;
  RxBool selectionMode = false.obs;
  RxBool downloading = false.obs;
  RxBool launchAnimation = false.obs;
  RxList filesList = [].obs;

  // Duration
  final Duration animationDuration = Duration(seconds: 1);

  // Class Instance
  VideoModel videoModel = VideoModel();
  GetMedia getMedia = GetMedia();
  PhoneInfos phoneInfos = PhoneInfos();
  VideoInfo? videoData = VideoInfo(url: "");

  // Storage
  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isFirstTime();
    pageController = PageController(initialPage: 0);
    tabBarController = TabController(length: 3, vsync: this, initialIndex: 0);
    downPageController = PageController(initialPage: tabSelectedPage.value);
    currentIndicator = pageController.initialPage.obs;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    linkController.dispose();
  }

  // Methods
  isFirstTime() async {
    final firstDataSave = jsonEncode(await getPhoneInfo());
    RxList dataList = [].obs;

    if (!box.hasData("isFirstTime")) {
      box.write("isFirstTime", false);
      box.writeIfNull("phone", firstDataSave).then((value) => box.save());
      box
          .writeIfNull("dataList", jsonEncode(dataList.value))
          .then((value) => box.save());
    }
  }

  Future<Map<String, dynamic>> getPhoneInfo() async {
    var phone = await phoneInfos.deviceInfos();
    phone.addAll({"photoPermission": false, "musicPrmission": false});
    // phone.entries.forEach((e) {
    //   log(e.toString());
    // });

    return phone;
  }

  shareApp() async {
    const String appLink =
        'https://play.google.com/store/apps/details?id=inc.dima.tikidown';
    const String message = 'Check out my new app: $appLink';

    final result = await Share.shareWithResult(appLink, subject: message);

    if (result.status == ShareResultStatus.success) {
      log('Thank you for sharing my website!');
    }
  }

  Future<bool> shareFiles({required List filesToShare}) async {
    List<XFile>? shares = [];
    RxBool goodShare = false.obs;

    for (var shareElement in filesToShare) {
      for (var share in shareElement) {
        // log("$share");

        if (share["isSelected"].value == true) {
          shares.add(XFile(share["path"]));
          goodShare.value = false;
        }
      }
    }
    goodShare.value = true;
    if (shares.isNotEmpty) {
      if (goodShare.value == true) await Share.shareXFiles(shares);

      for (var shareElement in filesToShare) {
        for (var share in shareElement) {
          // log("$share");

          if (share["isSelected"].value == true) {
            share["isSelected"].value = false;
          }
        }
      }
      selectionMode.value = false;
    }
    return true;
  }

  deselectAll({required RxList list}) async {
    for (var deselect in list) {
      // if (deselect["isSelected"].value == true) {
      //   deselect["isSelected"].value = false;
      // }
    }
    selectionMode.value = false;
  }

  oneSelected({required RxList list}) {
    for (var oneSelected in list) {
      if (oneSelected['isSelected'].value == true) {
        selectionMode.value = true;
        break;
      } else {
        selectionMode.value = false;
      }
    }
  }

  deleteFile() {
    Get.bottomSheet(
      settings: RouteSettings(arguments: filesList),
      DeletePopup(),
    );
  }

  deleteStorage() async {
    box.erase();
    box.save();
    log("box deleted");
  }

  getInfo() {
    var me = box.read("dataList");
    // log(me);
    // RxList x = [].obs;
    // x.value = jsonDecode(me);
    // x.removeAt(0);
    // x.forEach((element) {
    //   log(element.toString());
    // });
    // box.remove("dataList").then((value) {
    //   box.save();
    //   log("removed");
    // });
    // box.write("dataList", jsonEncode(x)).then((value) => box.save());
  }

  fetchDatas({required String link}) async {
    var linkTest = link.contains(RegExp('https://'));

    if (!linkTest) {
      Get.bottomSheet(const ErrorPopup(
          errorTitle: "errorTitle",
          errorText: "errorText",
          errorImage: warning_icon));
    } else {
      videoData = await videoModel.checkDatas(link);
      if (videoData?.video == "" || videoData?.video == null) {
        Get.bottomSheet(const ErrorPopup(
            errorTitle: "errorTitle",
            errorText: "Unknown Video context datas",
            errorImage: pause_icon));
      } else {
        VideoInfo datas = videoData!;

        if (datas.images != null) {
          Get.bottomSheet(
            Container(
              height: Get.height / 2 + 40,
              width: Get.width,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: (Get.height / 2) - 100,
                      child: Stack(
                        children: [
                          PageView.builder(
                              itemCount: datas!.images!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: Get.width - 20,
                                  height: (Get.height / 2) - 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(datas!.images![index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                          Positioned(
                            right: 20,
                            child: Container(
                                width: 180,
                                color: secondColor.withOpacity(.4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "P: ${datas!.plays!}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "S: ${datas!.shares!}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "C: ${datas!.comments!}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 0,
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(datas!.avatar!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 120,
                              child: Text(
                                "@${datas!.name!} / ${datas!.username!}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                        ],
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  LargeButton(
                      text: "Downloads ${datas!.images!.length} Image(s)",
                      onTap: () {
                        downloadImages();
                        Get.back();
                      },
                      color: firstColor),
                ],
              ),
            ),
          );
        } else {
          Get.bottomSheet(
            Container(
              height: Get.height / 2 + 40,
              width: Get.width,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: (Get.height / 2) - 100,
                      child: Stack(
                        children: [
                          Container(
                            width: Get.width - 20,
                            height: (Get.height / 2) - 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(datas!.cover!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            child: Container(
                                width: 180,
                                color: secondColor.withOpacity(.4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "P: ${datas!.plays!}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "S: ${datas!.shares!}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "C: ${datas!.comments!}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(datas!.avatar!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 40,
                              left: 120,
                              child: Text(
                                "@${datas!.name!} / ${datas!.username!}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: InkWell(
                              onTap: () {
                                downloadMusic();
                                Get.back();
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(logoImg),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    music_icon,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  LargeButton(
                      text: "Authentik Video",
                      onTap: () {
                        downloadVideo();
                        Get.back();
                      },
                      color: firstColor),
                  const SizedBox(
                    height: 10,
                  ),
                  LargeButton(
                      text: "Watermark Video",
                      onTap: () {
                        downloadWatermarkVideo();
                        Get.back();
                      },
                      color: thirdColor),
                ],
              ),
            ),
          );
        }

        linkController.text = "";
      }
    }
  }

  downloadVideo() async {
    Map<String, dynamic> phone = jsonDecode(box.read("phone"));
    bool okPermission = phone["photoPermission"];
    if (okPermission) {
      downloading.value = true;
      downloadProgress = await videoModel.downloadMedia(
          mode: "authentik", datas: videoData!, date: DateTime.now());
      if (downloadProgress.value == 1.0) {
        log("${downloadProgress.value}   ${downloading.value}");
        downloading.value = false;
      }
    } else {
      if (await verifyStorage.requestPermission(phone["version.sdkInt"] < 33
          ? Permission.storage
          : Permission.photos)) {
        phone["photoPermission"] = true;
        box.write("phone", jsonEncode(phone));

        log(phone["photoPermission"].toString());
        downloadVideo();
      } else {
        Get.bottomSheet(const ErrorPopup(
            errorTitle: " Permission",
            errorText: "Give Photo Permission",
            errorImage: warning_icon));
      }
    }

    ever(
        downloadProgress,
        (callback) => {
              if (downloadProgress.value == 1.0) {downloading.value = false}
            });
  }

  downloadWatermarkVideo() async {
    Map<String, dynamic> phone = jsonDecode(box.read("phone"));
    bool okPermission = phone["photoPermission"];
    if (okPermission) {
      downloading.value = true;
      downloadProgress = await videoModel.downloadMedia(
          mode: "watermark", datas: videoData!, date: DateTime.now());
    } else {
      if (await verifyStorage.requestPermission(phone["version.sdkInt"] < 33
          ? Permission.storage
          : Permission.photos)) {
        phone["photoPermission"] = true;
        box.write("phone", jsonEncode(phone));

        log(phone["photoPermission"].toString());
        downloadWatermarkVideo();
      } else {
        Get.bottomSheet(const ErrorPopup(
            errorTitle: " Permission",
            errorText: "Give Photo Permission",
            errorImage: warning_icon));
      }
    }

    ever(
        downloadProgress,
        (callback) => {
              if (downloadProgress.value == 1.0) {downloading.value = false}
            });
  }

  downloadImages() async {
    Map<String, dynamic> phone = jsonDecode(box.read("phone"));
    bool okPermission = phone["photoPermission"];
    if (okPermission) {
      downloading.value = true;
      downloadProgress = await videoModel.downloadMedia(
          mode: "images", datas: videoData!, date: DateTime.now());
      if (downloadProgress.value == 1.0) {
        log("${downloadProgress.value}   ${downloading.value}");
        downloading.value = false;
      }
    } else {
      if (await verifyStorage.requestPermission(phone["version.sdkInt"] < 33
          ? Permission.storage
          : Permission.photos)) {
        phone["photoPermission"] = true;
        box.write("phone", jsonEncode(phone));

        log(phone["photoPermission"].toString());
        downloadImages();
      } else {
        Get.bottomSheet(const ErrorPopup(
            errorTitle: " Permission",
            errorText: "Give Photo Permission",
            errorImage: warning_icon));
      }
    }

    ever(
        downloadProgress,
        (callback) => {
              if (downloadProgress.value == 1.0) {downloading.value = false}
            });
  }

  downloadMusic() async {
    Map<String, dynamic> phone = jsonDecode(box.read("phone"));
    bool okPermission = phone["photoPermission"];
    if (okPermission) {
      downloading.value = true;
      downloadProgress = await videoModel.downloadMedia(
          mode: "music", datas: videoData!, date: DateTime.now());
    } else {
      if (await verifyStorage.requestPermission(phone["version.sdkInt"] < 33
          ? Permission.storage
          : Permission.audio)) {
        phone["photoPermission"] = true;
        box.write("phone", jsonEncode(phone));

        log(phone["photoPermission"].toString());
        downloadMusic();
      } else {
        Get.bottomSheet(const ErrorPopup(
            errorTitle: " Permission",
            errorText: "Give Music Permission",
            errorImage: warning_icon));
      }
    }
    ever(
        downloadProgress,
        (callback) => {
              if (downloadProgress.value == 1.0) {downloading.value = false},
              //TODO Success Popup
            });
  }

  // Navigation
  changePage(pageSelected) {
    if (pageSelected == 0) {
      getVideos();
    } else if (pageSelected == 1) {
      getImages();
    } else if (pageSelected == 2) {
      getMusics();
    }
    downPageController.animateToPage(pageSelected,
        duration: duration, curve: Curves.ease);
  }

  getImages() async {
    filesList = [].obs;
    filesList = await getMedia.getImages();
    for (var file in filesList) {
      if (file is File) {
        String nameWithType = file.path.split("/").last;
        String name = nameWithType.split(".").first;
        String type = nameWithType.split(".").last;
        // log("name: $nameWithType");
      }
    }
    // filesList.forEach((element) {
    //   log(element.toString());
    // });
    log("list() : " + filesList.length.toString());
  }

  getVideos() async {
    filesList = [].obs;
    filesList = await getMedia.getVideos();
    for (var file in filesList) {
      if (file is File) {
        String nameWithType = file.path.split("/").last;
        String name = nameWithType.split(".").first;
        String type = nameWithType.split(".").last;
        // log("name: $nameWithType");
      }
    }

    // filesList.forEach((element) {
    //   log(element.toString());
    // });
    log("list() : " + filesList.length.toString());
  }

  getMusics() async {
    filesList = await getMedia.getMusics();
    for (var file in filesList) {
      if (file is File) {
        String nameWithType = file.path.split("/").last;
        String name = nameWithType.split(".").first;
        String type = nameWithType.split(".").last;
        log("name: $nameWithType");
      }
    }

    log("list() : " + filesList.length.toString());
  }

  // Change pages
  home() {
    if (pageController.page != 0) {
      pageController.animateToPage(0, duration: duration, curve: Curves.linear);
    }
  }

  downloads() async {
    Map<String, dynamic> phone = jsonDecode(box.read("phone"));
    bool okPermission = phone["photoPermission"];
    if (okPermission) {
      if (verifyStorage.existsDirectory(
          Directory("//storage/emulated/0/Movies/TikiDownsVideos"))) {
        await getVideos();
        pageController.animateToPage(1,
            duration: duration, curve: Curves.linear);
      } else {
        await verifyStorage.createDirectory();
        await getVideos();
        pageController.animateToPage(1,
            duration: duration, curve: Curves.linear);
      }
    } else {
      if (await verifyStorage.requestPermission(phone["version.sdkInt"] < 33
          ? Permission.storage
          : Permission.photos)) {
        phone["photoPermission"] = true;
        box.write("phone", jsonEncode(phone));
      }
      await downloads();
    }
  }

  settings() {
    Get.toNamed(
      "/sets",
    );
  }

  gallery({required int index}) {
    Get.toNamed("/gallery", arguments: {"list": filesList, "index": index});
  }
}
