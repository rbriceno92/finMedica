import 'package:app/core/di/modules.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_add_exising_bloc.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_add_existing_state.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_events.dart';
import 'package:app/features/my_groups/presentation/widgets/filter_input.dart';
import 'package:app/features/my_groups/presentation/widgets/member_list_item.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../../../navigation/routes_names.dart';
import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/button_text_widgets.dart';
import '../../../../util/widgets/spinner_loading.dart';
import '../../domain/entities/my_groups_info.dart';
import '../widgets/my_groups_alert.dart';

class MyGroupsAddExistingScreen extends StatelessWidget {
  final MyGroupsInfo admin;
  const MyGroupsAddExistingScreen({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<MyGroupsAddExistingBloc>()
          ..add(SetAdminData(
              admin: MyGroupsInfo(
                  groupId: admin.groupId,
                  id: admin.id,
                  idAdmin: admin.idAdmin,
                  isAdmin: true))),
        child: MyGroupsAddExistingView());
  }
}

// ignore: must_be_immutable
class MyGroupsAddExistingView extends StatelessWidget {
  MyGroupsAddExistingView({super.key});
  Timer? _debounce;
  var filterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyGroupsAddExistingBloc, MyGroupsAddExistingState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          context.read<MyGroupsAddExistingBloc>().add(DisposeLoading());
          Navigator.pop(context);
        }
        if (state.errorMessage != '' && state.loading == LoadingState.close) {
          AlertNotification.error(context, state.errorMessage);
          context.read<MyGroupsAddExistingBloc>().add(ClearMesssage());
        }
        if (state.addSuccess && state.loading == LoadingState.close) {
          dialog(context);
          context
              .read<MyGroupsAddExistingBloc>()
              .add(const ChangeFilter(filter: ''));
          filterController.clear();
        }
      },
      builder: ((context, state) {
        bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
        return Scaffold(
          backgroundColor: ColorsFM.primaryLight99,
          appBar: AppBar(
            title: Text(Languages.of(context).addExisting),
          ),
          body: Padding(
            padding: EdgeInsets.only(
                left: marginStandard,
                right: marginStandard,
                bottom: MediaQuery.of(context).padding.bottom + marginStandard,
                top: mediumMargin),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                Languages.of(context).existingUser,
                style: TypefaceStyles.poppinsSemiBold22
                    .copyWith(color: ColorsFM.primary),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 0,
                      top: extraSmallMargin,
                      right: smallMargin,
                      bottom: marginStandard),
                  child: Text(
                      Languages.of(context).searchExistingUserDescription,
                      style: TypefaceStyles.montserrat10)),
              FilterByNameInput(
                controller: filterController,
                hintText: Languages.of(context).searchExistingUser,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    // do something with query
                    context
                        .read<MyGroupsAddExistingBloc>()
                        .add(ChangeFilter(filter: value.toString()));
                  });
                },
              ),
              const SizedBox(height: marginStandard),
              if (state.members.isEmpty && state.filter != '')
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          Languages.of(context).noResultsForSearchCode,
                          style: TypefaceStyles.poppinsSemiBold22.copyWith(
                            color: ColorsFM.blueDark90,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: marginStandard),
                    itemCount: state.members.length,
                    itemBuilder: (context, index) {
                      return MemberListItem(
                        member: state.members[index],
                        icon: '',
                        onItemPress: (member) {},
                        onIconPress: (userId) {
                          context
                              .read<MyGroupsAddExistingBloc>()
                              .add(AddMember(member: state.members[index]));
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: extraSmallMargin),
                  ),
                ),
              if (!keyboardIsOpen)
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ButtonText(
                    onPressed: state.members.isEmpty
                        ? null
                        : () {
                            context
                                .read<MyGroupsAddExistingBloc>()
                                .add(AddMember(member: state.members[0]));
                          },
                    text: Languages.of(context).addNewMemberToGroup,
                  ),
                ),
            ]),
          ),
        );
      }),
    );
  }

  dialog(BuildContext context) {
    return showDialog<bool?>(
        context: context,
        builder: (context) => MyGroupsAlert(
            title: Languages.of(context).inviteAnewMember,
            inviteMember: true)).then((value) {
      Navigator.pushNamedAndRemoveUntil(context, myGroupsRoute,
          (route) => route.settings.name == dashboardRoute);
    });
  }
}
