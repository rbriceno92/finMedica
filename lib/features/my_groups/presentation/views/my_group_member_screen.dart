import 'package:app/core/di/modules.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_info.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';

import 'package:app/features/my_groups/presentation/bloc/my_groups_new_member_event.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_new_member_state.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_new_member_bloc.dart';
import 'package:app/features/my_groups/presentation/widgets/curp_info.dart';
import 'package:app/features/my_groups/presentation/widgets/form_curp_field.dart';
import 'package:app/features/my_groups/presentation/widgets/form_date_field.dart';
import 'package:app/features/my_groups/presentation/widgets/form_email_field.dart';
import 'package:app/features/my_groups/presentation/widgets/form_gender_field.dart';
import 'package:app/features/my_groups/presentation/widgets/form_phone_field.dart';
import 'package:app/features/my_groups/presentation/widgets/form_text_field.dart';

import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/spinner_loading.dart';

class MyGroupsMemberScreenArgs {
  final MyGroupsInfo info;
  final MyGroupsMember? member;

  MyGroupsMemberScreenArgs(this.info, this.member);
}

class MyGroupsMemberScreen extends StatelessWidget {
  final MyGroupsMember? member;
  final MyGroupsInfo info;
  const MyGroupsMemberScreen({Key? key, this.member, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return getIt<MyGroupsNewMemberBloc>()..add(SetGroupInfo(info: info));
      },
      child: SignUpScreenView(member: member),
    );
  }
}

class SignUpScreenView extends StatelessWidget {
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerSecondName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerMothersLastName =
      TextEditingController();
  final TextEditingController controllerCurp = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();

  final MyGroupsMember? member;
  SignUpScreenView({super.key, this.member});

  @override
  Widget build(BuildContext context) {
    if (member != null) {
      controllerFirstName.text = member?.firstName ?? '';
      controllerSecondName.text = member?.secondName ?? '';
      controllerLastName.text = member?.lastName ?? '';
      controllerMothersLastName.text = member?.mothersLastName ?? '';
      controllerCurp.text = member?.documentId ?? '';
      controllerDate.text = member?.birthday ?? '';
      controllerPhone.text = member?.phoneNumber ?? '';
      controllerEmail.text = member?.email ?? '';
    }
    return BlocConsumer<MyGroupsNewMemberBloc, MyGroupsNewMemberState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.pop(context);
          if (state.errorMessage != '') {
            AlertNotification.error(context, state.errorMessage);
            context.read<MyGroupsNewMemberBloc>().add(DisposeLoading());
          }
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(member == null
              ? Languages.of(context).newMember
              : Languages.of(context).memberProfile),
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
                      Text(
                          member == null
                              ? Languages.of(context).newUser
                              : Languages.of(context).memberProfile,
                          style: TypefaceStyles.poppinsSemiBold22
                              .copyWith(color: ColorsFM.primary)),
                      FormTextField(
                        isRequired: true,
                        controllerText: controllerFirstName,
                        label: Languages.of(context).name,
                        error: state.nameHasErrors,
                        onChange: (value) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(FirstNameChange(firstName: value ?? ''));
                        },
                        enabled: member == null,
                      ),
                      FormTextField(
                        controllerText: controllerSecondName,
                        label: Languages.of(context).secondName,
                        error: state.secondNameHasErrors,
                        onChange: (value) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(SecondNameChange(secondName: value ?? ''));
                        },
                        enabled: member == null,
                      ),
                      FormTextField(
                        isRequired: true,
                        controllerText: controllerLastName,
                        label: Languages.of(context).lastName,
                        error: state.lastNameHasErrors,
                        onChange: (value) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(LastNameChange(lastName: value ?? ''));
                        },
                        enabled: member == null,
                      ),
                      FormTextField(
                        isRequired: true,
                        controllerText: controllerMothersLastName,
                        label: Languages.of(context).mothersLastName,
                        error: state.mothersLasnameHasErrors,
                        onChange: (value) {
                          context.read<MyGroupsNewMemberBloc>().add(
                              MothersLastNameChange(
                                  mothersLastName: value ?? ''));
                        },
                        enabled: member == null,
                      ),
                      FormGenderField(
                        value: member == null ? state.gender : member!.gender,
                        isRequired: true,
                        label: Languages.of(context).genderBirth,
                        onChange: (gender) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(GenderChange(gender: gender));
                        },
                        enabled: member == null,
                      ),
                      FormCURPField(
                        controllerText: controllerCurp,
                        isRequired: false,
                        label: Languages.of(context).curp,
                        onChange: (value) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(CURPChange(curp: value ?? ''));
                        },
                        onPressInfo: () {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(ChangeCURPInfoVisible());
                        },
                        error: state.curpHasError || state.errorCURPDuplicate,
                        errorDuplicate: state.errorCURPDuplicate,
                        enabled: member == null,
                      ),
                      FormDateField(
                        controllerText: controllerDate,
                        isRequired: true,
                        label: Languages.of(context).dateBirth,
                        error: state.birthdayHasErrors,
                        onChange: (date) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(BirthdayChange(birthday: date));
                        },
                        enabled: member == null,
                      ),
                      FormPhoneField(
                        controller: controllerPhone,
                        label: Languages.of(context).phone,
                        error: state.phoneHasErrors,
                        onChange: (value) {
                          context
                              .read<MyGroupsNewMemberBloc>()
                              .add(PhoneChange(phone: value ?? ''));
                        },
                        enabled: member == null,
                      ),
                      FormEmailField(
                          isRequired: false,
                          controller: controllerEmail,
                          label: Languages.of(context).emailText,
                          error:
                              state.emailHasErrors || state.errorEmailDuplicate,
                          errorDuplicate: state.errorEmailDuplicate,
                          onChange: (value) {
                            context
                                .read<MyGroupsNewMemberBloc>()
                                .add(EmailChange(email: value ?? ''));
                          },
                          enabled: member == null),
                    ],
                  ),
                  if (state.showCURPInfo)
                    GestureDetector(
                        onTap: () => context
                            .read<MyGroupsNewMemberBloc>()
                            .add(ChangeCURPInfoVisible()),
                        child: Container(
                            color: Colors.transparent,
                            height: 802,
                            padding:
                                const EdgeInsets.only(top: 488, bottom: 258),
                            child: const CURPInfo()))
                ]),
                if (member == null)
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: smallMargin, top: marginStandard),
                    child: ButtonText(
                      text: Languages.of(context).addNewMemberToGroup,
                      onPressed: state.enableContinue
                          ? () {
                              context.read<MyGroupsNewMemberBloc>().add(
                                  SendSignUpData(next: (MyGroupsMember member) {
                                Future.delayed(
                                        const Duration(milliseconds: 100))
                                    .then((value) =>
                                        Navigator.pop(context, member));
                              }));
                            }
                          : null,
                    ),
                  )
                else
                  const SizedBox(
                    height: marginStandard,
                  )
              ]),
            );
          }),
        ),
      ),
    );
  }
}
