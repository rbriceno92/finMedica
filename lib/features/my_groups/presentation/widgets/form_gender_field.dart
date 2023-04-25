import 'package:app/features/my_groups/presentation/widgets/form_required_text.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';

class FormGenderField extends StatelessWidget {
  final String label;
  final void Function(Genders?) onChange;
  final bool isRequired;
  final Genders? value;
  final bool enabled;

  const FormGenderField(
      {super.key,
      required this.label,
      required this.onChange,
      this.isRequired = false,
      this.value,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      FormRequiredText(isRequired),
      Stack(children: [
        TextFormField(
            textInputAction: TextInputAction.next,
            enabled: false,
            style: TypefaceStyles.bodyMediumMontserrat,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoratorLogin.getInputDecorator(
                label, ColorsFM.neutralColor, ColorsFM.neutralColor,
                labelColor: ColorsFM.neutralDark)),
        Center(
          heightFactor: 1.5,
          child: Row(children: [
            Row(children: [
              Radio<Genders>(
                fillColor: MaterialStateColor.resolveWith(
                    (states) => ColorsFM.green40),
                value: Genders.f,
                visualDensity: VisualDensity.compact,
                groupValue: value,
                onChanged: (Genders? value) {
                  if (enabled) onChange(value);
                },
              ),
              Text(
                Languages.of(context).female,
                style: TypefaceStyles.poppinsRegular,
              ),
            ]),
            Row(children: [
              Radio<Genders>(
                value: Genders.m,
                fillColor: MaterialStateColor.resolveWith(
                    (states) => ColorsFM.green40),
                visualDensity: VisualDensity.compact,
                groupValue: value,
                onChanged: (Genders? value) {
                  if (enabled) onChange(value);
                },
              ),
              Text(
                Languages.of(context).male,
                style: TypefaceStyles.poppinsRegular,
              ),
            ]),
          ]),
        )
      ])
    ]);
  }
}
