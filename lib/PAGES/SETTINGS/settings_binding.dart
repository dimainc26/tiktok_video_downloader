import 'package:get/get.dart';
import 'package:tikidown/PAGES/SETTINGS/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
  }
}
