import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';

class CreditCartFourDot extends StatelessWidget {
  const CreditCartFourDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorsFM.primary80),
        ),
        const SizedBox(width: 3),
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorsFM.primary80),
        ),
        const SizedBox(width: 3),
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorsFM.primary80),
        ),
        const SizedBox(width: 3),
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: ColorsFM.primary80),
        ),
      ],
    );
  }
}
