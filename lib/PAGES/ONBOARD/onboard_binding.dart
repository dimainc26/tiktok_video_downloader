import 'package:get/get.dart';
import '/PAGES/ONBOARD/onboard_controller.dart';

class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnBoardController>(OnBoardController());
  }
}
