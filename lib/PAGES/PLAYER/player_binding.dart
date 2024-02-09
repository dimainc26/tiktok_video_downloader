import 'package:get/get.dart';
import '/PAGES/PLAYER/player_controller.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PlayerController>(PlayerController());
  }
}
