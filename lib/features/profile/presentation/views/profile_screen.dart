import 'package:app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/features/profile/presentation/bloc/profile_event.dart';
import 'package:app/features/signup/presentation/widgets/curp_info.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/bottom_sheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/di/modules.dart';
import '../../../../navigation/routes_names.dart';
import '../../../../util/widgets/alert_notification.dart';
import '../bloc/profile_state.dart';
import 'package:app/util/format_date.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(OnGetUserInfo()),
      child: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsFM.primaryLight99,
      appBar: AppBar(
        title: Text(Languages.of(context).myProfileScreen),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
            vertical: marginStandard, horizontal: marginStandard),
        child: ContentProfileScreen(),
      ),
    );
  }
}

class ContentProfileScreen extends StatelessWidget {
  const ContentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (prevState, state) {
        return true;
      },
      listener: (context, state) {
        if (state.messageSuccess != '') {
          AlertNotification.success(
              context, Languages.of(context).updatePhoneNumberMessage);
          context.read<ProfileBloc>().add(CleanMessage());
        }
        if (state.messageError != '') {
          AlertNotification.error(context, state.messageError);
          context.read<ProfileBloc>().add(CleanMessage());
        }
      },
      builder: (context, state) {
        return Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Languages.of(context).myProfileScreen,
                      style: TypefaceStyles.poppinsSemiBold24Primary,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, myGroupMemberCodeScreem,
                              arguments: state.modelUser);
                        },
                        child: SvgPicture.asset(
                          iconCodeBarGroup,
                          color: ColorsFM.green40,
                          width: 24,
                          height: 24,
                        ))
                  ],
                ),
                FieldProfile(
                  fieldName: Languages.of(context).name,
                  typeFieldProfile: TypeFieldProfile.name,
                  value: state.modelUser?.fullName() ?? '--',
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorsFM.neutral99,
                ),
                FieldProfile(
                    fieldName: Languages.of(context).genderBirth,
                    typeFieldProfile: TypeFieldProfile.gender,
                    value: state.modelUser?.gender == Genders.m
                        ? Languages.of(context).male
                        : Languages.of(context).female),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorsFM.neutral99,
                ),
                FieldProfile(
                    fieldName: Languages.of(context).curp,
                    typeFieldProfile: TypeFieldProfile.curp,
                    value: state.modelUser?.documentId ?? '--'),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorsFM.neutral99,
                ),
                FieldProfile(
                    fieldName: Languages.of(context).dateBirth,
                    typeFieldProfile: TypeFieldProfile.birthday,
                    value: state.modelUser?.birthday?.dateBirthdayFormat() ??
                        '--'),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorsFM.neutral99,
                ),
                FieldProfile(
                    fieldName: Languages.of(context).phone,
                    typeFieldProfile: TypeFieldProfile.phone,
                    value: state.phone ?? '--'),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorsFM.neutral99,
                ),
                FieldProfile(
                    fieldName: Languages.of(context).emailText,
                    typeFieldProfile: TypeFieldProfile.email,
                    value: state.modelUser?.email ?? '--')
              ]),
          if (state.showCurpInfo)
            LayoutBuilder(builder: (context, constraints) {
              return GestureDetector(
                  onTap: () =>
                      context.read<ProfileBloc>().add(OnShowCurpInfo()),
                  child: Container(
                      color: Colors.transparent,
                      height: constraints.maxHeight,
                      padding: EdgeInsets.only(
                          top: 215, bottom: constraints.maxHeight - 215 - 56),
                      child: const CURPInfo()));
            })

          //const Positioned(top: 215, child: CURPInfo())
        ]);
      },
    );
  }
}

enum TypeFieldProfile { name, gender, curp, birthday, phone, email }

class FieldProfile extends StatelessWidget {
  final String fieldName;
  final String value;
  final TypeFieldProfile typeFieldProfile;

  const FieldProfile(
      {Key? key,
      required this.fieldName,
      required this.typeFieldProfile,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '## #### ####',
        filter: {'#': RegExp(r'[0-9]')},
        initialText: value,
        type: MaskAutoCompletionType.lazy);

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: extraSmallMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fieldName,
                style: TypefaceStyles.semiBoldMontserrat,
              ),
              const SizedBox(
                height: minMargin,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    typeFieldProfile == TypeFieldProfile.phone
                        ? maskFormatter.getMaskedText()
                        : value,
                    style: TypefaceStyles.bodyMediumMontserrat,
                    textAlign: TextAlign.start,
                  ),
                  if (typeFieldProfile == TypeFieldProfile.phone)
                    GestureDetector(
                        onTap: () {
                          BottomSheetDialogHelper.showModalBottom(
                                  context, fieldName, typeFieldProfile)
                              .then((result) {
                            if (typeFieldProfile == TypeFieldProfile.phone) {
                              if (result != null) {
                                context
                                    .read<ProfileBloc>()
                                    .add(OnSavePhone(phone: result));
                              }
                            }
                          });
                        },
                        child: SvgPicture.asset(iconPencil))
                  else if (typeFieldProfile == TypeFieldProfile.curp)
                    GestureDetector(
                        onTap: () {
                          context.read<ProfileBloc>().add(OnShowCurpInfo());
                        },
                        child: SvgPicture.asset(iconAlert))
                  else
                    Container()
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
