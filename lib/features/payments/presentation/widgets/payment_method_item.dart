import 'package:app/features/payments/domain/entity/payment_method.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_bloc.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_events.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_state.dart';
import 'package:app/features/payments/presentation/widgets/delete_payment_method_dialog.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethod data;
  const PaymentMethodItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentMethodsBloc, PaymentMethodsState>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: smallMargin),
        child: SizedBox(
          height: 54,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(
                  cardIcon(data.brand),
                ),
                fit: BoxFit.cover,
                height: 28,
              ),
              Text(
                '**** ${data.number}',
                style: TypefaceStyles.bodyMediumMontserrat,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                          context: context,
                          builder: (context) =>
                              DeletePaymentMethodDialog(number: data.number))
                      .then((value) {
                    if (value != null) {
                      context
                          .read<PaymentMethodsBloc>()
                          .add(RemovePaymentMethod(paymentMethodId: data.id));
                    }
                  });
                },
                child: SvgPicture.asset(
                  iconDelete,
                  height: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
