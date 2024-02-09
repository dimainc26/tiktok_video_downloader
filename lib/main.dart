import 'CORE/core.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TikiDown',
      theme: ThemeData(
        primarySwatch: thirdSwatch,
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.androidRoutes,
    );
  }
}
