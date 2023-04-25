import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class DeletePaymentMethodDialog extends StatelessWidget {
  final String number;
  const DeletePaymentMethodDialog({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      scrollable: false,
      contentPadding: const EdgeInsets.all(mediumMargin),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: smallMargin),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    style: TypefaceStyles.poppinsSemiBold,
                    text: Languages.of(context).deletePaymentMethodMessageP1),
                TextSpan(
                    style: TypefaceStyles.poppinsSemiBold
                        .copyWith(color: ColorsFM.green40),
                    text: ' **** $number '),
                TextSpan(
                    style: TypefaceStyles.poppinsSemiBold,
                    text: Languages.of(context).deletePaymentMethodMessageP2),
              ]),
            ),
          ),
          const SizedBox(
            height: mediumMargin,
            width: mediumMargin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      side:
                          const BorderSide(width: 1, color: ColorsFM.green40)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Languages.of(context).cancel,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: ColorsFM.green40,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: marginStandard,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    Languages.of(context).continueText,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
