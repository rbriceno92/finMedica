import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

const PaymentSheetAppearance paymentSheetAppearance = PaymentSheetAppearance(
  colors: PaymentSheetAppearanceColors(
    background: Colors.white,
    primary: ColorsFM.green40,
    componentBorder: ColorsFM.neutral90,
    componentBackground: Colors.white,
    componentDivider: ColorsFM.neutral90,
    componentText: ColorsFM.neutralDark,
    error: ColorsFM.errorColor,
    icon: ColorsFM.neutralColor,
    placeholderText: ColorsFM.neutral90,
    primaryText: ColorsFM.primary,
    secondaryText: ColorsFM.primary,
  ),
  shapes: PaymentSheetShape(
    borderWidth: 1,
    borderRadius: 8,
  ),
);
