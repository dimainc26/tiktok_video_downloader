// import 'package:rive/rive.dart';
import '/CORE/core.dart';

class Onboard extends StatelessWidget {
  const Onboard({
    required this.txt1,
    required this.txt2,
    required this.txt3,
    required this.icon,
    required this.img,
    required this.bgColor,
    required this.animation,
    super.key,
  });

  final String txt1;
  final String txt2;
  final String txt3;
  final String icon;
  final String img;
  final String animation;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Stack(children: [
        SizedBox(
          width: Get.width,
          height: Get.height,
          // child: RiveAnimation.asset(
          //   animation,
          //   fit: BoxFit.fitHeight,
          // ),
        ),
        Positioned(
          top: Get.height / 2,
          child: SizedBox(
            width: Get.width,
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(text: txt1),
                    TextSpan(
                      text: txt2,
                      style: const TextStyle(fontSize: 42, color: black),
                    ),
                    TextSpan(text: txt3),
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
            right: 30,
            top: Get.height / 1.8,
            child: SvgPicture.asset(
              icon,
              width: 50,
            )),
      ]),
    );
  }
}
