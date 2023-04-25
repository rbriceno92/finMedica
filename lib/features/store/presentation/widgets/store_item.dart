import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/presentation/widgets/store_bottom_sheeet.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class StoreItem extends StatelessWidget {
  final bool hide;
  final CartItem item;

  const StoreItem({super.key, required this.item, this.hide = false});

  @override
  Widget build(BuildContext context) {
    if (hide) {
      return const SizedBox(
        width: 156,
        height: 96,
      );
    }
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
            context: context,
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            builder: (context) => StoreBottomSheet(item: item));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            border: Border.all(color: ColorsFM.primary99, width: 0.5),
            color: Colors.white,
            borderRadius:
                const BorderRadius.all(Radius.circular(radiusRounded8))),
        width: 156,
        height: 96,
        child: Row(children: [
          SizedBox(
            width: 106,
            height: 95,
            child: Stack(children: [
              Positioned(
                  top: 4,
                  left: -27,
                  child: SvgPicture.asset(
                    iconConsults,
                    width: 84,
                    color: ColorsFM.primaryLight99,
                  )),
              Positioned(
                top: marginStandard,
                left: extraSmallMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.quantity.toString(),
                      style: TypefaceStyles.poppinsSemiBold40
                          .copyWith(color: ColorsFM.primary60),
                    ),
                    Text(
                      Languages.of(context).consults,
                      style: TypefaceStyles.buttonPoppinsSemiBold14
                          .copyWith(color: ColorsFM.primary60),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'es_419', symbol: '\$')
                          .format(item.amount),
                      style: TypefaceStyles.poppinsSemiBold12NeutralDark
                          .copyWith(color: ColorsFM.green40),
                    ),
                  ],
                ),
              )
            ]),
          ),
          Container(
            width: 49,
            height: 95,
            alignment: Alignment.center,
            color: ColorsFM.green40,
            child: SvgPicture.asset(iconPlus),
          )
        ]),
      ),
    );
  }
}
