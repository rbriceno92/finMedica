import 'package:another_flushbar/flushbar.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

enum AlertNotificationType { success, error }

class AlertNotification {
  static void error(BuildContext context, String text) {
    _showAlert(context, text, AlertNotificationType.error);
  }

  static void success(BuildContext context, String text) {
    _showAlert(context, text, AlertNotificationType.success);
  }

  static void _showAlert(
      BuildContext context, String text, AlertNotificationType type) {
    if (text.isNotEmpty) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: type == AlertNotificationType.success
            ? ColorsFM.green95
            : ColorsFM.errorColor,
        isDismissible: false,
        duration: const Duration(seconds: 3),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        margin: const EdgeInsets.only(
            left: marginStandard, right: marginStandard, top: marginStandard),
        messageText: Text(
          text,
          textAlign: TextAlign.center,
          style: TypefaceStyles.poppinsRegular.copyWith(
              color: type == AlertNotificationType.success
                  ? ColorsFM.neutralDark
                  : Colors.white),
        ),
      ).show(context);
    }
  }
}
