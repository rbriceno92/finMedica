import 'package:app/core/di/modules.dart';
import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_event.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_password_bloc.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_password_state.dart';
import 'package:app/features/signup/presentation/widgets/password_checks.dart';
import 'package:app/features/terms_conditions/presentation/view/terms_conditions_screen.dart';
import 'package:app/util/widgets/password_field.dart';
import 'package:app/features/signup/presentation/widgets/required_text.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPasswordScreen extends StatelessWidget {
  final SignUpData form;

  const SignUpPasswordScreen({Key? key, required this.form}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpPasswordBloc>(),
      child: SignUpScreenView(form: form),
    );
  }
}

class SignUpScreenView extends StatelessWidget {
  final SignUpData form;
  const SignUpScreenView({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpPasswordBloc, SignUpPasswordState>(
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
          padding: EdgeInsets.only(
              left: marginStandard,
              right: marginStandard,
              bottom: MediaQuery.of(context).padding.bottom + smallMargin,
              top: mediumMargin),
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
                        Text(Languages.of(context).setPassword,
                            style: TypefaceStyles.poppinsSemiBold22
                                .copyWith(color: ColorsFM.primary)),
                        const RequiredText(true),
                        PasswordField(
                          text: state.password,
                          label: Languages.of(context).passwordText,
                          onChange: (value) {
                            context
                                .read<SignUpPasswordBloc>()
                                .add(PasswordChange(password: value ?? ''));
                          },
                          onPressed: () {
                            context
                                .read<SignUpPasswordBloc>()
                                .add(ChangePasswordVisible());
                          },
                          showPassword: state.showPassword,
                          error: state.passwordHasErrors,
                        ),
                        const RequiredText(true),
                        PasswordField(
                            text: state.confirmPassword,
                            label: Languages.of(context).confirmPassword,
                            lastItem: true,
                            onChange: ((value) {
                              context.read<SignUpPasswordBloc>().add(
                                  ConfirmPasswordChange(password: value ?? ''));
                            }),
                            onPressed: () {
                              context
                                  .read<SignUpPasswordBloc>()
                                  .add(ChangeConfirmPasswordVisible());
                            },
                            showPassword: state.showConfirmPassword,
                            error: state.confirmPasswordHasErrors),
                        PasswordChecks(password: state.password),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonText(
                        text: Languages.of(context).continueText,
                        onPressed: state.enableContinue
                            ? () {
                                Navigator.pushNamed(
                                    context, termsConditionsRoote,
                                    arguments: TCScreenArgs(
                                        from: TCScreenFrom.signUp,
                                        signUpData: form.copyWith(
                                            password: state.password),
                                        name: form.firstName));
                              }
                            : null,
                      ),
                    )
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
