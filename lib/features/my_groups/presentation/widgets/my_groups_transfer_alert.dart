import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyGroupsTransferAlert extends StatelessWidget {
  final String name;
  const MyGroupsTransferAlert({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
          top: mediumMargin,
          bottom: mediumMargin,
          left: mediumMargin,
          right: mediumMargin),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconCouponTransfer,
            height: 68,
          ),
          const SizedBox(height: smallMargin),
          Padding(
              padding: const EdgeInsets.only(bottom: marginStandard),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Languages.of(context).areAboutToTransfer,
                    style: TypefaceStyles.bodyMediumMontserrat,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: extraSmallMargin),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TypefaceStyles.poppinsSemiBold24Primary,
                  ),
                  const SizedBox(height: extraSmallMargin),
                  Text(
                    Languages.of(context).wantToContinue,
                    textAlign: TextAlign.center,
                    style: TypefaceStyles.bodyMediumMontserrat,
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      side:
                          const BorderSide(width: 1, color: ColorsFM.green40)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Languages.of(context).cancel,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: ColorsFM.green40,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: extraSmallMargin,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    Languages.of(context).continueText,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
