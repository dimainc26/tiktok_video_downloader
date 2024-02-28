import 'package:tikidown/CORE/core.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: const Color.fromARGB(255, 48, 48, 48),
        child: Center(child: Image.asset(logoImg)),
      ),
    );
  }
}
