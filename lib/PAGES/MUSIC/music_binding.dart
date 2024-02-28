import 'package:get/get.dart';
import 'package:tikidown/PAGES/MUSIC/music_controller.dart';

class MusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MusicController>(MusicController());
  }
}
