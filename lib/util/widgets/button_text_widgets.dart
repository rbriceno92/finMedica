import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isLoading;

  const ButtonText(
      {super.key, required this.text, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: ColorsFM.primary),
            )
          : Text(
              text,
              style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                color: onPressed != null ? Colors.white : ColorsFM.neutralColor,
              ),
            ),
    );
  }
}
