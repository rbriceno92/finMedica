import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputDecoratorLogin {
  static InputDecoration getInputDecorator(
      String label, Color borderColor, Color errorBorderColor,
      {Color? labelColor}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorBorderColor, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorBorderColor, width: 1.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      errorStyle: const TextStyle(height: 0.01),
      labelStyle: TypefaceStyles.poppinsRegular.copyWith(
          fontSize: 16, color: labelColor ?? borderColor, letterSpacing: 0.5),
    );
  }
}

class InputDecoratorDirectory {
  static InputDecoration getInputDecoratorDirectory(Function() function) {
    return InputDecoration(
        labelStyle: TypefaceStyles.poppinsRegular.copyWith(
            fontSize: 16, color: ColorsFM.neutralDark, letterSpacing: 0.5),
        prefixIcon: GestureDetector(
          onTap: () {
            function.call();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: marginStandard),
            child: SvgPicture.asset(iconSearch),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: mediumMargin),
        fillColor: ColorsFM.blueLight90,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        hintStyle: TypefaceStyles.bodyMediumMontserrat
            .copyWith(color: ColorsFM.primary));
  }
}

class InputScheduleAppointmentDecorator {
  static InputDecoration getInputDecoratorScheduleAppointment(String label) {
    return InputDecoration(
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsFM.neutralColor, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsFM.neutralColor, width: 1.0),
        ),
        fillColor: ColorsFM.neutralColor,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsFM.neutralColor, width: 1.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: TypefaceStyles.poppinsRegular.copyWith(
            fontSize: 16, color: ColorsFM.neutralDark, letterSpacing: 0.5),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: SvgPicture.asset(iconCalendar),
        ));
  }
}
