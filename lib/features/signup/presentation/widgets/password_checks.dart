import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordChecks extends StatelessWidget {
  final String password;
  const PasswordChecks({Key? key, required this.password}) : super(key: key);

  Widget passCheck(String label, bool passed) {
    return Row(
      children: [
        passed
            ? SvgPicture.asset(checkValidation)
            : SvgPicture.asset(iconCancel),
        const SizedBox(
          width: marginStandard,
        ),
        Text(
          label,
          style: TypefaceStyles.poppinsRegular,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: mediumMargin),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          Languages.of(context).passwordShouldHave,
          style: TypefaceStyles.poppinsRegular,
        ),
        passCheck(
            Languages.of(context).atLeastEightCharacters, password.length >= 8),
        passCheck(Languages.of(context).atLeastOneMayus,
            Validators.hasUpperLetters(password)),
        passCheck(Languages.of(context).atLeastOneMinus,
            Validators.haslowerLetters(password)),
        passCheck(Languages.of(context).atLeastOneNumber,
            Validators.hasNumbers(password)),
        passCheck(Languages.of(context).atLeastOneSpecialChar,
            Validators.hasSpecialCharacters(password)),
        passCheck(Languages.of(context).lessThanTwentyFiveCharacters,
            password.isNotEmpty && password.length < 26),
      ]),
    );
  }
}
