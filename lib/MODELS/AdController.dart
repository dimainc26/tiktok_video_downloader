// ignore_for_file: file_names

import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class AdController extends GetxController {
  AppOpenAd? _appOpenAd;
  bool _isAppOpenAdAvailable = false;
  DateTime? _lastAppOpenAdLoadTime;

  BannerAd? bannerAd;
  BannerAd? bannerAd2;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  RxBool startBannerAd = false.obs;

  @override
  void onInit() {
    super.onInit();
    MobileAds.instance.initialize();
    _loadAppOpenAd();
  }

  void _loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAppOpenAdAvailable = true;
          _lastAppOpenAdLoadTime = DateTime.now();
        },
        onAdFailedToLoad: (error) => log('App Open Ad Failed to Load: $error'),
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  void showAppOpenAdIfAvailable() {
    if (!_isAppOpenAdAvailable || _appOpenAd == null) return;

    final isAdExpired = DateTime.now().difference(_lastAppOpenAdLoadTime!) >
        const Duration(hours: 4);
    if (isAdExpired) {
      _loadAppOpenAd();
      return;
    }
    _appOpenAd?.show();
    _appOpenAd = null;
    _isAppOpenAdAvailable = false;

    Future.delayed(const Duration(minutes: 1), () {
      _loadAppOpenAd();
    });
  }

  void createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          startBannerAd.value = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
    bannerAd2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          startBannerAd.value = true;
          update();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          _setInterstitialAdListener();
        },
        onAdFailedToLoad: (error) {
          log('Failed to load an interstitial ad: $error');
        },
      ),
    );
  }

  void _setInterstitialAdListener() {
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      },
    );
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.show();
    interstitialAd = null;
  }

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          _setRewardedAdListener();
        },
        onAdFailedToLoad: (error) {
          log('Failed to load a rewarded ad: $error');
        },
      ),
    );
  }

  void _setRewardedAdListener() {
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      },
    );
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      log('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        log("Reward earned: ${reward.amount}");
      },
    );
    rewardedAd = null;
  }

  @override
  void onClose() {
    super.onClose();
    bannerAd?.dispose();
    interstitialAd?.dispose();
    rewardedAd?.dispose();
    super.onClose();
  }
}
