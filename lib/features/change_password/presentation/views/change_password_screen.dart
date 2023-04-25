import 'package:app/core/di/modules.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_bloc.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_event.dart';
import 'package:app/features/change_password/presentation/bloc/change_password_state.dart';
import 'package:app/features/signup/presentation/widgets/password_checks.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/password_field.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordBloc>(),
      child: const ChangePasswordScreenView(),
    );
  }
}

class ChangePasswordScreenView extends StatelessWidget {
  const ChangePasswordScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: SvgPicture.asset(
            finMedicaLogo,
            alignment: Alignment.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: marginStandard,
            right: marginStandard,
          ),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: mediumMargin,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context).changePassword,
                              style: TypefaceStyles.poppinsSemiBold22
                                  .copyWith(color: ColorsFM.primary),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: marginStandard),
                              child: Text(Languages.of(context).currentPassword,
                                  style: TypefaceStyles.bodyMediumMontserrat),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: marginStandard),
                              child: PasswordField(
                                text: state.password,
                                label: Languages.of(context).passwordText,
                                onChange: (value) {
                                  context.read<ChangePasswordBloc>().add(
                                      PasswordChange(password: value ?? ''));
                                },
                                onPressed: () {
                                  context
                                      .read<ChangePasswordBloc>()
                                      .add(ChangePasswordVisible());
                                },
                                showPassword: state.showPassword,
                                error: state.passwordHasErrors ||
                                    state.samePasswordError,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: marginStandard),
                              child: Text(
                                  Languages.of(context).establishNewPassword,
                                  style: TypefaceStyles.bodyMediumMontserrat),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: marginStandard),
                              child: PasswordField(
                                text: state.newPassword,
                                label: Languages.of(context).newPassword,
                                onChange: (value) {
                                  context.read<ChangePasswordBloc>().add(
                                      NewPasswordChange(password: value ?? ''));
                                },
                                onPressed: () {
                                  context
                                      .read<ChangePasswordBloc>()
                                      .add(ChangeNewPasswordVisible());
                                },
                                showPassword: state.showNewPassword,
                                error: state.newPasswordHasErrors ||
                                    state.samePasswordError,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: marginStandard,
                              ),
                              child: PasswordField(
                                text: state.confirmePassword,
                                label: Languages.of(context).confirmPassword,
                                lastItem: true,
                                onChange: (value) {
                                  context.read<ChangePasswordBloc>().add(
                                      ConfirmePasswordChange(
                                          password: value ?? ''));
                                },
                                onPressed: () {
                                  context
                                      .read<ChangePasswordBloc>()
                                      .add(ChangeConfirmPasswordVisible());
                                },
                                showPassword: state.showConfirmePassword,
                                error: state.confirmePasswordHasErrors,
                              ),
                            ),
                            PasswordChecks(password: state.newPassword),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom +
                                marginStandard),
                        child: ButtonText(
                          text: Languages.of(context).continueText,
                          onPressed: state.enableContinue
                              ? () {
                                  context
                                      .read<ChangePasswordBloc>()
                                      .add(SendRequest(
                                        onSuccess: () {
                                          AlertNotification.success(
                                              context,
                                              Languages.of(context)
                                                  .changePasswordSuccess);
                                        },
                                        onError: (message) => message ==
                                                'ERROR_SAME_PASSWORD'
                                            ? AlertNotification.error(
                                                context,
                                                Languages.of(context)
                                                    .errorCurrentAndNewPasswordSame)
                                            : AlertNotification.error(
                                                context, message),
                                      ));
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      listener: (context, state) {},
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }
}
