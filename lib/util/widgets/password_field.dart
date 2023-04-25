// ignore_for_file: file_names

import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final void Function(String? value) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final Color labelColor;
  final bool error;
  final bool lastItem;
  final bool showPassword;
  final void Function() onPressed;
  final String text;

  const PasswordField({
    super.key,
    required this.label,
    required this.onChange,
    required this.onPressed,
    this.borderColor = ColorsFM.neutralColor,
    this.errorBorderColor = ColorsFM.errorColor,
    this.labelColor = ColorsFM.neutralDark,
    required this.error,
    this.lastItem = false,
    required this.showPassword,
    required this.text,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.text.isEmpty) {
      textEditingController.clear();
    }
    return TextFormField(
      controller: textEditingController,
      textInputAction:
          widget.lastItem ? TextInputAction.done : TextInputAction.next,
      style: TypefaceStyles.bodyMediumMontserrat,
      onChanged: (value) {
        widget.onChange(value);
      },
      obscureText: !widget.showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoratorLogin.getInputDecorator(
              widget.label,
              widget.error ? widget.errorBorderColor : widget.borderColor,
              widget.errorBorderColor,
              labelColor: widget.error ? null : ColorsFM.neutralDark)
          .copyWith(
        suffixIcon: IconButton(
            onPressed: widget.onPressed,
            icon: !widget.showPassword
                ? SvgPicture.asset(
                    eyeIconOpen,
                    color: widget.error
                        ? widget.errorBorderColor
                        : widget.borderColor,
                  )
                : SvgPicture.asset(
                    eyeIconClosed,
                    color: widget.error
                        ? widget.errorBorderColor
                        : widget.borderColor,
                  )),
      ),
    );
  }
}
