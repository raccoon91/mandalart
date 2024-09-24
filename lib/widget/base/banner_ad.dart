import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAD extends StatefulWidget {
  const BannerAD({super.key});

  @override
  State<BannerAD> createState() => _BannerADState();
}

class _BannerADState extends State<BannerAD> {
  late BannerAd bannerAd;

  @override
  void initState() {
    super.initState();

    bannerAd = BannerAd(
      adUnitId: const String.fromEnvironment('ANDROID_AD_UNIT_ID'),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  @override
  void dispose() {
    bannerAd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: bannerAd.size.width.toDouble(),
        height: 50.h,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
