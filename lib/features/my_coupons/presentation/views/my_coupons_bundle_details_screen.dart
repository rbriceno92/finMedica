import 'package:app/core/di/modules.dart';
import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_detail_bloc.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_detail_state.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_detail_events.dart';
import 'package:app/features/my_coupons/presentation/widgets/credit_cart_four_dot.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/format_date.dart';
import 'package:app/util/string_extensions.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class MyCouponsBundleDetailsScreen extends StatelessWidget {
  final Coupon bundle;
  const MyCouponsBundleDetailsScreen({super.key, required this.bundle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyCouponsDetailBloc>()
        ..add(FetchData(couponId: bundle.id, couponType: bundle.type)),
      child: const MyCouponsBundleDetailsView(),
    );
  }
}

class MyCouponsBundleDetailsView extends StatelessWidget {
  const MyCouponsBundleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCouponsDetailBloc, MyCouponsDetailState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show &&
            !_isThereCurrentDialogShowing(context)) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close &&
            _isThereCurrentDialogShowing(context)) {
          Navigator.popUntil(context,
              (route) => route.settings.name == myCouponsBundleDetailsRoute);
          context.read<MyCouponsDetailBloc>().add(DisposeLoading());
        }
        if (state.errorMessage.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 100)).then((value) {
            AlertNotification.error(context, state.errorMessage);
          });
        }
      },
      builder: (context, state) {
        var plural = state.bundle.quantity == 1 ? '' : 's';
        return Scaffold(
          backgroundColor: ColorsFM.primaryLight99,
          appBar: AppBar(
            title: Text(Languages.of(context).bundleDetails),
            backgroundColor: state.bundle.type == CouponType.membership
                ? ColorsFM.green95
                : ColorsFM.green40,
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: 140,
              decoration: BoxDecoration(
                  color: state.bundle.type == CouponType.membership
                      ? ColorsFM.green95
                      : ColorsFM.green40,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(100))),
              child: Stack(children: [
                state.bundle.type == CouponType.membership
                    ? Positioned(
                        bottom: 0,
                        right: extraSmallMargin,
                        child: SvgPicture.asset(
                          iconHeaderLeaf,
                          height: 140,
                          color: ColorsFM.green70,
                        ),
                      )
                    : Positioned(
                        top: 0,
                        right: -mediumMargin,
                        child: SvgPicture.asset(
                          iconConsults,
                          height: 136,
                          color: ColorsFM.green60.withOpacity(0.4),
                        ),
                      ),
                Positioned(
                  top: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: marginStandard)
                              .copyWith(top: smallMargin),
                          child: Text(
                              state.bundle.type == CouponType.membership
                                  ? state.bundle.name.capitalizeAllWord()
                                  : Languages.of(context).bundleText,
                              style: TypefaceStyles.poppinsSemiBold.copyWith(
                                color: Colors.white,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: marginStandard, top: smallMargin),
                          child: Text(
                            state.bundle.quantity.toString(),
                            style: TypefaceStyles.poppinsSemiBold40
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: marginStandard,
                          ),
                          child: Text(
                            Languages.of(context).consults.toLowerCase(),
                            style: TypefaceStyles.poppinsSemiBold28
                                .copyWith(color: Colors.white, height: 1),
                          ),
                        ),
                      ]),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: mediumMargin),
              child: state.bundle.type == CouponType.membership
                  ? RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: TypefaceStyles.bodySmallMontserrat12,
                            text: Languages.of(context)
                                .membershipItemDescription(
                                    state.bundle.quantity, plural),
                          ),
                          TextSpan(
                            style: TypefaceStyles.bodySmallMontserrat12
                                .copyWith(fontWeight: FontWeight.w700),
                            text: state.bundle.type != CouponType.membership
                                ? ' '
                                : '${state.bundle.name.capitalizeAllWord()}, ',
                          ),
                          TextSpan(
                            style: TypefaceStyles.bodySmallMontserrat12,
                            text: Languages.of(context)
                                .availableForYouAndGroup
                                .capitalizeOnlyFirstWord(),
                          )
                        ],
                      ),
                    )
                  : Text(
                      '${Languages.of(context).packageOfConsults(state.bundle.quantity, plural)} ${Languages.of(context).availableForYouAndGroup.capitalizeOnlyFirstWord()}',
                      style: TypefaceStyles.bodySmallMontserrat12),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: mediumMargin),
              child: Text(Languages.of(context).paymentMethod,
                  style: TypefaceStyles.semiBoldMontserrat),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: extraSmallMargin),
              child: Row(
                children: [
                  Image(
                    image: AssetImage(
                      cardIcon(state.bundle.creditCardBrand.isEmpty
                          ? 'unknown'
                          : state.bundle.creditCardBrand),
                    ),
                    fit: BoxFit.cover,
                    height: 28,
                  ),
                  const SizedBox(width: smallMargin),
                  const CreditCartFourDot(),
                  const SizedBox(width: smallMargin),
                  const CreditCartFourDot(),
                  const SizedBox(width: smallMargin),
                  Text(
                    state.bundle.creditCard,
                    style: TypefaceStyles.bodySmallMontserrat12,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: mediumMargin),
              child: Text(Languages.of(context).purchaseDate,
                  style: TypefaceStyles.semiBoldMontserrat),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: extraSmallMargin),
              child: Text(
                  state.bundle.purchaseDate
                      .consultsDateFormat()
                      .capitalizeOnlyFirstWord(),
                  style: TypefaceStyles.bodySmallMontserrat12),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: mediumMargin),
              child: Text(Languages.of(context).amountPaid,
                  style: TypefaceStyles.semiBoldMontserrat),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard)
                  .copyWith(top: extraSmallMargin),
              child: Text(
                  NumberFormat.currency(locale: 'es_419', symbol: '\$')
                      .format(state.bundle.amount),
                  style: TypefaceStyles.bodySmallMontserrat12),
            ),
          ]),
        );
      },
    );
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}
