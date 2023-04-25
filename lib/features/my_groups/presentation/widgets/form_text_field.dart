import 'package:app/features/my_groups/presentation/widgets/form_required_text.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final void Function(String?) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool lastItem;
  final TextEditingController controllerText;
  final bool isRequired;
  final bool enabled;

  const FormTextField(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error,
      this.lastItem = false,
      this.isRequired = false,
      required this.controllerText,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      FormRequiredText(isRequired),
      TextFormField(
        controller: controllerText,
        textInputAction: lastItem ? TextInputAction.done : TextInputAction.next,
        style: TypefaceStyles.bodyMediumMontserrat,
        onChanged: (value) {
          value = value.disallowLeadingWhitespace();
          var cursorPos = controllerText.selection;
          if (cursorPos.start > value.length) {
            cursorPos =
                TextSelection.fromPosition(TextPosition(offset: value.length));
          }
          controllerText.text = value;
          controllerText.selection = cursorPos;
          onChange(value);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoratorLogin.getInputDecorator(
            label, error ? errorBorderColor : borderColor, errorBorderColor,
            labelColor: error ? null : ColorsFM.neutralDark),
        enabled: enabled,
      )
    ]);
  }
}
