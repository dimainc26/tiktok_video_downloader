import 'package:get/get.dart';
import 'package:tikidown/PAGES/SPLASH/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
