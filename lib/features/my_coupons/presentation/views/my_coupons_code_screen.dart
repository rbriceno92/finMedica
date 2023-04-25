import 'package:app/core/di/modules.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_code_bloc.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_code_events.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_code_state.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../navigation/routes_names.dart';
import '../../../../util/enums.dart';
import '../../../../util/widgets/spinner_loading.dart';

class MyCouponsCodeScreen extends StatelessWidget {
  const MyCouponsCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyCouponsCodeBloc>(),
      child: const MyCouponsCodeView(),
    );
  }
}

class MyCouponsCodeView extends StatefulWidget {
  const MyCouponsCodeView({super.key});

  @override
  State<MyCouponsCodeView> createState() => _MyCouponsCodeViewState();
}

class _MyCouponsCodeViewState extends State<MyCouponsCodeView> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCouponsCodeBloc, MyCouponsCodeState>(
        listener: (context, state) {
      if (state.loading == LoadingState.show) {
        SpinnerLoading.showDialogLoading(context);
      }
      if (state.code.isEmpty) {
        textEditingController.clear();
      }
      if (state.loading == LoadingState.close) {
        Navigator.pop(context);
        if (state.messageError != '') {
          context.read<MyCouponsCodeBloc>().add(DisposeLoading());
          AlertNotification.error(context, state.messageError);
        }
        if (state.messageSuccess != '') {
          AlertNotification.success(context, state.messageSuccess);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, myCouponsRoute,
                  (route) {
                return route.settings.name == dashboardRoute;
              });
            },
          ),
          title: SvgPicture.asset(
            finMedicaLogo,
            alignment: Alignment.center,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(marginStandard),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: (constraints.maxHeight - 320) / 2,
                            ),
                            SvgPicture.asset(
                              iconCuponAdd,
                              alignment: Alignment.center,
                              height: 68,
                              color: ColorsFM.green40,
                            ),
                            const SizedBox(
                              height: mediumMargin,
                            ),
                            Text(
                              Languages.of(context).couponCode,
                              style: TypefaceStyles.poppinsSemiBold22
                                  .copyWith(color: ColorsFM.primary),
                            ),
                            const SizedBox(
                              height: marginStandard,
                            ),
                            Text(
                              Languages.of(context).insertCouponCode,
                              textAlign: TextAlign.center,
                              style: TypefaceStyles.bodyMediumMontserrat,
                            ),
                            const SizedBox(
                              height: marginStandard,
                            ),
                            PinCodeTextField(
                              controller: textEditingController,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9A-Z]'))
                              ],
                              textCapitalization: TextCapitalization.characters,
                              appContext: context,
                              length: 6,
                              enableActiveFill: true,
                              onChanged: (text) {
                                context
                                    .read<MyCouponsCodeBloc>()
                                    .add(CodeChange(code: text));
                              },
                              textStyle: TypefaceStyles.bodyMediumMontserrat,
                              showCursor: false,
                              pinTheme: PinTheme(
                                  borderWidth: 1,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldOuterPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  selectedColor: ColorsFM.primary99,
                                  activeFillColor: state.codeError
                                      ? ColorsFM.red99
                                      : ColorsFM.primary99,
                                  selectedFillColor: state.codeError
                                      ? ColorsFM.red99
                                      : ColorsFM.primary99,
                                  activeColor: state.codeError
                                      ? ColorsFM.errorColor
                                      : ColorsFM.primary99,
                                  inactiveColor: ColorsFM.primary99,
                                  inactiveFillColor: ColorsFM.primary99,
                                  fieldHeight: 48,
                                  fieldWidth: 48),
                            ),
                          ]),
                      if (state.enableButtom)
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).padding.bottom),
                              child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<MyCouponsCodeBloc>()
                                        .add(const SendCode());
                                  },
                                  child:
                                      Text(Languages.of(context).redeemCoupon)),
                            )),
                    ]),
              ),
            );
          }),
        ),
      );
    });
  }
}
