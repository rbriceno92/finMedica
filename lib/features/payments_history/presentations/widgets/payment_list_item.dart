import 'package:app/features/payments_history/domain/entities/payment_record.dart';
import 'package:app/features/payments_history/presentations/bloc/payments_history_state.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/format_date.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class PaymentListItem extends StatelessWidget {
  final PaymentRecord data;
  final void Function()? onPress;

  const PaymentListItem({
    super.key,
    required this.data,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    bool rejected = data.status == FilterSelect.failed.name ||
        data.status == FilterSelect.incomplete.name;
    int quantity = int.parse(data.quantity);
    String body = rejected
        ? Languages.of(context).rejectedPayment
        : '${Languages.of(context).packageOf(quantity)} ${quantity == 1 ? Languages.of(context).consult : Languages.of(context).consults}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: rejected ? ColorsFM.errorColor : ColorsFM.green40,
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: marginStandard),
          child: rejected
              ? const Icon(
                  Icons.block,
                  color: Colors.white,
                )
              : SvgPicture.asset(iconConsults, color: Colors.white),
        ),
        const SizedBox(
          width: smallMargin,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              body,
              style: TypefaceStyles.poppinsRegular.copyWith(
                  color: ColorsFM.primary, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: extraSmallMargin / 2,
            ),
            Text(
                NumberFormat.currency(locale: 'es_419', symbol: '\$')
                    .format(data.amount / 100),
                style: TypefaceStyles.montserratSM16.copyWith(
                  color: rejected ? ColorsFM.errorColor : ColorsFM.primary,
                )),
            const SizedBox(
              height: extraSmallMargin / 2,
            ),
            Text(
                dateMillisecondsFormatLocal(data.created)
                    .capitalizeOnlyFirstWord(),
                style: TypefaceStyles.poppinsRegular11
                    .copyWith(color: ColorsFM.neutralColor)),
          ],
        )),
        const SizedBox(
          width: marginStandard,
        ),
        GestureDetector(
            onTap: onPress,
            child: SvgPicture.asset(
              arrowRight,
              height: 24,
              width: 24,
              color: ColorsFM.neutral90,
            ))
      ],
    );
  }
}
