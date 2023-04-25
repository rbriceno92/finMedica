import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dimens.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorsFM.primary,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    unselectedWidgetColor: ColorsFM.green40,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      color: ColorsFM.primary,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsFM.green40,
          minimumSize: const Size(double.infinity, buttonHeightStandard),
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(radiusRoundedButton))),
          disabledBackgroundColor: ColorsFM.neutral99),
    ),
  );
}
