import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/format_date.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';

class MyCouponsCouponDetailsScreen extends StatelessWidget {
  final Coupon coupon;
  final bool isSended;
  const MyCouponsCouponDetailsScreen(
      {super.key, required this.coupon, this.isSended = false});

  @override
  Widget build(BuildContext context) {
    String plural = coupon.quantity > 1 ? 's' : '';
    String connector = isSended ? 'a' : 'por';
    String body2 = coupon.type == CouponType.refund
        ? Languages.of(context).refundedCancellationLong
        : coupon.type == CouponType.transfer
            ? Languages.of(context).transferredMessageAlert(plural, connector)
            : Languages.of(context).availableForYouAndGroup;
    Color headerTextColor =
        coupon.type == CouponType.bonus ? Colors.white : ColorsFM.primary99;
    Color itemColor =
        coupon.type == CouponType.package ? ColorsFM.green40 : ColorsFM.primary;
    itemColor = coupon.type == CouponType.bonus ? ColorsFM.green70 : itemColor;
    itemColor =
        coupon.type == CouponType.transfer ? ColorsFM.primary60 : itemColor;
    Color iconColor = coupon.type == CouponType.bonus
        ? ColorsFM.green99.withOpacity(0.2)
        : ColorsFM.primary50;
    iconColor =
        coupon.type == CouponType.transfer ? ColorsFM.blueDark90 : iconColor;
    return Scaffold(
      backgroundColor: ColorsFM.neutral30.withOpacity(0.7),
      body: SafeArea(
        child: Column(children: [
          Container(
            alignment: Alignment.centerRight,
            width: double.infinity,
            child: IconButton(
              onPressed: () => Navigator.pop(context, true),
              icon: SvgPicture.asset(
                iconCancel,
                color: Colors.white,
                height: 24,
              ),
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                48 -
                (374.5 / 2),
          ),
          Stack(children: [
            SvgPicture.asset(ticketMaskDetail),
            SizedBox(
              height: 374.5,
              width: 328,
              child: Column(children: [
                Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 96,
                    decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(coupon.quantityAvailable.toString(),
                              style: TypefaceStyles.poppinsSemiBold40
                                  .copyWith(color: Colors.white)),
                          Text(
                            coupon.quantityAvailable == 1
                                ? '${Languages.of(context).consult} ${coupon.type == CouponType.refund ? Languages.of(context).refundedSinglularText : coupon.type == CouponType.transfer ? Languages.of(context).transferredTextSingular : Languages.of(context).availableOne}'
                                : '${Languages.of(context).consults} ${coupon.type == CouponType.refund ? Languages.of(context).refundedPluralText : coupon.type == CouponType.transfer ? Languages.of(context).transferredText : Languages.of(context).available}',
                            style: TypefaceStyles.buttonPoppinsSemiBold14
                                .copyWith(
                                    letterSpacing: 0, color: headerTextColor),
                          )
                        ]),
                  ),
                  Positioned(
                    top: 3.5,
                    left: -29.6,
                    child: SvgPicture.asset(
                      iconCupon,
                      width: 89.1,
                      color: iconColor,
                    ),
                  ),
                ]),
                SizedBox(
                  height: 140.5,
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    if (coupon.type == CouponType.refund)
                      const SizedBox(
                        height: marginStandard,
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: extraLargeMargin,
                          right: extraLargeMargin,
                          top: marginStandard),
                      child: Text(
                        textAlign: TextAlign.center,
                        '${displayTextBody1(context)} $body2',
                        style: TypefaceStyles.bodySmallMontserrat12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: extraLargeMargin,
                          right: extraLargeMargin,
                          top: extraSmallMargin),
                      child: coupon.type == CouponType.refund
                          ? Container()
                          : showCouponPurchaseDate(context),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 137,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (coupon.type == CouponType.refund) ...[
                          const SizedBox(
                            height: largeMargin,
                          ),
                          showCouponPurchaseDate(context),
                        ] else ...[
                          coupon.type == CouponType.transfer
                              ? showTextTransfer(context)
                              : Text(
                                  Languages.of(context).couponCode,
                                  style: TypefaceStyles.bodySmallMontserrat12,
                                ),
                          const SizedBox(
                            height: extraSmallMargin,
                          ),
                          coupon.type == CouponType.transfer
                              ? Container()
                              : Text(
                                  coupon.couponCode,
                                  style: TypefaceStyles.poppinsRegular28
                                      .copyWith(
                                          color:
                                              coupon.type == CouponType.refund
                                                  ? ColorsFM.neutral90
                                                  : ColorsFM.green40),
                                ),
                        ],
                      ]),
                )
              ]),
            )
          ]),
        ]),
      ),
    );
  }

  displayTextBody1(BuildContext context) {
    String plural = coupon.quantity > 1 ? 's' : '';
    if (coupon.type == CouponType.refund) {
      return Languages.of(context)
          .bonusOfSeveralConsultsRefunds(coupon.quantity, plural);
    }

    if (coupon.type == CouponType.transfer) {
      return Languages.of(context).bonusOfConsults(coupon.quantity, plural);
    }

    if (coupon.type == CouponType.bonus) {
      return Languages.of(context)
          .bonusValidOfConsults(coupon.quantity, plural);
    }
  }

  showTextTransfer(BuildContext context) {
    if (coupon.type == CouponType.transfer) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: extraLargeMargin,
        ),
        child: Column(
          children: [
            Text(
              isSended
                  ? Languages.of(context).transferredTo
                  : Languages.of(context).transferredBy,
              style: TypefaceStyles.bodySmallMontserrat12,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              isSended ? coupon.transferredTo : coupon.transferredBy,
              style: TypefaceStyles.poppinsRegular20,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  showCouponPurchaseDate(BuildContext context) {
    return Column(
      children: [
        coupon.purchaseDate.isNotEmpty
            ? Text(
                textAlign: TextAlign.center,
                '${Languages.of(context).activationDate} ${coupon.purchaseDate.dateFormatLocal()}.',
                style: TypefaceStyles.poppinsRegular11
                    .copyWith(color: ColorsFM.neutral90),
              )
            : Container(),
        Text(
          Languages.of(context).couponValid,
          style: TypefaceStyles.poppinsRegular11
              .copyWith(color: ColorsFM.neutral90),
        )
      ],
    );
  }
}
