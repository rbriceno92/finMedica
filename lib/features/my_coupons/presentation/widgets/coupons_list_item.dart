import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_bloc.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_events.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_state.dart';
import 'package:app/features/my_coupons/presentation/views/my_coupons_coupon_details_screen.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CouponsListItem extends StatelessWidget {
  final Coupon coupon;

  const CouponsListItem({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    String plural = coupon.quantity == 1 ? '' : 's';
    String bodyTop;
    String body;
    Color itemColor;
    Color iconColor;
    switch (coupon.type) {
      case CouponType.membership:
        itemColor = ColorsFM.green95;
        iconColor = ColorsFM.green70;
        body = Languages.of(context)
            .availableForYouAndGroup
            .capitalizeOnlyFirstWord();
        bodyTop = Languages.of(context)
            .membershipItemDescription(coupon.quantity, plural);
        break;
      case CouponType.bonus:
        itemColor = ColorsFM.green70;
        iconColor = ColorsFM.green99.withOpacity(0.2);
        body = Languages.of(context)
            .availableForYouAndGroup
            .capitalizeOnlyFirstWord();
        bodyTop =
            Languages.of(context).bonusOfConsults(coupon.quantity, plural);
        break;
      case CouponType.transfer:
        itemColor = ColorsFM.primary60;
        iconColor = ColorsFM.primary80.withOpacity(0.2);
        bodyTop =
            Languages.of(context).bonusOfConsults(coupon.quantity, plural);
        body = Languages.of(context)
            .transferredByText(coupon.transferredBy, plural);
        break;
      case CouponType.refund:
        itemColor = ColorsFM.primary;
        iconColor = ColorsFM.green99.withOpacity(0.2);
        body = Languages.of(context)
            .refundedCancellationOf(coupon.quantity == 1 ? '' : 's');
        bodyTop =
            Languages.of(context).bonusOfConsults(coupon.quantity, plural);
        break;
      default:
        itemColor = ColorsFM.green40;
        iconColor = ColorsFM.primaryLight99.withOpacity(0.1);
        body = Languages.of(context)
            .availableForYouAndGroup
            .capitalizeOnlyFirstWord();
        bodyTop =
            Languages.of(context).packageOfConsults(coupon.quantity, plural);
    }

    return BlocConsumer<MyCouponsBloc, MyCouponsState>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: marginStandard - 2),
        child: GestureDetector(
          onTap: () {
            if (coupon.type == CouponType.package ||
                coupon.type == CouponType.membership) {
              Navigator.pushNamed(context, myCouponsBundleDetailsRoute,
                  arguments: coupon);
            } else {
              context.read<MyCouponsBloc>().add(FetchDetail(
                    couponId: coupon.id,
                    couponType: coupon.type,
                    onSucces: (coupon) =>
                        Future.delayed(const Duration(milliseconds: 100)).then(
                      (value) => showGeneralDialog(
                        context: context,
                        barrierColor: ColorsFM.neutral30.withOpacity(0.7),
                        barrierDismissible: false,
                        barrierLabel: 'Coupon detail',
                        pageBuilder: (contex, __, ___) {
                          return MyCouponsCouponDetailsScreen(coupon: coupon);
                        },
                      ),
                    ),
                  ));
            }
          },
          child: Stack(children: [
            const Positioned(
              child: Image(
                image: AssetImage(ticketMask),
                width: double.infinity,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 97,
                  height: 96,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8))),
                  child: Stack(children: [
                    if (coupon.type != CouponType.membership)
                      Positioned(
                        top: 6,
                        left: -27,
                        child: SvgPicture.asset(
                          coupon.type == CouponType.package
                              ? iconConsults
                              : iconCupon,
                          width: 84,
                          color: iconColor,
                        ),
                      ),
                    if (coupon.type == CouponType.membership)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          iconHeaderLeaf,
                          color: iconColor,
                          width: 57,
                        ),
                      ),
                    Positioned(
                      top: 22,
                      left: smallMargin,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              coupon.quantityAvailable.toString(),
                              style: TypefaceStyles.poppinsSemiBold40
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                                coupon.quantityAvailable == 1
                                    ? Languages.of(context).consult
                                    : Languages.of(context).consults,
                                style: TypefaceStyles.buttonPoppinsSemiBold14
                                    .copyWith(
                                  color: Colors.white,
                                )),
                          ]),
                    )
                  ]),
                ),
                Flexible(
                  child: Container(
                    height: 96,
                    padding: const EdgeInsets.only(
                        left: marginStandard, right: largeDivision),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TypefaceStyles.bodySmallMontserrat12,
                              text: bodyTop,
                            ),
                            TextSpan(
                              style: TypefaceStyles.bodySmallMontserrat12
                                  .copyWith(fontWeight: FontWeight.w700),
                              text: coupon.type != CouponType.membership
                                  ? ' '
                                  : '${coupon.name.capitalizeAllWord()}, ',
                            ),
                            TextSpan(
                              style: TypefaceStyles.bodySmallMontserrat12,
                              text: body,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
