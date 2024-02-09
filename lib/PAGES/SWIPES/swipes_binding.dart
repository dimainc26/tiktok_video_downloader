import 'package:get/get.dart';
import '/PAGES/SWIPES/swipes_controller.dart';

class SwipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SwipeController>(SwipeController());
  }
}
