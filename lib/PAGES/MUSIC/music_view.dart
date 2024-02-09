import 'dart:io';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';

import '/CORE/core.dart';

class MusicScreen extends GetView<MusicController> {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Obx(
          () => Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(
                        controller.list[controller.index.value]["cover"])))),
          ),
        ),
        Positioned(
          top: 60,
          right: 40,
          child: Text(
            "Tikidown",
            style: miniTitle.copyWith(
                decoration: TextDecoration.none, color: white),
          ),
        ),
        Positioned(
            bottom: 60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: Get.width - 20,
                margin: const EdgeInsets.symmetric(horizontal: 10),

                // height: Get.height / 2.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width - 100,
                            child: Obx(
                              () => Text(
                                controller.list[controller.index.value]
                                    ["title"],
                                style: miniTitle.copyWith(
                                    color: white, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width - 100,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Obx(
                                () => Text(
                                  controller.list[controller.index.value]
                                      ["name"],
                                  style: miniTitle.copyWith(
                                      color: white,
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: controller.assetsAudioPlayer
                                      .builderRealtimePlayingInfos(
                                    builder:
                                        (context, RealtimePlayingInfos? infos) {
                                      if (infos == null) {
                                        return SizedBox(
                                          child: SvgPicture.asset(playIcon),
                                        );
                                      }
                                      //print('infos: $infos');
                                      return Column(
                                        children: [
                                          PositionSeekWidget(
                                            currentPosition:
                                                infos.currentPosition,
                                            duration: infos.duration,
                                            seekTo: (to) {
                                              controller.assetsAudioPlayer
                                                  .seek(to);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (controller.index.value > 0) {
                                          controller.index.value =
                                              controller.index.value - 1;
                                          controller.assetsAudioPlayer
                                              .previous();
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        prev_icon,
                                        width: 30,
                                        colorFilter: const ColorFilter.mode(
                                            white, BlendMode.srcIn),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.assetsAudioPlayer
                                            .playOrPause();
                                        controller.isPlay.value =
                                            !controller.isPlay.value;
                                      },
                                      child: Obx(
                                        () => controller.isPlay.value == true
                                            ? SvgPicture.asset(
                                                pause_icon,
                                                width: 30,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        white, BlendMode.srcIn),
                                              )
                                            : SvgPicture.asset(
                                                play_icon,
                                                width: 30,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        white, BlendMode.srcIn),
                                              ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (controller.list.length - 1 >
                                            controller.index.value) {
                                          controller.index.value =
                                              controller.index.value + 1;
                                          controller.assetsAudioPlayer.next();
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        next_icon,
                                        width: 30,
                                        colorFilter: const ColorFilter.mode(
                                            white, BlendMode.srcIn),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: SvgPicture.asset(
                                  loop_icon,
                                  colorFilter: const ColorFilter.mode(
                                      white, BlendMode.srcIn),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: SvgPicture.asset(
                                  infoIcon,
                                  colorFilter: const ColorFilter.mode(
                                      white, BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    ));
  }
}
