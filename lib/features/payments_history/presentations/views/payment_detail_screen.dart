import 'dart:math';

import 'package:app/features/my_coupons/presentation/widgets/credit_cart_four_dot.dart';
import 'package:app/features/payments_history/domain/entities/payment_record.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/format_date.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PaymentDetailScreen extends StatelessWidget {
  final PaymentRecord record;
  const PaymentDetailScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    bool rejected = record.status != 'succeeded';
    int quantity = int.parse(record.quantity);
    return Scaffold(
      backgroundColor: ColorsFM.primaryLight99,
      appBar: AppBar(
        title: Text(Languages.of(context).transactionDetail),
        backgroundColor: rejected ? ColorsFM.errorColor : ColorsFM.green40,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 140,
          decoration: BoxDecoration(
              color: rejected ? ColorsFM.errorColor : ColorsFM.green40,
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(100))),
          child: Stack(children: [
            Positioned(
              top: 0,
              right: -mediumMargin,
              child: rejected
                  ? Icon(
                      Icons.block,
                      color: Colors.white.withOpacity(0.2),
                      size: 136,
                    )
                  : SvgPicture.asset(
                      iconConsults,
                      height: 136,
                      color: ColorsFM.green60.withOpacity(0.4),
                    ),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: marginStandard),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: smallMargin),
                      Text(Languages.of(context).bundleText,
                          style: TypefaceStyles.poppinsSemiBold.copyWith(
                            color: Colors.white,
                          )),
                      const SizedBox(height: smallMargin),
                      Text(
                        record.quantity.toString(),
                        style: TypefaceStyles.poppinsSemiBold40
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        Languages.of(context).consults.toLowerCase(),
                        style: TypefaceStyles.poppinsSemiBold28
                            .copyWith(color: Colors.white, height: 1),
                      ),
                    ]),
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: marginStandard)
              .copyWith(top: mediumMargin),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (rejected) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        iconAlert,
                        color: ColorsFM.errorColor,
                        height: 24,
                      ),
                      const SizedBox(width: extraSmallMargin),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context).paymentMethodFailed,
                            style: TypefaceStyles.bodyMediumMontserrat.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorsFM.errorColor),
                          ),
                          const SizedBox(height: extraSmallMargin / 2),
                          Text(
                            Languages.of(context).paymentMethodFailedMessage,
                            style:
                                TypefaceStyles.montserrat10.copyWith(height: 1),
                          ),
                          const SizedBox(height: smallMargin),
                          Text(
                            Languages.of(context).seeTermsAndConditions,
                            style: TypefaceStyles.bodySmallMontserrat12
                                .copyWith(color: ColorsFM.errorColor),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: mediumMargin),
                ],
                Text(
                    '${Languages.of(context).packageOfConsults(quantity, quantity == 1 ? '' : 's')} ${Languages.of(context).availableForYouAndGroup.capitalizeOnlyFirstWord()}',
                    style: TypefaceStyles.bodySmallMontserrat12),
                const SizedBox(height: mediumMargin),
                rowOrColumn(rejected ? Row : Column, [
                  if (record.paymentMethod != null) ...[
                    rowOrColumn(Column, [
                      Text(Languages.of(context).paymentMethod,
                          style: TypefaceStyles.semiBoldMontserrat),
                      const SizedBox(height: extraSmallMargin),
                      Row(
                        children: [
                          Image(
                            image: AssetImage(
                              cardIcon(
                                  record.paymentMethod?.brand ?? 'unknown'),
                            ),
                            fit: BoxFit.cover,
                            height: 28,
                          ),
                          const SizedBox(width: extraSmallMargin),
                          const CreditCartFourDot(),
                          const SizedBox(width: extraSmallMargin),
                          const CreditCartFourDot(),
                          const SizedBox(width: extraSmallMargin),
                          Text(
                            record.paymentMethod != null
                                ? record.paymentMethod!.number
                                : '',
                            style: TypefaceStyles.bodySmallMontserrat12,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ]),
                    SizedBox(
                        width:
                            min(constraints.maxWidth - 172 - 157, mediumMargin),
                        height: mediumMargin)
                  ],
                  rowOrColumn(Column, [
                    Text(Languages.of(context).transactionDate,
                        style: TypefaceStyles.semiBoldMontserrat),
                    const SizedBox(height: extraSmallMargin),
                    Container(
                      height: 28,
                      alignment: Alignment.centerLeft,
                      child: Text(
                          dateMillisecondsFormatLocal(record.created)
                              .capitalizeOnlyFirstWord(),
                          style: TypefaceStyles.bodySmallMontserrat12),
                    )
                  ]),
                ]),
                const SizedBox(height: mediumMargin),
                Text(Languages.of(context).amountPaid,
                    style: TypefaceStyles.semiBoldMontserrat),
                const SizedBox(height: extraSmallMargin),
                Text(
                    NumberFormat.currency(locale: 'es_419', symbol: '\$')
                        .format(record.amount / 100),
                    style: TypefaceStyles.bodySmallMontserrat12),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget rowOrColumn(Type type, List<Widget> children) {
    if (type.toString() == 'Row') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
  }
}
