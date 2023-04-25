import 'package:app/core/di/modules.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOutAlert extends StatelessWidget {
  const SignOutAlert({super.key});

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
                  .closeSesion
                  .split(' ')
                  .map((e) => e.capitalizeOnlyFirstWord())
                  .join(' '),
              style: TypefaceStyles.poppinsSemiBold),
          Padding(
            padding:
                const EdgeInsets.only(top: smallMargin, bottom: mediumMargin),
            child: Text(
              Languages.of(context).wantToSignOut,
              textAlign: TextAlign.center,
              style: TypefaceStyles.poppinsRegularPrimary
                  .copyWith(color: ColorsFM.neutralDark),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Languages.of(context).noText,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: marginStandard,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      side:
                          const BorderSide(width: 1, color: ColorsFM.green40)),
                  onPressed: () {
                    var prefs = getIt<SharedPreferences>();
                    prefs.setString('token', '');
                    Navigator.of(context).pushReplacementNamed(welcomeRoute);
                  },
                  child: Text(
                    Languages.of(context).yesText,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: ColorsFM.green40,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
