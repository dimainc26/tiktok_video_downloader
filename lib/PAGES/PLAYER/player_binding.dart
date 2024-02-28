import 'package:get/get.dart';
import 'package:tikidown/PAGES/PLAYER/player_controller.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PlayerController>(PlayerController());
  }
}
