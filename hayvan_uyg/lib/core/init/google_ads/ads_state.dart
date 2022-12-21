import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobManager {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3434889084698412/6725420409";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8119028412103413/4220119522";
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3434889084698412/2959481505";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8119028412103413/4028547831";
    }
    return null;
  }

  BannerAd createBannerAd() {
    return BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdmobManager.bannerAdUnitId!,
      listener: AdmobManager.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
  );
}
