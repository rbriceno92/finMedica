import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final bool isLast;
  final bool isSelected;
  const Dot({super.key, required this.isLast, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.only(
        bottom: marginStandard,
        right: isLast ? 0 : smallMargin / 2,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.0, color: const Color(0xFFFFFFFF)),
        color: isSelected ? Colors.white : Colors.transparent,
      ),
    );
  }
}
