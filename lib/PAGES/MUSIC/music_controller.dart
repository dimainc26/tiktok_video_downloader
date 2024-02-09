import 'dart:async';
import 'dart:developer';

import '/CORE/core.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicController extends GetxController {
  Map<String, dynamic> musicData = {};
  RxList list = [].obs;
  RxInt index = 0.obs;

  RxList musicList = [].obs;

  RxBool isPlay = true.obs;

  final audios = <Audio>[];
  late AssetsAudioPlayer assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];

  @override
  void onInit() {
    super.onInit();
    list = Get.arguments["list"];
    index.value = Get.arguments["index"];
    musicData = list[index.value];
    initializeMusic();
    loadMusic();
    openPlayer();
  }

  initializeMusic() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((data) {
      log('playlistAudioFinished : $data');
    }));
    _subscriptions.add(assetsAudioPlayer.audioSessionId.listen((sessionId) {
      log('audioSessionId : $sessionId');
    }));
  }

  loadMusic() {
    for (var i = 0; i < list.length; i++) {
      audios.add(Audio.file(
        list[i]["path"],
        metas: Metas(
          id: i.toString(),
          title: list[i]["title"],
          artist: list[i]["username"],
          album: 'Tikidowns',
          image: MetasImage.file(list[i]["cover"]),
        ),
      ));
    }
  }

  openPlayer() async {
    try {
      await assetsAudioPlayer.open(
        Playlist(audios: audios, startIndex: index.value),
        showNotification: false,
        autoStart: true,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void onClose() {
    super.onClose();
    assetsAudioPlayer.dispose();
  }
}
