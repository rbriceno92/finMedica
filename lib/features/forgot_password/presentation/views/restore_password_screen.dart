import 'package:app/core/di/modules.dart';
import 'package:app/features/forgot_password/presentation/bloc/restore_password_screen/restore_password_bloc.dart';
import 'package:app/features/forgot_password/presentation/bloc/restore_password_screen/restore_password_event.dart';
import 'package:app/features/forgot_password/presentation/bloc/restore_password_screen/restore_password_state.dart';
import 'package:app/features/login/data/models/sign_in_params.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/l10n.dart';
import '../../../../navigation/routes_names.dart';
import '../../../../util/assets_routes.dart';
import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/spinner_loading.dart';

class RestorePasswordScreen extends StatelessWidget {
  final String token;
  const RestorePasswordScreen({Key? key, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RestorePasswordBloc>(),
      child: RestorePasswordView(
        token: token,
      ),
    );
  }
}

class RestorePasswordView extends StatelessWidget {
  final String token;
  const RestorePasswordView({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestorePasswordBloc, RestorePasswordState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset(finMedicaLogo),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context).restorePassword,
                            style: TypefaceStyles.titleLargePoppins,
                          ),
                          const SizedBox(
                            height: marginStandard,
                          ),
                          Text(
                            Languages.of(context).establishNewPassword,
                            style: TypefaceStyles.bodyMediumMontserrat,
                          ),
                          const SizedBox(
                            height: mediumMargin,
                          ),
                          TextFormField(
                            style: TypefaceStyles.bodyMediumMontserrat,
                            onChanged: (password) {
                              context.read<RestorePasswordBloc>().add(
                                  OnChangeRestorePassword(password: password));
                            },
                            obscureText: !state.showPassword,
                            decoration: InputDecoratorLogin.getInputDecorator(
                                    Languages.of(context).newPassword,
                                    (state.messageError?.isNotEmpty ?? false)
                                        ? ColorsFM.errorColor
                                        : ColorsFM.neutralColor,
                                    ColorsFM.neutralColor,
                                    labelColor:
                                        (state.messageError?.isNotEmpty ??
                                                false)
                                            ? null
                                            : ColorsFM.neutralDark)
                                .copyWith(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          context
                                              .read<RestorePasswordBloc>()
                                              .add(ChangePasswordVisible());
                                        },
                                        icon: !state.showPassword
                                            ? SvgPicture.asset(
                                                eyeIconOpen,
                                                color: (state.messageError
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? ColorsFM.errorColor
                                                    : ColorsFM.neutralColor,
                                              )
                                            : SvgPicture.asset(
                                                eyeIconClosed,
                                                color: (state.messageError
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? ColorsFM.errorColor
                                                    : ColorsFM.neutralColor,
                                              ))),
                          ),
                          const SizedBox(
                            height: marginStandard,
                          ),
                          TextFormField(
                            style: TypefaceStyles.bodyMediumMontserrat,
                            onChanged: (password) {
                              context
                                  .read<RestorePasswordBloc>()
                                  .add(RestorePasswordsSubmitted(password));
                            },
                            obscureText: !state.showConfirmPassword,
                            decoration: InputDecoratorLogin.getInputDecorator(
                                    Languages.of(context).confirmPassword,
                                    (state.messageError?.isNotEmpty ?? false)
                                        ? ColorsFM.errorColor
                                        : ColorsFM.neutralColor,
                                    ColorsFM.neutralColor,
                                    labelColor:
                                        (state.messageError?.isNotEmpty ??
                                                false)
                                            ? null
                                            : ColorsFM.neutralDark)
                                .copyWith(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          context.read<RestorePasswordBloc>().add(
                                              ChangeConfirmPasswordVisible());
                                        },
                                        icon: !state.showConfirmPassword
                                            ? SvgPicture.asset(
                                                eyeIconOpen,
                                                color: (state.messageError
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? ColorsFM.errorColor
                                                    : ColorsFM.neutralColor,
                                              )
                                            : SvgPicture.asset(
                                                eyeIconClosed,
                                                color: (state.messageError
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? ColorsFM.errorColor
                                                    : ColorsFM.neutralColor,
                                              ))),
                          ),
                          const SizedBox(
                            height: mediumMargin,
                          ),
                          Text(
                            Languages.of(context).passwordShouldHave,
                            style: TypefaceStyles.poppinsRegular,
                          ),
                          ValidationPaswordWidget(
                            text: Languages.of(context).atLeastEightCharacters,
                            passed: state.minimumCharacters ?? false,
                          ),
                          ValidationPaswordWidget(
                            text: Languages.of(context).atLeastOneMayus,
                            passed: state.minimumCapitalLetterRequired ?? false,
                          ),
                          ValidationPaswordWidget(
                            text: Languages.of(context).atLeastOneMinus,
                            passed:
                                state.minimumLowerCaseLetterRequired ?? false,
                          ),
                          ValidationPaswordWidget(
                            text: Languages.of(context).atLeastOneNumber,
                            passed: state.minimumNumberRequired ?? false,
                          ),
                          ValidationPaswordWidget(
                            text: Languages.of(context).atLeastOneSpecialChar,
                            passed: state.minimumEspecialCharRequired ?? false,
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: marginStandard),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ((state.validFormats ?? false) &&
                                              state.passwordsEquals)
                                          ? ColorsFM.green40
                                          : ColorsFM.neutral99,
                                  minimumSize: const Size(
                                      double.infinity, buttonHeightStandard),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              radiusRoundedButton))),
                                  disabledBackgroundColor: ColorsFM.neutral99),
                              onPressed: ((state.validFormats ?? false) &&
                                      state.passwordsEquals)
                                  ? () {
                                      context.read<RestorePasswordBloc>().add(
                                          UpdatePassword(
                                              token: token,
                                              password: state.newPassword!));
                                    }
                                  : null,
                              child: Text(Languages.of(context).continueText)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
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
        if (state.changePassword ?? false) {
          Navigator.pushNamedAndRemoveUntil(context, signInRoute,
              (route) => route.settings.name == welcomeRoute,
              arguments: SignInParams(
                changePassword: true,
              ));
        }
        if (state.messageError?.isNotEmpty ?? false) {
          AlertNotification.error(context, state.messageError ?? '');
        }
      },
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }
}

class ValidationPaswordWidget extends StatelessWidget {
  final String text;
  final bool passed;
  const ValidationPaswordWidget(
      {Key? key, required this.text, required this.passed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
      builder: (context, state) {
        return Row(
          children: [
            !passed
                ? SvgPicture.asset(iconCancel)
                : SvgPicture.asset(checkValidation),
            const SizedBox(
              width: marginStandard,
            ),
            Text(
              text,
              style: TypefaceStyles.poppinsRegular,
            )
          ],
        );
      },
    );
  }
}
