// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:tikidown/CORE/core.dart';

class SwipeScreen extends GetView<SwipeController> {
  const SwipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adController = Get.find<AdController>();
    adController.createBannerAd();

    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: (int page) async {
                controller.currentIndicator.value = page;

                if (page == 1) {
                  var r = Random().nextInt(100);
                  if (r > 40) {
                    if (adController.interstitialAd != null) {
                      await adController.interstitialAd?.show();
                    } else {
                      adController.createInterstitialAd();
                    }
                  }
                }
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () => controller.shareApp(),
                        child: Container(
                          height: Get.height / 3,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(logoImg),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 4),
                      padding:
                          const EdgeInsets.only(left: 32, top: 4, bottom: 4),
                      width: Get.width - 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: TextFormField(
                        controller: controller.linkController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Paste Link Here",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: fourthColor,
                          ),
                        ),
                        style:
                            const TextStyle(fontSize: 16, color: secondColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(top: 6, bottom: 12),
                          width: Get.width - 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            // border: Border.all(color: Colors.grey),
                            gradient: const LinearGradient(
                              colors: [secondColor, firstColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: controller.downloading.value
                              ? Container(
                                  height: 55,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Positioned.fill(
                                        child: Obx(
                                          () => LinearProgressIndicator(
                                            value: controller
                                                .downloadProgress.value,
                                            color: Colors.white24,
                                            backgroundColor:
                                                thirdColor.withAlpha(20),
                                          ),
                                        ),
                                      ),
                                      const Center(
                                        child: Text('Download...'),
                                      )
                                    ],
                                  ),
                                )
                              : PageButton(
                                  onTap: () => controller.fetchDatas(
                                      link: controller.linkController.text),
                                  color: firstColor,
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Obx(
                              () => adController.startBannerAd.value == true
                                  ? SizedBox(
                                      height: adController.bannerAd!.size.height
                                          .toDouble(),
                                      width: adController.bannerAd!.size.width
                                          .toDouble(),
                                      child:
                                          AdWidget(ad: adController.bannerAd!),
                                    )
                                  : Text(""),
                            ),
                            // TextButton(
                            //     onPressed: () =>
                            //         controller.checkClipboardForLink(),
                            //     child: const Text("Intent")),
                            // TextButton(
                            //     onPressed: () => controller.shareApp(),
                            //     child: const Text("Share Files"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 20),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                controller.selectionMode.value == false
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        child: Text(
                                          "Downloads",
                                          style: topMenu,
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        decoration:
                                            BoxDecoration(color: firstColor),
                                        child: Text(
                                          "Selectionner",
                                          style: topMenu.copyWith(
                                              color: secondColor),
                                        ),
                                      ),
                                SizedBox(
                                  width: 140,
                                  child: Obx(
                                    () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: controller
                                                    .selectionMode.value ==
                                                false
                                            ? [
                                                InkWell(
                                                  onTap: () =>
                                                      controller.settings(),
                                                  child: SvgPicture.asset(
                                                    settings_icon,
                                                    width: 28,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            fourthColor,
                                                            BlendMode.srcIn),
                                                  ),
                                                )
                                              ]
                                            : [
                                                InkWell(
                                                  onTap: () =>
                                                      controller.deleteFile(),
                                                  child: SvgPicture.asset(
                                                    delete_icon,
                                                    width: 38,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            fourthColor,
                                                            BlendMode.srcIn),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => controller
                                                      .shareFiles(
                                                          filesToShare: [
                                                        controller.filesList
                                                      ]),
                                                  child: SvgPicture.asset(
                                                    share_icon,
                                                    width: 28,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            fourthColor,
                                                            BlendMode.srcIn),
                                                  ),
                                                ),
                                              ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => adController.startBannerAd.value == true
                              ? SizedBox(
                                  height: adController.bannerAd2!.size.height
                                      .toDouble(),
                                  width: adController.bannerAd2!.size.width
                                      .toDouble(),
                                  child: AdWidget(ad: adController.bannerAd2!),
                                )
                              : Text(""),
                        ),
                        Container(
                          height: 60,
                          width: Get.width - 76,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          child: TabBar(
                              indicatorColor: secondColor,
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              labelStyle: topMenu,
                              controller: controller.tabBarController,
                              onTap: (index) {
                                controller.changePage(index);
                              },
                              tabs: const [
                                Tab(
                                  child: Text(
                                    "Videos",
                                    style: formTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Covers",
                                    style: formTitle,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Songs",
                                    style: formTitle,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: PageView.builder(
                              itemCount: 3,
                              allowImplicitScrolling: false,
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller.downPageController,
                              onPageChanged: (int i) {
                                controller.tabSelectedPage.value = i;
                              },
                              itemBuilder:
                                  (BuildContext context, int pageIndex) {
                                return pageIndex == 0
                                    ? Obx(
                                        () => GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.filesList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.selectionMode
                                                            .value ==
                                                        false
                                                    ? Get.toNamed("/player",
                                                        arguments: {
                                                            "list": controller
                                                                .filesList,
                                                            "index": index
                                                          })
                                                    : controller
                                                            .filesList[index]
                                                                ["isSelected"]
                                                            .value =
                                                        !controller
                                                            .filesList[index]
                                                                ["isSelected"]
                                                            .value;
                                                controller.oneSelected(
                                                    list: controller.filesList);
                                              },
                                              onLongPress: controller
                                                          .selectionMode
                                                          .value ==
                                                      false
                                                  ? () {
                                                      controller
                                                              .filesList[index]
                                                                  ["isSelected"]
                                                              .value =
                                                          !controller
                                                              .filesList[index]
                                                                  ["isSelected"]
                                                              .value;
                                                      controller.oneSelected(
                                                          list: controller
                                                              .filesList);
                                                    }
                                                  : null,
                                              child: Obx(
                                                () => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Obx(
                                                      () => Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4,
                                                            horizontal: 6),
                                                        width: Get.width,
                                                        height: 130,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          image:
                                                              DecorationImage(
                                                            image: FileImage(File(
                                                                controller.filesList[
                                                                        index]
                                                                    ["cover"])),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            filterQuality:
                                                                FilterQuality
                                                                    .high,
                                                            colorFilter: controller
                                                                        .filesList[
                                                                            index]
                                                                            [
                                                                            "isSelected"]
                                                                        .value ==
                                                                    true
                                                                ? ColorFilter.mode(
                                                                    Colors.red,
                                                                    BlendMode
                                                                        .color)
                                                                : ColorFilter.mode(
                                                                    Colors
                                                                        .transparent,
                                                                    BlendMode
                                                                        .color),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(controller
                                                                .filesList[
                                                            index]['title']),
                                                        // child: Text(controller
                                                        //         .filesList[index]
                                                        //     ["name"]),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: Text(controller
                                                              .filesList[index]
                                                          ['username']),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : pageIndex == 1
                                        ? Obx(() {
                                            return controller.filesList.isEmpty
                                                ? Container(
                                                    width: Get.width,
                                                    height: Get.height,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                cover_gif))),
                                                  )
                                                : GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .filesList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          controller.selectionMode
                                                                      .value ==
                                                                  false
                                                              ? controller
                                                                  .gallery(
                                                                      index:
                                                                          index)
                                                              : controller
                                                                      .filesList[
                                                                          index]
                                                                          [
                                                                          "isSelected"]
                                                                      .value =
                                                                  !controller
                                                                      .filesList[
                                                                          index]
                                                                          [
                                                                          "isSelected"]
                                                                      .value;
                                                          controller.oneSelected(
                                                              list: controller
                                                                  .filesList);
                                                        },
                                                        onLongPress: controller
                                                                    .selectionMode
                                                                    .value ==
                                                                false
                                                            ? () {
                                                                controller
                                                                        .filesList[
                                                                            index]
                                                                            [
                                                                            "isSelected"]
                                                                        .value =
                                                                    !controller
                                                                        .filesList[
                                                                            index]
                                                                            [
                                                                            "isSelected"]
                                                                        .value;
                                                                controller.oneSelected(
                                                                    list: controller
                                                                        .filesList);
                                                              }
                                                            : null,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Obx(
                                                              () => Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        6),
                                                                width:
                                                                    Get.width,
                                                                height: 130,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: FileImage(File(
                                                                        controller.filesList[index]
                                                                            [
                                                                            "path"])),
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                    colorFilter: controller.filesList[index]["isSelected"].value ==
                                                                            true
                                                                        ? ColorFilter.mode(
                                                                            Colors
                                                                                .red,
                                                                            BlendMode
                                                                                .color)
                                                                        : ColorFilter.mode(
                                                                            Colors.transparent,
                                                                            BlendMode.color),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Text(controller
                                                                            .filesList[
                                                                        index]
                                                                    ["title"]),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              // ignore: prefer_interpolation_to_compose_strings
                                                              child: Text("@" +
                                                                  controller.filesList[
                                                                          index]
                                                                      ["name"]),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                          })
                                        : Obx(() {
                                            return controller.filesList.isEmpty
                                                ? Container(
                                                    width: Get.width,
                                                    height: Get.height,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                music_gif))),
                                                  )
                                                : GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .filesList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          controller.selectionMode
                                                                      .value ==
                                                                  false
                                                              ? Get.toNamed(
                                                                  "/music",
                                                                  arguments: {
                                                                    "list": controller
                                                                        .filesList,
                                                                    "index":
                                                                        index
                                                                  },
                                                                )
                                                              : controller
                                                                      .filesList[
                                                                          index]
                                                                          [
                                                                          "isSelected"]
                                                                      .value =
                                                                  !controller
                                                                      .filesList[
                                                                          index]
                                                                          [
                                                                          "isSelected"]
                                                                      .value;
                                                          controller.oneSelected(
                                                              list: controller
                                                                  .filesList);
                                                        },
                                                        onLongPress: controller
                                                                    .selectionMode
                                                                    .value ==
                                                                false
                                                            ? () {
                                                                controller
                                                                        .filesList[
                                                                            index]
                                                                            [
                                                                            "isSelected"]
                                                                        .value =
                                                                    !controller
                                                                        .filesList[
                                                                            index]
                                                                            [
                                                                            "isSelected"]
                                                                        .value;
                                                                controller.oneSelected(
                                                                    list: controller
                                                                        .filesList);
                                                              }
                                                            : null,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Obx(
                                                              () => Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        6),
                                                                width:
                                                                    Get.width,
                                                                height: 130,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: FileImage(File(
                                                                        controller.filesList[index]
                                                                            [
                                                                            "cover"])),
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                    colorFilter: controller.filesList[index]["isSelected"].value ==
                                                                            true
                                                                        ? ColorFilter.mode(
                                                                            Colors
                                                                                .red,
                                                                            BlendMode
                                                                                .color)
                                                                        : ColorFilter.mode(
                                                                            Colors.transparent,
                                                                            BlendMode.color),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Text(controller
                                                                            .filesList[
                                                                        index]
                                                                    ['title']),
                                                                // child: Text(controller
                                                                //         .filesList[index]
                                                                //     ["name"]),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: Text(controller
                                                                          .filesList[
                                                                      index]
                                                                  ['username']),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                          });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              child: Container(
                width: Get.width / 2,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => TextButton(
                        onPressed: () => controller.home(),
                        child: SvgPicture.asset(
                          home_icon,
                          width: 35,
                          colorFilter: ColorFilter.mode(
                              controller.currentIndicator.value == 0
                                  ? secondColor
                                  : fourthColor,
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                    Obx(
                      () => TextButton(
                        onPressed: () => controller.downloads(),
                        child: SvgPicture.asset(
                          download_icon,
                          width: 35,
                          colorFilter: ColorFilter.mode(
                              controller.currentIndicator.value == 1
                                  ? secondColor
                                  : fourthColor,
                              BlendMode.srcIn),
                        ),
                      ),
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
