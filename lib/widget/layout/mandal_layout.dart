import 'package:flutter/material.dart';
import 'package:mandalart/widget/base/banner_ad.dart';

class MandalLayout extends StatelessWidget {
  final bool? isEmpty;
  final String? emptyMessage;
  final Widget? title;
  final Widget body;

  const MandalLayout({
    super.key,
    this.isEmpty,
    this.emptyMessage,
    this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty == true && emptyMessage != null) {
      return Center(
        child: Text(
          emptyMessage ?? "",
          style: const TextStyle(fontSize: 18),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          const BannerAD(),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                title ?? Container(),
                const SizedBox(height: 20),
                body,
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
