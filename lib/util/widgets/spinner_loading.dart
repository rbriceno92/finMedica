import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinnerLoading {
  static showDialogLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Material(
              type: MaterialType.transparency,
              child: SpinKitFadingCube(color: ColorsFM.primary),
            ),
        barrierDismissible: false);
  }
}
