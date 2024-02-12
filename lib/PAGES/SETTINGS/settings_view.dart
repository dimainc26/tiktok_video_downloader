import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/CORE/core.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adController = Get.find<AdController>();
    adController.createBannerAd();

    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () => controller.shareApp(),
                    )),
                Text(
                  "Tikidown",
                  style: firstTitle.copyWith(color: firstColor),
                ),
              ],
            )),
            SizedBox(
              height: Get.height / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LargeButton(
                      onTap: () => controller.tutorial(),
                      color: firstColor,
                      text: "How to donload ?"),
                  LargeButton(
                      onTap: () => null,
                      color: thirdColor,
                      text: "Videos: ${controller.videosLenght.value} "),
                  LargeButton(
                      onTap: () => null,
                      color: thirdColor,
                      text: "Covers: ${controller.coversLenght.value} "),
                  LargeButton(
                      onTap: () => null,
                      color: thirdColor,
                      text: "Musics: ${controller.musicsLenght.value} "),
                  SizedBox(
                    width: Get.width,
                    height: 160,
                    child: Center(
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(color: secondColor, width: 5),
                              shape: BoxShape.circle),
                          child: Text(
                            controller.total.toString(),
                            style: firstTitle.copyWith(color: secondColor),
                          )),
                    ),
                  ),
                  Obx(
                    () => adController.startBannerAd.value == true
                        ? SizedBox(
                            height:
                                adController.bannerAd!.size.height.toDouble(),
                            width: adController.bannerAd!.size.width.toDouble(),
                            child: AdWidget(ad: adController.bannerAd!),
                          )
                        : const Text(""),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
