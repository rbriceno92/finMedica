import 'dart:math';

import 'package:app/core/di/modules.dart';
import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_event.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_form_bloc.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_form_state.dart';
import 'package:app/features/signup/presentation/widgets/curp_field_fm.dart';
import 'package:app/features/signup/presentation/widgets/curp_info.dart';
import 'package:app/features/signup/presentation/widgets/date_field_fm.dart';
import 'package:app/features/signup/presentation/widgets/email_field_fm.dart';
import 'package:app/features/signup/presentation/widgets/gender_field_fm.dart';
import 'package:app/features/signup/presentation/widgets/phone_field_fm.dart';
import 'package:app/features/signup/presentation/widgets/required_text.dart';
import 'package:app/features/signup/presentation/widgets/text_field_fm.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpFormBloc>(),
      child: SignUpScreenView(),
    );
  }
}

class SignUpScreenView extends StatelessWidget {
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerSecondName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerMothersLastName =
      TextEditingController();
  SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: SvgPicture.asset(
            finMedicaLogo,
            alignment: Alignment.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom > 0
                  ? MediaQuery.of(context).padding.bottom - 9
                  : 0),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: marginStandard,
                right: marginStandard,
                top: mediumMargin,
              ),
              child: Column(children: [
                Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(Languages.of(context).signUp,
                            style: TypefaceStyles.poppinsSemiBold22
                                .copyWith(color: ColorsFM.primary)),
                      ),
                      const RequiredText(true),
                      TextFieldFM(
                        controllerText: controllerFirstName,
                        label: Languages.of(context).name,
                        error: state.nameHasErrors,
                        textCapitalization: TextCapitalization.words,
                        onChange: (value) {
                          context
                              .read<SignUpFormBloc>()
                              .add(FirstNameChange(firstName: value ?? ''));
                        },
                      ),
                      const RequiredText(false),
                      TextFieldFM(
                        controllerText: controllerSecondName,
                        label: Languages.of(context).secondName,
                        error: state.secondNameHasErrors,
                        textCapitalization: TextCapitalization.words,
                        onChange: (value) {
                          context
                              .read<SignUpFormBloc>()
                              .add(SecondNameChange(secondName: value ?? ''));
                        },
                      ),
                      const RequiredText(true),
                      TextFieldFM(
                        controllerText: controllerLastName,
                        label: Languages.of(context).lastName,
                        error: state.lastNameHasErrors,
                        textCapitalization: TextCapitalization.words,
                        onChange: (value) {
                          context
                              .read<SignUpFormBloc>()
                              .add(LastNameChange(lastName: value ?? ''));
                        },
                      ),
                      const RequiredText(true),
                      TextFieldFM(
                        controllerText: controllerMothersLastName,
                        label: Languages.of(context).mothersLastName,
                        error: state.mothersLasnameHasErrors,
                        textCapitalization: TextCapitalization.words,
                        onChange: (value) {
                          context.read<SignUpFormBloc>().add(
                              MothersLastNameChange(
                                  mothersLastName: value ?? ''));
                        },
                      ),
                      const RequiredText(true),
                      GenderFieldFM(
                        label: Languages.of(context).genderBirth,
                        onChange: (gender) {
                          context
                              .read<SignUpFormBloc>()
                              .add(GenderChange(gender: gender));
                        },
                      ),
                      const RequiredText(true),
                      CURPFieldFM(
                        label: Languages.of(context).curp,
                        onChange: (value) {
                          context
                              .read<SignUpFormBloc>()
                              .add(CURPChange(curp: value ?? ''));
                        },
                        onPressInfo: () {
                          context
                              .read<SignUpFormBloc>()
                              .add(ChangeCURPInfoVisible());
                        },
                        error: state.curpHasError || state.errorCURPDuplicate,
                        errorDuplicate: state.errorCURPDuplicate,
                      ),
                      const RequiredText(true),
                      DateFieldFM(
                        label: Languages.of(context).dateBirth,
                        error: state.birthdayHasErrors,
                        onChange: (date) {
                          context
                              .read<SignUpFormBloc>()
                              .add(BirthdayChange(birthday: date));
                        },
                      ),
                      const RequiredText(false),
                      PhoneFieldFM(
                        label: Languages.of(context).phone,
                        error: state.phoneHasErrors,
                        text: state.phone,
                        onChange: (value) {
                          context
                              .read<SignUpFormBloc>()
                              .add(PhoneChange(phone: value ?? ''));
                        },
                      ),
                      const RequiredText(true),
                      EmailFieldFM(
                          label: Languages.of(context).emailText,
                          error:
                              state.emailHasErrors || state.errorEmailDuplicate,
                          errorDuplicate: state.errorEmailDuplicate,
                          onChange: (value) {
                            context
                                .read<SignUpFormBloc>()
                                .add(EmailChange(email: value ?? ''));
                          },
                          lastItem: true),
                    ],
                  ),
                  if (state.showCURPInfo)
                    GestureDetector(
                        onTap: () => context
                            .read<SignUpFormBloc>()
                            .add(ChangeCURPInfoVisible()),
                        child: Container(
                            color: Colors.transparent,
                            height: 721,
                            padding: const EdgeInsets.only(
                                top: 488, bottom: 641 - 410 - 56),
                            child: const CURPInfo()))
                ]),
                if (!state.errorEmailDuplicate && !state.errorCURPDuplicate)
                  SizedBox(
                    height: max(constraints.maxHeight - 704 - mediumMargin,
                        extraLargeMargin),
                  ),
                if (state.errorEmailDuplicate || state.errorCURPDuplicate)
                  SizedBox(
                    height: max(constraints.maxHeight - 721 - mediumMargin,
                        extraLargeMargin),
                  ),
                Container(
                  margin: const EdgeInsets.only(bottom: smallMargin),
                  child: ButtonText(
                    text: Languages.of(context).continueText,
                    onPressed: state.enableContinue &&
                            state.loading != LoadingState.show
                        ? () {
                            var data = SignUpData(
                                firstName: state.firstName.trim(),
                                secondName: state.secondName.trim(),
                                lastName: state.lastName.trim(),
                                mothersLastName: state.mothersLastName.trim(),
                                gender: state.gender ?? Genders.f,
                                phone: state.phone,
                                email: state.email.trim(),
                                birthday: state.birthday.trim(),
                                curp: state.curp.trim(),
                                password: '');

                            context.read<SignUpFormBloc>().add(SendSignUpData(
                                data: data,
                                next: () {
                                  Future.delayed(
                                          const Duration(milliseconds: 100))
                                      .then((value) => Navigator.pushNamed(
                                            context,
                                            signUpPasswordRoute,
                                            arguments: data,
                                          ));
                                }));
                          }
                        : null,
                  ),
                )
              ]),
            );
          }),
        ),
      ),
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.popUntil(
              context, (route) => route.settings.name == signUproute);
          context.read<SignUpFormBloc>().add(DisposeLoading());
        }
        if (state.errorMessage.isNotEmpty) {
          AlertNotification.error(context, state.errorMessage);
        }
      },
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }
}
