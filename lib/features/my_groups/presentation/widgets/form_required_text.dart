import 'package:app/generated/l10n.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class FormRequiredText extends StatelessWidget {
  final bool isRequired;
  const FormRequiredText(this.isRequired, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(top: smallMargin / 2),
      child: Text(isRequired ? Languages.of(context).requiredText : '',
          style: TypefaceStyles.montserrat8),
    );
  }
}
