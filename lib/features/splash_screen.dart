import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Duration delayInterval = const Duration(milliseconds: 3000);

  void gotoPage() async {
    await Future.delayed(delayInterval,
        () => Navigator.of(context).pushReplacementNamed(welcomeRoute));
  }

  @override
  Widget build(BuildContext context) {
    // big is iphone 14 max pro 2160 x 970
    const bh = 2160;
    const bw = 970;
    // small is iphone 14 max pro 1332 x 750
    const sh = 1332;
    const sw = 750;

    final height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    final width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    var slope = height / width;

    var animationFile = bigAnimation;
    var scale = width / bw;
    var translate = ((bh * scale) - height) / 2.0;
    if (slope <= (sh / sw)) {
      animationFile = smallAnimation;
      scale = width / sw;
      translate = ((sh * scale) - height) / 2.0;
    }
    var offset = translate <= 0 ? 0.0 : -translate;

    return Container(
        color: ColorsFM.primary,
        child: Transform.translate(
            offset: Offset(0, offset),
            child: Center(
                child: SizedBox(
                    width: width,
                    child: Lottie.asset(
                      animationFile,
                      fit: BoxFit.fitWidth,
                      repeat: false,
                      onLoaded: (p0) {
                        gotoPage();
                      },
                    )))));
  }
}
