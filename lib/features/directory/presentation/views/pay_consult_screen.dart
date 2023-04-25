import 'dart:async';

import 'package:app/core/di/modules.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_pay_bloc.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_pay_events.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_pay_state.dart';
import 'package:app/features/store/presentation/widgets/cart_item_widget.dart';
import 'package:app/features/store/presentation/widgets/setup_payment_sheet.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../util/widgets/spinner_loading.dart';
import '../../data/models/book_appointment_params.dart';

class PayConsultScreen extends StatelessWidget {
  final BookAppointmentParams timeBooked;
  const PayConsultScreen({super.key, required this.timeBooked});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BookAppointmentPayBloc>()..add(const FetchProducts()),
      child: PayConsultScreenView(
        timeBooked: timeBooked,
      ),
    );
  }
}

class PayConsultScreenView extends StatelessWidget {
  final BookAppointmentParams timeBooked;
  const PayConsultScreenView({Key? key, required this.timeBooked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentPayBloc, BookAppointmentPayState>(
      listener: (context, state) async {
        if (state.loading == LoadingState.show &&
            !_isThereCurrentDialogShowing(context)) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          try {
            await Stripe.instance.initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
              merchantDisplayName: Languages.of(context).appName,
              paymentIntentClientSecret: state.paymentIntentClientSecret,
              customerId: state.customerId,
              customerEphemeralKeySecret: state.customerEphemeralKeySecret,
              appearance: paymentSheetAppearance,
            ));
            Future.delayed(const Duration(milliseconds: 100)).then((value) {
              Navigator.pop(context);
              context.read<BookAppointmentPayBloc>().add(DisposeLoading());
            });
          } catch (error) {
            if (error is StripeException) {
              Navigator.pop(context);
              context.read<BookAppointmentPayBloc>().add(DisposeLoading());
              AlertNotification.error(
                  context, '${error.error.localizedMessage}');
              return;
            } else {
              Navigator.pop(context);
              context.read<BookAppointmentPayBloc>().add(DisposeLoading());
              AlertNotification.error(context, ERROR_MESSAGE);
              return;
            }
          }
          if (state.errorMessage.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 100)).then((value) {
              AlertNotification.error(context, state.errorMessage);
            });
          }
        }

        if (state.loading == LoadingState.dispose &&
            state.customerId.isNotEmpty &&
            state.paymentIntentClientSecret.isNotEmpty &&
            !state.isPayded) {
          try {
            await Stripe.instance.presentPaymentSheet();
            Future.delayed(const Duration(microseconds: 100)).then((value) {
              Future.delayed(const Duration(microseconds: 100)).then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    scheduleAppointmentSuccessRoute,
                    (Route<dynamic> route) => false,
                    arguments: true);
              });
            });
          } catch (e) {
            if (e is StripeException) {
              if (e.error.code == FailureCode.Failed) {
                Future.delayed(const Duration(microseconds: 100)).then((value) {
                  AlertNotification.error(
                      context, '${e.error.localizedMessage}');
                });
              }
            } else {
              Future.delayed(const Duration(microseconds: 100)).then((value) {
                AlertNotification.error(context, ERROR_MESSAGE);
              });
            }
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsFM.primaryLight99,
          appBar: AppBar(
              backgroundColor: ColorsFM.green40,
              title: Text(Languages.of(context).payConsult)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: mediumMargin),
                          Text(
                            Languages.of(context).cartSummary,
                            style: TypefaceStyles.poppinsSemiBold24Primary,
                          ),
                          const SizedBox(height: marginStandard),
                          if (state.item != nullItem)
                            CartItemWidget(
                              amount: state.item.amount,
                              quantity: state.item.quantity,
                            )
                        ]),
                  ),
                  ButtonText(
                    text: Languages.of(context).continueText,
                    onPressed: state.item == nullItem
                        ? null
                        : () {
                            context
                                .read<BookAppointmentPayBloc>()
                                .add(PayItem(params: timeBooked));
                          },
                  ),
                  const SizedBox(
                    height: marginStandard,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}
