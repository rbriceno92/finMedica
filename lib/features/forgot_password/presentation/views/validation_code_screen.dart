import 'package:app/features/forgot_password/presentation/bloc/validation_code_screen/validation_code_bloc.dart';
import 'package:app/features/forgot_password/presentation/bloc/validation_code_screen/validation_code_event.dart';
import 'package:app/features/forgot_password/presentation/bloc/validation_code_screen/validation_code_state.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/string_extensions.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/di/modules.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/widgets/spinner_loading.dart';
import '../bloc/forgot_password_screen/forgot_password_bloc.dart';
import '../bloc/forgot_password_screen/forgot_password_event.dart';

class ValidationCodeScreen extends StatelessWidget {
  const ValidationCodeScreen(
      {Key? key, required this.email, required this.name})
      : super(key: key);

  final String email;
  final String name;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ValidationCodeBloc>(
          create: (context) => getIt<ValidationCodeBloc>(),
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => getIt<ForgotPasswordBloc>(),
        )
      ],
      child: ValidationCodeView(
        email: email,
        name: name,
      ),
    );
  }
}

class ValidationCodeView extends StatelessWidget {
  final String email;
  final String name;

  const ValidationCodeView({Key? key, required this.email, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValidationCodeBloc, ValidationCodeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
                                  email, name.capitalizeOnlyFirstWord()),
                              textAlign: TextAlign.center,
                              style: TypefaceStyles.bodyMediumMontserrat,
                            ),
                            const SizedBox(
                              height: marginStandard,
                            ),
                            PinCodeTextField(
                              validator: (code) {
                                return pinCodeValidator(state);
                              },
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              appContext: context,
                              length: 6,
                              enableActiveFill: true,
                              onChanged: (text) {
                                context.read<ValidationCodeBloc>().add(
                                    CodeSubmitted(email: email, code: text));
                              },
                              textStyle: TypefaceStyles.bodyMediumMontserrat,
                              showCursor: false,
                              pinTheme: PinTheme(
                                  borderWidth: 1,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldOuterPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  errorBorderColor: ColorsFM.errorColor,
                                  selectedColor: ColorsFM.primary99,
                                  activeFillColor:
                                      state.messageError?.isNotEmpty ?? false
                                          ? ColorsFM.red99
                                          : ColorsFM.primary99,
                                  selectedFillColor: ColorsFM.primary99,
                                  activeColor:
                                      state.messageError?.isNotEmpty ?? false
                                          ? ColorsFM.errorColor
                                          : ColorsFM.primary99,
                                  inactiveColor: ColorsFM.primary99,
                                  disabledColor: ColorsFM.primary99,
                                  inactiveFillColor: ColorsFM.primary99,
                                  fieldHeight: 48,
                                  fieldWidth: 48),
                            ),
                            const SizedBox(
                              height: mediumMargin,
                            ),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<ForgotPasswordBloc>(context)
                                    .add(SendingEmail(email: email));
                                AlertNotification.success(
                                    context,
                                    Languages.of(context)
                                        .codeForwardingMessage);
                              },
                              child: Text(
                                Languages.of(context).notEmailReceived,
                                style: TypefaceStyles.bodyMediumMontserratGreen,
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: marginStandard),
                              child: ElevatedButton(
                                  onPressed: ((state.code?.length == 6) &&
                                          (state.messageError?.isEmpty ?? true))
                                      ? () {
                                          context
                                              .read<ValidationCodeBloc>()
                                              .add(SendingCode(email: email));
                                        }
                                      : null,
                                  child: Text(
                                      Languages.of(context).restorePassword)),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.loading != null) {
          if (state.loading!) {
            SpinnerLoading.showDialogLoading(context);
          } else {
            Navigator.pop(context);
          }
        }
        if (state.codeAccepted ?? false) {
          Navigator.pushReplacementNamed(context, restorePasswordRoute,
              arguments: state.token);
        } else if (!(state.codeAccepted ?? true)) {
          AlertNotification.error(context, Languages.of(context).invalidCode);
        } else if (state.messageError?.isNotEmpty ?? false) {
          AlertNotification.error(context, state.messageError ?? '');
        }
      },
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }

  String? pinCodeValidator(ValidationCodeState state) {
    if (state.messageError?.isNotEmpty ?? false) {
      return '';
    } else {
      return null;
    }
  }
}
