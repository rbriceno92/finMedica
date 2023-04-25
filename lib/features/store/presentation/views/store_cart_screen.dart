import 'package:app/core/di/modules.dart';
import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/features/store/presentation/bloc/store_cart_bloc.dart';
import 'package:app/features/store/presentation/bloc/store_cart_events.dart';
import 'package:app/features/store/presentation/bloc/store_cart_state.dart';
import 'package:app/features/store/presentation/widgets/cart_item_widget.dart';
import 'package:app/features/store/presentation/widgets/setup_payment_sheet.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StoreCartScreen extends StatelessWidget {
  final CartItem item;
  const StoreCartScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<StoreCartBloc>()..add(SetCartItem(item)),
        child: const StoreCartView());
  }
}

class StoreCartView extends StatelessWidget {
  const StoreCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCartBloc, StoreCartState>(
      listener: (context, state) async {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          if (state.customerId != null &&
              state.paymentIntentClientSecret != null) {
            try {
              await Stripe.instance.initPaymentSheet(
                  paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: Languages.of(context).appName,
                paymentIntentClientSecret: state.paymentIntentClientSecret,
                customerId: state.customerId,
                customerEphemeralKeySecret: state.customerEphemeralKeySecret,
                appearance: paymentSheetAppearance,
              ));
              Future.delayed(const Duration(microseconds: 100)).then((value) {
                Navigator.pop(context);
                context.read<StoreCartBloc>().add(DisposeLoading());
              });
            } catch (error) {
              Navigator.pop(context);
              context.read<StoreCartBloc>().add(DisposeLoading());
              if (error is StripeException) {
                AlertNotification.error(
                    context, '${error.error.localizedMessage}');
              } else {
                AlertNotification.error(context, 'Error');
              }
            }
          } else {
            Navigator.pop(context);
            context.read<StoreCartBloc>().add(DisposeLoading());
          }
        }
        if (state.loading == LoadingState.dispose &&
            state.customerId != null &&
            state.paymentIntentClientSecret != null) {
          try {
            await Stripe.instance.presentPaymentSheet();
            Future.delayed(const Duration(microseconds: 100)).then((value) {
              AlertNotification.success(context, 'Pago Exitoso');
              context.read<StoreCartBloc>().add(const SetCartItem(null));
            });
          } on Exception catch (e) {
            if (e is StripeException) {
              if (e.error.code == FailureCode.Failed) {
                Future.delayed(const Duration(microseconds: 100)).then((value) {
                  AlertNotification.error(
                      context, '${e.error.localizedMessage}');
                });
              }
            } else {
              Future.delayed(const Duration(microseconds: 100)).then((value) {
                AlertNotification.error(context, 'Error');
              });
            }
          }
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).services),
          backgroundColor: ColorsFM.green40,
        ),
        body: Padding(
          padding: const EdgeInsets.all(marginStandard),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(Languages.of(context).cartSummary,
                style: TypefaceStyles.poppinsSemiBold22
                    .copyWith(color: ColorsFM.primary)),
            const SizedBox(height: mediumMargin),
            if (state.item != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartItemWidget(
                      amount: state.item!.amount,
                      quantity: state.item!.quantity,
                      onPressed: () {
                        context
                            .read<StoreCartBloc>()
                            .add(const SetCartItem(null));

                        AlertNotification.success(
                            context, Languages.of(context).deleteCartItem);
                      },
                    ),
                  ],
                ),
              ),
            if (state.item == null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      Languages.of(context).hasNoPackegesAdded,
                      textAlign: TextAlign.center,
                      style: TypefaceStyles.poppinsSemiBold22
                          .copyWith(color: ColorsFM.blueDark90),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: smallMargin,
                    ),
                    Text(
                      Languages.of(context).goBackStoreToAddPackeges,
                      textAlign: TextAlign.center,
                      style: TypefaceStyles.bodySmallMontserrat12
                          .copyWith(color: ColorsFM.primary80),
                    )
                  ],
                ),
              ),
            ElevatedButton(
                onPressed: state.item == null
                    ? null
                    : () async {
                        context.read<StoreCartBloc>().add(PayCartItem(
                          onError: (message) {
                            Future.delayed(const Duration(microseconds: 100))
                                .then((_) =>
                                    AlertNotification.error(context, message));
                          },
                        ));
                      },
                child: Text(Languages.of(context).continuePay)),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ]),
        ),
      ),
    );
  }
}
