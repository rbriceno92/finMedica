import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterByNameInput extends StatelessWidget {
  final void Function(String value)? onChanged;
  final String hintText;
  final TextEditingController? controller;
  const FilterByNameInput(
      {super.key, this.onChanged, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          onChanged!(value);
        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: marginStandard),
            child: SvgPicture.asset(iconSearch),
          ),
          contentPadding: const EdgeInsets.only(left: mediumMargin),
          fillColor: ColorsFM.blueLight90,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(34),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
          hintText: hintText,
          hintStyle: TypefaceStyles.bodyMediumMontserrat
              .copyWith(color: ColorsFM.primary),
        ),
        style: TypefaceStyles.bodyMediumMontserrat
            .copyWith(color: ColorsFM.primary),
      ),
    );
  }
}
