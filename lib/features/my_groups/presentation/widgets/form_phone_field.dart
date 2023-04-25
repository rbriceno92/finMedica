import 'package:app/features/my_groups/presentation/widgets/form_required_text.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormPhoneField extends StatelessWidget {
  final String label;
  final void Function(String?) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool lastItem;
  final bool isRequired;
  final TextEditingController controller;
  final bool enabled;

  const FormPhoneField(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error,
      this.lastItem = false,
      this.isRequired = false,
      required this.controller,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '## #### ####',
        filter: {'#': RegExp(r'[0-9]')},
        initialText: controller.text,
        type: MaskAutoCompletionType.lazy);

    return Column(children: [
      FormRequiredText(isRequired),
      TextFormField(
        controller: controller,
        textInputAction: lastItem ? TextInputAction.done : TextInputAction.next,
        style: TypefaceStyles.bodyMediumMontserrat,
        onChanged: (value) {
          onChange(maskFormatter.getUnmaskedText());
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
        decoration: InputDecoratorLogin.getInputDecorator(
            label, error ? errorBorderColor : borderColor, errorBorderColor,
            labelColor: error ? null : ColorsFM.neutralDark),
        enabled: enabled,
      )
    ]);
  }
}
