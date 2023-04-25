import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class CURPInfo extends StatelessWidget {
  const CURPInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 56,
        width: MediaQuery.of(context).size.width - (marginStandard * 2),
        padding: const EdgeInsets.symmetric(horizontal: marginStandard),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: ColorsFM.primaryLight80,
            borderRadius: BorderRadius.all(Radius.circular(radiusRounded8))),
        child: Text(Languages.of(context).curpDisclaimer,
            textAlign: TextAlign.center,
            style: TypefaceStyles.poppinsRegular.copyWith(
              color: ColorsFM.primary,
            )));
  }
}
