import 'package:app/features/my_groups/presentation/widgets/form_required_text.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormDateField extends StatelessWidget {
  final String label;
  final void Function(String) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;
  final bool isRequired;
  final TextEditingController controllerText;
  final bool enabled;

  const FormDateField({
    super.key,
    required this.label,
    required this.onChange,
    this.borderColor = ColorsFM.neutralColor,
    this.errorBorderColor = ColorsFM.errorColor,
    required this.error,
    this.isRequired = false,
    required this.controllerText,
    this.enabled = true,
  });

  void _onFocusChange(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controllerText.text.isEmpty
            ? DateTime.now()
            : DateFormat('dd/MM/yyyy').parse(controllerText.text),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        fieldHintText: 'dd/mm/yyyy',
        keyboardType: TextInputType.datetime);

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controllerText.text = formattedDate;
      onChange(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FormRequiredText(isRequired),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (enabled) _onFocusChange(context);
          },
          child: TextFormField(
              controller: controllerText,
              enabled: false,
              style: TypefaceStyles.bodyMediumMontserrat,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoratorLogin.getInputDecorator(label,
                  error ? errorBorderColor : borderColor, errorBorderColor,
                  labelColor: error ? null : ColorsFM.neutralDark)),
        ),
      )
    ]);
  }
}
