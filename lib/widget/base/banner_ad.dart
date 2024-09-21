import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAD extends StatefulWidget {
  const BannerAD({super.key});

  @override
  State<BannerAD> createState() => _BannerADState();
}

class _BannerADState extends State<BannerAD> {
  late BannerAd bannerAd;
  bool isBannerADAdReady = false;

  @override
  void initState() {
    super.initState();

    bannerAd = BannerAd(
      adUnitId: const String.fromEnvironment('ANDROID_AD_UNIT_ID'),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBannerADAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          isBannerADAdReady = false;
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
    if (isBannerADAdReady) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: bannerAd.size.width.toDouble(),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(ad: bannerAd),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
