import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFieldFM extends StatefulWidget {
  final String label;
  final void Function(String) onChange;
  final Color borderColor;
  final Color errorBorderColor;
  final bool error;

  const DateFieldFM(
      {super.key,
      required this.label,
      required this.onChange,
      this.borderColor = ColorsFM.neutralColor,
      this.errorBorderColor = ColorsFM.errorColor,
      required this.error});

  @override
  State<DateFieldFM> createState() => _DateFieldFMState();
}

class _DateFieldFMState extends State<DateFieldFM> {
  final TextEditingController dateField = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dateField.dispose();
  }

  void _onFocusChange() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateField.text.isEmpty
            ? DateTime.now()
            : DateFormat('dd/MM/yyyy').parse(dateField.text),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        fieldHintText: 'dd/mm/yyyy',
        keyboardType: TextInputType.datetime);

    String currentDay = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String formattedDate =
        pickedDate != null ? DateFormat('dd/MM/yyyy').format(pickedDate) : '';

    if (currentDay != formattedDate && formattedDate != '') {
      setState(() {
        dateField.text = formattedDate;
      });
      widget.onChange(formattedDate);
    } else {
      widget.onChange(dateField.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _onFocusChange,
        child: TextFormField(
          controller: dateField,
          enabled: false,
          style: TypefaceStyles.bodyMediumMontserrat,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoratorLogin.getInputDecorator(
              widget.label,
              widget.error ? widget.errorBorderColor : widget.borderColor,
              widget.errorBorderColor,
              labelColor: widget.error ? null : ColorsFM.neutralDark),
        ),
      ),
    );
  }
}
