import '/CORE/core.dart';

class TutorScreen extends GetView<TutorController> {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Obx(
          () => Stepper(
            type: StepperType.vertical,
            physics: const ScrollPhysics(),
            currentStep: controller.currentStep.value,
            onStepTapped: (step) => controller.tapped(step),
            onStepContinue: controller.continued,
            onStepCancel: controller.cancel,
            steps: [
              Step(
                title: const Text("Open TikTok App"),
                content: Image.asset("imgs/a.gif"),
                isActive: controller.currentStep >= 0,
                state: controller.currentStep > 0
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: const Text("Copy Link Video"),
                content: Image.asset("imgs/b.gif"),
                isActive: controller.currentStep >= 1,
                state: controller.currentStep >= 1
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: const Text("Open TikiDown and Paste Link"),
                content: Image.asset(logoImg),
                isActive: controller.currentStep >= 2,
                state: controller.currentStep >= 2
                    ? StepState.complete
                    : StepState.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
