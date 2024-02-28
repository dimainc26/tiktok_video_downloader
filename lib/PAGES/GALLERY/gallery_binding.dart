import 'package:get/get.dart';
import 'package:tikidown/PAGES/GALLERY/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GalleryController>(GalleryController());
  }
}
