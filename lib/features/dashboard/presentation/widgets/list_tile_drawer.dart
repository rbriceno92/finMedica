import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/fonts_types.dart';

enum ListTileTypes { mainTitleUser, mainTitle, itemsMain, secondaryItems }

class ListTileDrawer extends StatelessWidget {
  final ListTileTypes type;
  final String text;
  final String? iconSvg;
  final Color? color;
  final Function()? onClick;
  const ListTileDrawer(
      {Key? key,
      required this.type,
      required this.text,
      required this.iconSvg,
      this.color,
      this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: type == ListTileTypes.itemsMain ? false : true,
      onTap: onClick,
      contentPadding:
          const EdgeInsets.only(left: mediumMargin, top: 0, bottom: 0),
      visualDensity: const VisualDensity(vertical: -3),
      minLeadingWidth: 2,
      leading: type == ListTileTypes.itemsMain
          ? SvgPicture.asset(
              iconSvg!,
              color: color,
            )
          : null,
      title: Text(text, style: getStyle(type)),
    );
  }

  TextStyle getStyle(ListTileTypes type) {
    switch (type) {
      case ListTileTypes.mainTitleUser:
        return TypefaceStyles.poppinsSemiBold24Primary;
      case ListTileTypes.mainTitle:
        return TypefaceStyles.poppinsSemiBold14Primary;
      case ListTileTypes.itemsMain:
        return TypefaceStyles.bodyMediumMontserrat;
      case ListTileTypes.secondaryItems:
        return TypefaceStyles.bodyMediumMontserrat;
      default:
        return TypefaceStyles.bodyMediumMontserrat;
    }
  }
}
