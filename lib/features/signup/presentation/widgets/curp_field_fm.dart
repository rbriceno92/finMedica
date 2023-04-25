import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CURPFieldFM extends StatelessWidget {
  final String label;
  final void Function(String?) onChange;
  final void Function() onPressInfo;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool errorDuplicate;
  final bool lastItem;

  const CURPFieldFM(
      {super.key,
      required this.label,
      required this.onChange,
      required this.onPressInfo,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error,
      required this.errorDuplicate,
      this.lastItem = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
            textInputAction:
                lastItem ? TextInputAction.done : TextInputAction.next,
            onChanged: (value) {
              onChange(value);
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9A-Z]'))
            ],
            textCapitalization: TextCapitalization.characters,
            style: TypefaceStyles.bodyMediumMontserrat,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoratorLogin.getInputDecorator(label,
                    error ? errorBorderColor : borderColor, errorBorderColor,
                    labelColor: error ? null : ColorsFM.neutralDark)
                .copyWith(
              suffixIcon: IconButton(
                onPressed: onPressInfo,
                icon: SvgPicture.asset(iconAlert,
                    color: error || errorDuplicate
                        ? errorBorderColor
                        : ColorsFM.neutralColor),
              ), // myIcon is a 48px-wide widget.
            )),
        if (errorDuplicate) ...[
          Text(
            Languages.of(context).curpDuplicate,
            style: TypefaceStyles.poppinsRegularError,
          )
        ]
      ],
    );
  }
}
