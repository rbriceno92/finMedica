import 'package:app/core/di/modules.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_code_bloc.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_code_event.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_code_state.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpCodeParams {
  final String email;
  final String userId;
  final String name;

  const SignUpCodeParams(
      {required this.email, required this.userId, required this.name});
}

class SignUpCodeScreen extends StatelessWidget {
  const SignUpCodeScreen({Key? key, required this.params}) : super(key: key);

  final SignUpCodeParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCodeBloc>(),
      child: SignUpCodeView(
        params: params,
      ),
    );
  }
}

class SignUpCodeView extends StatelessWidget {
  final SignUpCodeParams params;
  const SignUpCodeView({Key? key, required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCodeBloc, SignUpCodeState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: SvgPicture.asset(
                finMedicaLogo,
                alignment: Alignment.center,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(marginStandard),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: extraLargeMargin,
                              ),
                              SvgPicture.asset(
                                validationImage,
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                height: mediumMargin,
                              ),
                              Text(
                                Languages.of(context).validationCode,
                                style: TypefaceStyles.titleLargePoppins,
                              ),
                              const SizedBox(
                                height: marginStandard,
                              ),
                              Text(
                                Languages.of(context).emailSendedWithName(
                                    params.email,
                                    params.name.capitalizeOnlyFirstWord()),
                                textAlign: TextAlign.center,
                                style: TypefaceStyles.bodyMediumMontserrat,
                              ),
                              const SizedBox(
                                height: marginStandard,
                              ),
                              PinCodeTextField(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                appContext: context,
                                length: 6,
                                enableActiveFill: true,
                                onChanged: (text) {
                                  context
                                      .read<SignUpCodeBloc>()
                                      .add(CodeChange(code: text));
                                },
                                textStyle: TypefaceStyles.bodyMediumMontserrat,
                                showCursor: false,
                                pinTheme: PinTheme(
                                    borderWidth: 1,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(8),
                                    fieldOuterPadding:
                                        const EdgeInsets.symmetric(
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
                              const SizedBox(
                                height: mediumMargin,
                              ),
                              InkWell(
                                  onTap: () {
                                    context.read<SignUpCodeBloc>().add(
                                        ResendCodeEvent(userId: params.userId));
                                  },
                                  child: Text(
                                    Languages.of(context).notEmailReceived,
                                    style: TypefaceStyles
                                        .bodyMediumMontserratGreen,
                                  )),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ButtonText(
                              text: Languages.of(context).signUpAction,
                              isLoading: state.loading,
                              onPressed: state.enableButton
                                  ? () {
                                      context
                                          .read<SignUpCodeBloc>()
                                          .add(SendData(
                                            data: params,
                                            next: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                successRoute,
                                                ModalRoute.withName(
                                                    welcomeRoute),
                                              );
                                            },
                                            error: () {
                                              AlertNotification.error(
                                                  context,
                                                  Languages.of(context)
                                                      .invalidCode);
                                            },
                                          ));
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ));
      },
      listener: (context, state) {
        if (state.message != '') {
          AlertNotification.success(
              context, Languages.of(context).codeForwardingMessage);
          context.read<SignUpCodeBloc>().add(CleanMessage());
        }
        if (state.messageError != '') {
          AlertNotification.error(context, state.messageError);
          context.read<SignUpCodeBloc>().add(CleanMessage());
        }
      },
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }
}
