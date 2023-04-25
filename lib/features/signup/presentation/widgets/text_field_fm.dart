import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';

class TextFieldFM extends StatelessWidget {
  final String label;
  final void Function(String?) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool lastItem;
  final dynamic controllerText;
  final TextCapitalization textCapitalization;

  const TextFieldFM(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error,
      this.lastItem = false,
      required this.textCapitalization,
      this.controllerText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      controller: controllerText,
      textInputAction: lastItem ? TextInputAction.done : TextInputAction.next,
      style: TypefaceStyles.bodyMediumMontserrat,
      onChanged: (value) {
        if (controllerText != null) {
          String myText = value.disallowLeadingWhitespace();
          controller(myText, controllerText);
          onChange(myText);
        } else {
          onChange(value);
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoratorLogin.getInputDecorator(
          label, error ? errorBorderColor : borderColor, errorBorderColor,
          labelColor: error ? null : ColorsFM.neutralDark),
    );
  }

  void controller(String value, dynamic controllerFormField) {
    var cursorPos = controllerFormField.selection;
    if (cursorPos.start > value.length) {
      cursorPos =
          TextSelection.fromPosition(TextPosition(offset: value.length));
    }
    controllerFormField.text = value;
    controllerFormField.selection = cursorPos;
  }
}
