import 'package:get/get.dart';
import 'package:tikidown/PAGES/TUTOR/tutor_controller.dart';

class TutorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TutorController>(TutorController());
  }
}
