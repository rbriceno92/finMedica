import 'package:app/features/store/presentation/widgets/dot_list_item.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class StoreInfoDialog extends StatelessWidget {
  const StoreInfoDialog({super.key});

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
      scrollable: false,
      contentPadding: const EdgeInsets.all(mediumMargin),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            Languages.of(context).packageConditions,
            style: TypefaceStyles.poppinsMedium16
                .copyWith(color: ColorsFM.primary),
          ),
          const SizedBox(
            height: marginStandard,
            width: marginStandard,
          ),
          DotListItem(
              //myCoupons
              content: RichText(
                  text: TextSpan(
                      style: TypefaceStyles.bodySmallMontserrat12,
                      children: [
                TextSpan(text: Languages.of(context).storeInfo1P1),
                TextSpan(
                    text: Languages.of(context).myCoupons,
                    style: TypefaceStyles.bodySmallMontserrat12
                        .copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: Languages.of(context).storeInfo1P2),
              ]))),
          const SizedBox(
            height: extraSmallMargin,
            width: extraSmallMargin,
          ),
          DotListItem(
              content: Text(Languages.of(context).storeInfo2,
                  style: TypefaceStyles.bodySmallMontserrat12)),
          const SizedBox(
            height: extraSmallMargin,
            width: extraSmallMargin,
          ),
          DotListItem(
              content: Text(Languages.of(context).storeInfo3,
                  style: TypefaceStyles.bodySmallMontserrat12)),
          const SizedBox(
            height: mediumMargin,
            width: mediumMargin,
          ),
          ElevatedButton(
            child: Text(Languages.of(context).close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
