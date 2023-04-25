import 'package:app/features/my_groups/presentation/widgets/form_required_text.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final void Function(String? value) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool lastItem;
  final bool errorLabelColor;
  final TextEditingController controller;
  final bool isRequired;
  final bool enabled;
  final int? maxLength;

  const FormTextField(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      this.errorLabelColor = true,
      required this.error,
      this.lastItem = false,
      this.isRequired = false,
      required this.controller,
      this.enabled = true,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      FormRequiredText(isRequired),
      TextFormField(
        controller: controller,
        textInputAction: lastItem ? TextInputAction.done : TextInputAction.next,
        style: TypefaceStyles.bodyMediumMontserrat,
        onChanged: (value) {
          onChange(value);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoratorLogin.getInputDecorator(
                label,
                error && errorLabelColor ? errorBorderColor : borderColor,
                errorBorderColor,
                labelColor: error ? null : ColorsFM.neutralDark)
            .copyWith(
          counterText: '',
        ),
        enabled: enabled,
        maxLength: maxLength,
      ),
      if (controller.text.isNotEmpty)
        Text(
          '${Languages.of(context).maxCharacters(maxLength ?? 0)} ${Languages.of(context).charactersRemaining((maxLength ?? 0) - controller.text.length)}',
          style: TypefaceStyles.poppinsRegular11
              .copyWith(color: ColorsFM.neutralColor),
        )
    ]);
  }
}
