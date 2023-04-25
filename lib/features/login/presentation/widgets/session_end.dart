import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';

class SessionEndAlert extends StatelessWidget {
  const SessionEndAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
          vertical: mediumMargin, horizontal: largeMargin),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              Languages.of(context)
                  .sessionEndText
                  .split(' ')
                  .map((e) => e.capitalizeOnlyFirstWord())
                  .join(' '),
              style: TypefaceStyles.poppinsSemiBold),
          Padding(
            padding:
                const EdgeInsets.only(top: smallMargin, bottom: mediumMargin),
            child: Text(
              Languages.of(context).sessionStartAgainText,
              textAlign: TextAlign.center,
              style: TypefaceStyles.poppinsRegularPrimary
                  .copyWith(color: ColorsFM.neutralDark),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              Languages.of(context).accept,
              style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
