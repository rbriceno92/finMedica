import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool selected;

  const FilterButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: ColorsFM.primaryLight80,
      selectedColor: ColorsFM.primary,
      disabledColor: ColorsFM.primaryLight80,
      showCheckmark: false,
      selected: selected,
      onSelected: (bool value) {
        if (onPressed != null) {
          onPressed!();
        }
      },
      labelPadding: const EdgeInsets.symmetric(horizontal: marginStandard),
      label: Text(label),
      labelStyle: TypefaceStyles.poppinsRegular
          .copyWith(color: selected ? Colors.white : ColorsFM.primary60),
    );
  }
}
