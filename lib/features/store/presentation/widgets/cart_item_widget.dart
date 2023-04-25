import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CartItemWidget extends StatelessWidget {
  final void Function()? onPressed;
  final int quantity;
  final double amount;
  const CartItemWidget(
      {super.key,
      this.onPressed,
      required this.quantity,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: Border.all(color: ColorsFM.blueLight90, width: 1),
          color: Colors.white,
          borderRadius:
              const BorderRadius.all(Radius.circular(radiusRounded8))),
      height: 96,
      child: Row(children: [
        SizedBox(
          width: 106,
          height: 96,
          child: Stack(children: [
            Positioned(
                top: 6,
                left: -27,
                child: SvgPicture.asset(
                  iconConsults,
                  width: 84,
                  color: ColorsFM.primaryLight99,
                )),
            Positioned(
              top: marginStandard,
              left: marginStandard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 28,
                    child: Text(
                      quantity.toString(),
                      style: TypefaceStyles.poppinsSemiBold40
                          .copyWith(color: ColorsFM.primary60, height: 1),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    quantity == 1
                        ? Languages.of(context).consult
                        : Languages.of(context).consults,
                    style: TypefaceStyles.buttonPoppinsSemiBold14
                        .copyWith(color: ColorsFM.primary60),
                  ),
                  Text(
                    NumberFormat.currency(locale: 'es_419', symbol: '\$')
                        .format(amount),
                    style: const TextStyle(
                        color: ColorsFM.green40,
                        fontWeight: FontWeight.w600,
                        //fontFamily: "Poppins",
                        fontStyle: FontStyle.normal,
                        height: 1.666,
                        fontSize: 12.0,
                        letterSpacing: 0.09),
                  ),
                ],
              ),
            )
          ]),
        ),
        const SizedBox(
          height: smallMargin,
          width: smallMargin,
        ),
        Flexible(
          child: Text(
              quantity == 1
                  ? Languages.of(context).cartItemInfoOne
                  : Languages.of(context).cartItemInfo(quantity),
              style: TypefaceStyles.poppinsRegular11),
        ),
        const SizedBox(
          height: smallMargin,
          width: smallMargin,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 49,
            height: 95,
            alignment: Alignment.center,
            color: ColorsFM.blueDark90,
            child: onPressed != null
                ? SvgPicture.asset(
                    iconCancel,
                    color: Colors.white,
                    width: 25,
                  )
                : null,
          ),
        ),
      ]),
    );
  }
}
