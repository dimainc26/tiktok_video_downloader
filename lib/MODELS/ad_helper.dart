// import 'dart:io';

// class AdHelper {

//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-6433878504323817/1143102149';
//     } else if (Platform.isIOS) {
//       return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-6433878504323817/9550971554';
//     } else if (Platform.isIOS) {
//       return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   static String get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-6433878504323817/3546255194';
//     } else if (Platform.isIOS) {
//       return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }
// }

import 'dart:io';

class AdHelper {
  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6433878504323817/3305961556'; // Exemple Android ID
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_APP_OPEN_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6433878504323817/1143102149'; // Exemple Android ID
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6433878504323817/9550971554'; // Exemple Android ID
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6433878504323817/3546255194'; // Exemple Android ID
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
