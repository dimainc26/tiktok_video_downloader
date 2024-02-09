import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'CORE/core.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikiDown - TikTok Video Downloader',
      theme: ThemeData(
        primarySwatch: thirdSwatch,
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.androidRoutes,
    );
  }
}
