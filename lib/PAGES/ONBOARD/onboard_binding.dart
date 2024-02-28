import 'package:get/get.dart';
import 'package:tikidown/PAGES/ONBOARD/onboard_controller.dart';

class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnBoardController>(OnBoardController());
  }
}
