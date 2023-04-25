import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/presentation/widgets/store_info_dialog.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class StoreBottomSheet extends StatelessWidget {
  final CartItem item;

  const StoreBottomSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
      Container(
        margin: const EdgeInsets.only(
          top: smallMargin,
        ),
        height: 24,
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          height: 2,
          width: 65,
          decoration: const BoxDecoration(
              color: Color(0xff1c1b1f),
              borderRadius: BorderRadius.all(Radius.circular(1))),
        ),
      ),
      Stack(children: [
        Positioned(
          bottom: 0,
          right: -66,
          child: SvgPicture.asset(
            iconConsults,
            height: 174,
            color: ColorsFM.primaryLight99,
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.only(
                right: marginStandard, left: marginStandard),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: extraSmallMargin,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(Languages.of(context).quantityConsult(item.quantity),
                    style: TypefaceStyles.poppinsMedium16.copyWith(
                      color: ColorsFM.primary,
                    )),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const StoreInfoDialog();
                        });
                  },
                  child: SvgPicture.asset(
                    iconAlert,
                    height: 24,
                    color: ColorsFM.primary80,
                  ),
                ),
              ]),
              Text(
                NumberFormat.currency(locale: 'es_419', symbol: '\$')
                    .format(item.amount),
                style: TypefaceStyles.poppinsMedium16
                    .copyWith(color: ColorsFM.green40),
              ),
              const SizedBox(
                height: extraSmallMargin,
              ),
              RichText(
                text: TextSpan(
                  style: TypefaceStyles.poppinsRegular11
                      .copyWith(color: ColorsFM.neutralDark),
                  children: <TextSpan>[
                    TextSpan(
                      text: Languages.of(context).storeBottomSheetTextP1,
                    ),
                    TextSpan(
                      text:
                          '${item.quantity} ${Languages.of(context).consults.toLowerCase()}',
                      style: TypefaceStyles.poppinsRegular11.copyWith(
                          color: ColorsFM.neutralDark,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: Languages.of(context).storeBottomSheetTextP2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: marginStandard,
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconCupon,
                      height: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: extraSmallMargin,
                    ),
                    Text(Languages.of(context).addPackage,
                        style: TypefaceStyles.buttonPoppinsSemiBold14
                            .copyWith(color: Colors.white)),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, storeCartRoute, arguments: item);
                },
              ),
              SizedBox(
                height: mediumMargin + MediaQuery.of(context).padding.bottom,
                width: mediumMargin,
              ),
            ]),
          ),
        )
      ])
    ]);
  }
}
