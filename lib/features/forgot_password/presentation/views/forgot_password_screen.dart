import 'package:app/core/di/modules.dart';
import 'package:app/features/forgot_password/data/models/validation_screen_params.dart';
import 'package:app/features/forgot_password/presentation/bloc/forgot_password_screen/forgot_password_event.dart';
import 'package:app/features/forgot_password/presentation/bloc/forgot_password_screen/forgot_password_state.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/l10n.dart';
import '../../../../navigation/routes_names.dart';
import '../bloc/forgot_password_screen/forgot_password_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordBloc>(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  static const String emailRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset(
              finMedicaLogo,
              alignment: Alignment.center,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(marginStandard),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context).forgotPassword,
                      style: TypefaceStyles.titleLargePoppins,
                    ),
                    const SizedBox(
                      height: mediumMargin,
                    ),
                    Text(Languages.of(context).typeEmailText,
                        style: TypefaceStyles.bodyMediumMontserrat),
                    const SizedBox(
                      height: mediumMargin,
                    ),
                    TextFormField(
                        style: TypefaceStyles.bodyMediumMontserrat,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            emailValidator(email?.trim() ?? '', context),
                        decoration: InputDecoratorLogin.getInputDecorator(
                            Languages.of(context).emailText,
                            ColorsFM.neutralColor,
                            ColorsFM.neutralColor,
                            labelColor: ColorsFM.neutralDark))
                  ],
                )),
                ElevatedButton(
                    onPressed: state.formatEmailInvalid
                        ? () {
                            context
                                .read<ForgotPasswordBloc>()
                                .add(SendingEmail(email: state.email!));
                          }
                        : null,
                    child: Text(Languages.of(context).continueText)),
                const SizedBox(
                  height: marginStandard,
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.loading != null) {
          if (state.loading!) {
            SpinnerLoading.showDialogLoading(context);
          } else {
            Navigator.popUntil(
                context, (route) => route.settings.name == forgotPasswordRoute);
          }
        }
        if (state.emailAlreadySended) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          Navigator.pushNamed(context, validationRoute,
              arguments: ValidationScreenParams(
                  email: state.email ?? '', name: state.name ?? ''));
        } else if (state.emailInvalid) {
          AlertNotification.error(context, state.messageError ?? '');
        }
      },
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }

  emailValidator(String email, BuildContext context) {
    context.read<ForgotPasswordBloc>().add(EmailChange(email: email));
    if (email.isEmpty) {
      return '';
    } else if (!RegExp(emailRegExp).hasMatch(email)) {
      return '';
    } else {
      return null;
    }
  }
}
