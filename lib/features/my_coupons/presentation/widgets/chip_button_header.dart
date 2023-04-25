import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChipButtonHeader extends StatelessWidget {
  final String label;
  final void Function(bool)? onSelected;
  final String icon;

  const ChipButtonHeader(
      {super.key,
      required this.label,
      required this.onSelected,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: onSelected,
      backgroundColor: ColorsFM.green40,
      selectedColor: ColorsFM.green40,
      disabledColor: ColorsFM.green40,
      showCheckmark: false,
      selected: true,
      labelStyle: TypefaceStyles.poppinsRegular.copyWith(color: Colors.white),
      avatar: SvgPicture.asset(
        icon,
        color: Colors.white,
      ),
    );
  }
}
