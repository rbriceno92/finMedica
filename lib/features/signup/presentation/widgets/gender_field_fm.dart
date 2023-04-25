import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';

class GenderFieldFM extends StatefulWidget {
  final String label;
  final void Function(Genders?) onChange;
  const GenderFieldFM({super.key, required this.label, required this.onChange});

  @override
  State<GenderFieldFM> createState() => _GenderFieldFMState();
}

class _GenderFieldFMState extends State<GenderFieldFM> {
  Genders? _gender;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
            textInputAction: TextInputAction.next,
            enabled: false,
            style: TypefaceStyles.bodyMediumMontserrat,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoratorLogin.getInputDecorator(
                widget.label, ColorsFM.neutralColor, ColorsFM.neutralColor,
                labelColor: ColorsFM.neutralDark)),
        Center(
          heightFactor: 1.5,
          child: Row(
            children: [
              Row(
                children: [
                  Radio<Genders>(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => ColorsFM.green40),
                    value: Genders.f,
                    visualDensity: VisualDensity.compact,
                    groupValue: _gender,
                    onChanged: (Genders? value) {
                      widget.onChange(value);
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text(
                    Languages.of(context).female,
                    style: TypefaceStyles.poppinsRegular,
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<Genders>(
                    value: Genders.m,
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => ColorsFM.green40),
                    visualDensity: VisualDensity.compact,
                    groupValue: _gender,
                    onChanged: (Genders? value) {
                      widget.onChange(value);
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text(
                    Languages.of(context).male,
                    style: TypefaceStyles.poppinsRegular,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
