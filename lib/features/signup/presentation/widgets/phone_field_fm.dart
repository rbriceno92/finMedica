import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneFieldFM extends StatefulWidget {
  final String label;
  final String text;
  final void Function(String?) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool lastItem;
  const PhoneFieldFM(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error,
      this.lastItem = false,
      required this.text});

  @override
  State<PhoneFieldFM> createState() => _PhoneFieldFMState();
}

class _PhoneFieldFMState extends State<PhoneFieldFM> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '## #### ####',
        filter: {'#': RegExp(r'[0-9]')},
        initialText: widget.text,
        type: MaskAutoCompletionType.lazy);

    return TextFormField(
      controller: textEditingController,
      textInputAction:
          widget.lastItem ? TextInputAction.done : TextInputAction.next,
      style: TypefaceStyles.bodyMediumMontserrat,
      onChanged: (value) {
        widget.onChange(maskFormatter.getUnmaskedText());
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      inputFormatters: [maskFormatter],
      decoration: InputDecoratorLogin.getInputDecorator(
          widget.label,
          widget.error ? widget.errorBorderColor : widget.borderColor,
          widget.errorBorderColor,
          labelColor: widget.error ? null : ColorsFM.neutralDark),
    );
  }
}
