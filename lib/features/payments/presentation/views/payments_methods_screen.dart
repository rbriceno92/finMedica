import 'package:app/core/di/modules.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_bloc.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_events.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_state.dart';
import 'package:app/features/payments/presentation/widgets/payment_method_item.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PaymentMethodsBloc>()
        ..add(LoadUser())
        ..add(FetchData()),
      child: const PaymentMethodsView(),
    );
  }
}

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentMethodsBloc, PaymentMethodsState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.pop(context);
          if (state.errorMessage.isNotEmpty) {
            AlertNotification.error(context, state.errorMessage);
          }
          if (state.successMessage.isNotEmpty) {
            AlertNotification.success(context, state.successMessage);
          }
          context.read<PaymentMethodsBloc>().add(DisposeLoading());
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).configuration),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: marginStandard, vertical: mediumMargin),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              Languages.of(context).myMethodsToPay,
              style: TypefaceStyles.poppinsSemiBold22
                  .copyWith(color: ColorsFM.primary),
            ),
            const SizedBox(height: largeDivision),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: ColorsFM.primaryLight80, width: 1),
                            color: Colors.white),
                        child: Column(children: [
                          SizedBox(
                            height: 54,
                            child: Center(
                                child: SvgPicture.asset(
                              logoStripe,
                              height: 43,
                            )),
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: ColorsFM.neutral99,
                          ),
                          if (state.paymentMethods.isEmpty)
                            SizedBox(
                              height: 54,
                              child: Center(
                                  child: Text(
                                Languages.of(context).emptyPaymentMethod,
                                style: TypefaceStyles.bodySmallMontserrat12,
                              )),
                            ),
                          if (state.paymentMethods.isNotEmpty)
                            ListView.separated(
                              itemCount: state.paymentMethods.length,
                              itemBuilder: (context, index) {
                                return PaymentMethodItem(
                                    data: state.paymentMethods[index]);
                              },
                              separatorBuilder: (context, index) => Container(
                                width: double.infinity,
                                height: 1,
                                color: ColorsFM.neutral99,
                              ),
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: ColorsFM.neutral99,
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(
                                      context, addPaymentMethodRoute)
                                  .then((result) {
                                if (result != null) {
                                  AlertNotification.success(
                                      context, result as String);
                                  context
                                      .read<PaymentMethodsBloc>()
                                      .add(FetchData());
                                }
                              });
                            },
                            child: SizedBox(
                              height: 54,
                              child: Center(
                                  child: SvgPicture.asset(
                                iconPlus,
                                height: 24,
                                color: ColorsFM.blueDark90,
                              )),
                            ),
                          )
                        ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, paymentsHistoryRoute);
                        },
                        child: Text(
                          Languages.of(context).seePaymentHistory,
                          style: TypefaceStyles.montserrat10
                              .copyWith(color: ColorsFM.green40),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: marginStandard,
                    ),
                  ]),
            ))
          ]),
        ),
      ),
    );
  }
}
