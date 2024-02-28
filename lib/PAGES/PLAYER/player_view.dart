import 'dart:developer';
import 'dart:ui';

import 'package:video_player/video_player.dart';
import 'package:tikidown/CORE/core.dart';

class PlayerScreen extends GetView<PlayerController> {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.goRefresh.value == true
            ? Stack(
                children: [
                  InteractiveViewer(
                    constrained: false,
                    scaleEnabled: true,
                    maxScale: 4,
                    minScale: 0.5,
                    child: Obx(
                      () => InkWell(
                        onTap: controller.disableClick.value != true
                            ? () {
                                controller.videoPlayerController.value.isPlaying
                                    ? controller.videoPlayerController.pause()
                                    : controller.videoPlayerController.play();
                                controller.pausedContent.value =
                                    !controller.pausedContent.value;
                              }
                            : () {
                                log("No Click");
                              },
                        onLongPress: () {},
                        child: SizedBox(
                          width: (Get.height / 16) * 9,
                          height: Get.height,
                          child: AspectRatio(
                            aspectRatio: controller
                                .videoPlayerController.value.aspectRatio,
                            child:
                                VideoPlayer(controller.videoPlayerController),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Positioned(
                        top:
                            controller.pausedContent.value == true ? 100 : -100,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(controller
                                              .list[controller.index.value]
                                          ["avatar"]))),
                            ),
                            Text(
                              controller.list[controller.index.value]
                                  ["username"],
                              style: topMenu.copyWith(
                                  color: white,
                                  fontSize: 20,
                                  decoration: TextDecoration.overline),
                            )
                          ],
                        )),
                  ),
                  Obx(
                    () => AnimatedPositioned(
                      duration: controller.animationDuration,
                      bottom: controller.disableClick.value == false
                          ? Get.height / 3
                          : Get.height / 2 - 50,
                      right: controller.pausedContent.value == true
                          ? 20
                          : controller.disableClick.value == true
                              ? 20
                              : -100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Container(
                          width: 60,
                          height: controller.disableClick.value == false
                              ? Get.height / 3
                              : 50,
                          padding: controller.disableClick.value == false
                              ? null
                              : const EdgeInsets.all(10),
                          color: Colors.black.withOpacity(.3),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Obx(
                              () => controller.disableClick.value == false
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () => controller.onOffVolume(),
                                          child: SvgPicture.asset(
                                            controller.videoPlayerController
                                                        .value.volume >
                                                    0.0
                                                ? volume_on_icon
                                                : volume_off_icon,
                                            width: 30,
                                            colorFilter: ColorFilter.mode(
                                                controller.videoPlayerController
                                                            .value.volume >
                                                        0.0
                                                    ? firstColor
                                                    : white,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => controller.shareFile(),
                                          child: SvgPicture.asset(
                                            shareIcon,
                                            width: 30,
                                            colorFilter: const ColorFilter.mode(
                                                white, BlendMode.srcIn),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              controller.disableTouch(),
                                          child: SvgPicture.asset(
                                            unlock_icon,
                                            width: 30,
                                            colorFilter: const ColorFilter.mode(
                                                white, BlendMode.srcIn),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => controller.details(
                                              details: controller.list[
                                                  controller.index.value]),
                                          child: SvgPicture.asset(
                                            infoIcon,
                                            width: 30,
                                            colorFilter: const ColorFilter.mode(
                                                white, BlendMode.srcIn),
                                          ),
                                        ),
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () => controller.disableTouch(),
                                      child: SvgPicture.asset(
                                        lock_icon,
                                        width: 30,
                                        colorFilter: const ColorFilter.mode(
                                            white, BlendMode.srcIn),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedPositioned(
                        duration: controller.animationDuration,
                        bottom:
                            controller.pausedContent.value == true ? 20 : -100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                    width: 50,
                                    child: Text(
                                      "00 : 00",
                                      style: TextStyle(color: white),
                                    )),
                                Container(
                                  width: Get.width - 120,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ClipRRect(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2.0, sigmaY: 2.0),
                                        child: ValueListenableBuilder<
                                            VideoPlayerValue>(
                                          valueListenable:
                                              controller.videoPlayerController,
                                          builder: (context, value, _) =>
                                              _VideoProgressSlider(
                                            position: value.position,
                                            duration: value.duration,
                                            swatch: fourthColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 50,
                                    child: Text(
                                      controller.formattedTime(),
                                      style: const TextStyle(color: white),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: TextButton(
                                        onPressed: () => controller.loopVideo(),
                                        child: SvgPicture.asset(
                                          loop_icon,
                                          height: 35,
                                          colorFilter: const ColorFilter.mode(
                                              white, BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width - 100,
                                  // margin: EdgeInsets.only(left: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: TextButton(
                                              onPressed: () =>
                                                  controller.prevVideo(),
                                              child: SvgPicture.asset(
                                                prev_icon,
                                                height: 35,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        white, BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          child: Container(
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(150),
                                            ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 30.0, sigmaY: 30.0),
                                              child: TextButton(
                                                onPressed: () {
                                                  controller
                                                          .videoPlayerController
                                                          .value
                                                          .isPlaying
                                                      ? controller
                                                          .videoPlayerController
                                                          .pause()
                                                      : controller
                                                          .videoPlayerController
                                                          .play();
                                                  controller
                                                          .pausedContent.value =
                                                      !controller
                                                          .pausedContent.value;
                                                },
                                                child: SvgPicture.asset(
                                                  controller
                                                          .videoPlayerController
                                                          .value
                                                          .isPlaying
                                                      ? pause_icon
                                                      : play_icon,
                                                  height: 35,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          white,
                                                          BlendMode.srcIn),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: TextButton(
                                              onPressed: () =>
                                                  controller.nextVideo(),
                                              child: SvgPicture.asset(
                                                next_icon,
                                                height: 35,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        white, BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: TextButton(
                                        onPressed: () {
                                          controller.musicBackground();
                                        },
                                        child: SvgPicture.asset(
                                          headphone_icon,
                                          height: 35,
                                          colorFilter: const ColorFilter.mode(
                                              white, BlendMode.srcIn),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              )
            : const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: firstColor,
                    strokeWidth: 6,
                    backgroundColor: secondColor,
                  ),
                ),
              ),
      ),
    );
  }
}

class _VideoProgressSlider extends StatelessWidget {
  const _VideoProgressSlider({
    required this.position,
    required this.duration,
    required this.swatch,
  });

  final Duration position;
  final Duration duration;
  final Color swatch;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerController());

    final max = duration.inMilliseconds.toDouble();
    final value = position.inMilliseconds.clamp(0, max).toDouble();
    return SliderTheme(
      data: SliderThemeData(
        disabledActiveTrackColor: firstColor,
        disabledInactiveTrackColor: secondColor,
        trackHeight: 5,
        minThumbSeparation: 12,
        thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 14.0, elevation: 2),
        trackShape: const RoundedRectSliderTrackShape(),
        thumbColor: thirdColor,
        activeTrackColor: thirdColor.withOpacity(.65),
      ),
      child: Slider(
        min: 0,
        max: max,
        value: value,
        onChanged: (value) => controller.videoPlayerController
            .seekTo(Duration(milliseconds: value.toInt())),
        onChangeStart: (_) {
          controller.videoPlayerController.pause();
          controller.pausedContent.value = true;
        },
        onChangeEnd: (_) {
          controller.videoPlayerController.play();
          controller.pausedContent.value = false;
        },
      ),
    );
  }
}
