import 'package:app/features/my_groups/presentation/widgets/form_required_text.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';

class FormEmailField extends StatelessWidget {
  final String label;
  final void Function(String?) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool errorDuplicate;
  final bool lastItem;
  final bool isRequired;
  final TextEditingController controller;
  final bool enabled;

  const FormEmailField(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error,
      required this.errorDuplicate,
      this.lastItem = false,
      this.isRequired = false,
      required this.controller,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormRequiredText(isRequired),
        TextFormField(
            controller: controller,
            textInputAction:
                lastItem ? TextInputAction.done : TextInputAction.next,
            style: TypefaceStyles.bodyMediumMontserrat,
            onChanged: (value) {
              onChange(value);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoratorLogin.getInputDecorator(
                label, error ? errorBorderColor : borderColor, errorBorderColor,
                labelColor: error ? null : ColorsFM.neutralDark),
            enabled: enabled),
        if (errorDuplicate) ...[
          Text(
            Languages.of(context).emailDuplicate,
            style: TypefaceStyles.poppinsRegularError,
          )
        ]
      ],
    );
  }
}
