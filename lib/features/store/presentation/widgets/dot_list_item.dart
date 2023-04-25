import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';

class DotListItem extends StatelessWidget {
  final Widget content;
  const DotListItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          height: 7,
          width: 7,
          alignment: Alignment.topLeft,
          decoration: const BoxDecoration(
              color: ColorsFM.neutralDark,
              borderRadius: BorderRadius.all(Radius.circular(3.5))),
        ),
        const SizedBox(
          width: smallMargin,
          height: smallMargin,
        ),
        Flexible(child: content),
      ],
    );
  }
}
