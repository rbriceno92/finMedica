import 'package:app/core/di/modules.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_bloc.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_events.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_state.dart';
import 'package:app/features/my_groups/presentation/views/my_group_member_screen.dart';
import 'package:app/features/my_groups/presentation/widgets/filter_input.dart';
import 'package:app/features/my_groups/presentation/widgets/member_list_item.dart';
import 'package:app/features/my_groups/presentation/widgets/my_groups_alert.dart';
import 'package:app/features/my_groups/presentation/widgets/my_groups_bottom_sheeet.dart';
import 'package:app/features/my_groups/presentation/widgets/my_groups_transfer_alert.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/spinner_loading.dart';

class MyGroupsScreen extends StatelessWidget {
  final String? routeParent;
  const MyGroupsScreen({super.key, required this.routeParent});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<MyGroupsBloc>()
          ..add(FetchUser())
          ..add(FetchData()),
        child: MyGroupsView(routeParent: routeParent));
  }
}

class MyGroupsView extends StatelessWidget {
  final String? routeParent;

  const MyGroupsView({super.key, required this.routeParent});

  @override
  Widget build(BuildContext context) {
    bool isScheduleFlow = routeParent == dashboardRoute;
    bool isTransferFlow = routeParent == myCouponsRoute;

    return BlocConsumer<MyGroupsBloc, MyGroupsState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show && state.user != null) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.popUntil(
              context, (route) => route.settings.name == myGroupsRoute);
          context.read<MyGroupsBloc>().add(DisposeLoading());
          if (state.removeSuccess) {
            AlertNotification.success(
                context, Languages.of(context).removeMemberMessage);
          }
        }
        if (state.messageError.isNotEmpty) {
          AlertNotification.error(context, state.messageError);
        }
      },
      builder: ((context, state) {
        List<MyGroupsMember> members =
            state.filter.isEmpty || (state.members?.isEmpty ?? true)
                ? state.members ?? []
                : state.members!
                    .where((e) => e
                        .fullName()
                        .toLowerCase()
                        .contains(state.filter.toLowerCase()))
                    .toList();
        bool amIAdmin = state.groupInfo?.isAdmin ?? false;
        bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
        int numberOfMembers = state.members?.length ?? 0;
        return Scaffold(
            backgroundColor: ColorsFM.primaryLight99,
            appBar: AppBar(
              title: Text(isTransferFlow
                  ? Languages.of(context).trasnferCouponText
                  : Languages.of(context).myGroups),
              backgroundColor:
                  isScheduleFlow ? ColorsFM.green40 : ColorsFM.primary,
            ),
            body: state.loading == LoadingState.show || !state.canDisplay
                ? Container()
                : state.groupInfo != null
                    ? Stack(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: marginStandard,
                              right: marginStandard,
                              bottom: MediaQuery.of(context).padding.bottom +
                                  marginStandard,
                              top: mediumMargin),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 28,
                                  width: double.infinity,
                                  child: Stack(children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Text(
                                        Languages.of(context).familyGroup,
                                        style: TypefaceStyles.poppinsSemiBold22
                                            .copyWith(color: ColorsFM.primary),
                                      ),
                                    ),
                                    if (amIAdmin)
                                      routeParent == null
                                          ? Positioned(
                                              top: 0,
                                              bottom: 0,
                                              right: -12,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                          myGroupsConfigurationRoute,
                                                          arguments:
                                                              state.members)
                                                      .then((value) {
                                                    if (value != null) {
                                                      context
                                                          .read<MyGroupsBloc>()
                                                          .add(TransferManagement(
                                                              member: value
                                                                  as MyGroupsMember));
                                                    }
                                                  });
                                                },
                                                padding: EdgeInsets.zero,
                                                icon: SvgPicture.asset(
                                                  iconConfiguration,
                                                  color: Colors.black,
                                                ),
                                              ))
                                          : Container()
                                  ]),
                                ),
                                const SizedBox(height: marginStandard),
                                Text(Languages.of(context).groupAdmin,
                                    style: TypefaceStyles.bodyMediumMontserrat
                                        .copyWith(
                                      color: ColorsFM.neutralDark,
                                      fontWeight: FontWeight.w500,
                                    )),
                                const SizedBox(height: extraSmallMargin),
                                Text(
                                  state.admin?.fullName() ?? '--',
                                  style: TypefaceStyles.bodySmallMontserrat12,
                                ),
                                Text(
                                    '${!isTransferFlow ? '${state.admin!.gender == Genders.m ? Languages.of(context).male : Languages.of(context).female} - ' : ''}${state.admin!.age} ${Languages.of(context).years}',
                                    style:
                                        TypefaceStyles.bodySmallMontserrat12),
                                const SizedBox(height: marginStandard),
                                routeParent == null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              Languages.of(context)
                                                  .groupMembers(
                                                      numberOfMembers + 1),
                                              style: TypefaceStyles
                                                  .bodyMediumMontserrat
                                                  .copyWith(
                                                color: ColorsFM.neutralDark,
                                              )),
                                          Text(Languages.of(context).maxMembers,
                                              style: TypefaceStyles
                                                  .bodyMediumMontserrat
                                                  .copyWith(
                                                color: ColorsFM.neutralDark,
                                              )),
                                        ],
                                      )
                                    : Container(),
                                const SizedBox(height: smallMargin),
                                FilterByNameInput(
                                  hintText: Languages.of(context).filterByName,
                                  onChanged: (value) {
                                    context
                                        .read<MyGroupsBloc>()
                                        .add(ChangeFilter(filter: value));
                                  },
                                ),
                                const SizedBox(height: marginStandard),
                                if (state.filter == '' && members.isEmpty) ...[
                                  Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8,
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              Languages.of(context)
                                                  .notMembersYet,
                                              style: TypefaceStyles
                                                  .poppinsSemiBold22
                                                  .copyWith(
                                                color: ColorsFM.blueDark90,
                                              ),
                                            ),
                                            const SizedBox(height: smallMargin),
                                            Text(
                                              textAlign: TextAlign.center,
                                              Languages.of(context)
                                                  .addNewExistingMember,
                                              style: TypefaceStyles
                                                  .bodySmallMontserrat12
                                                  .copyWith(
                                                color: ColorsFM.primary80,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ] else if (members.isEmpty) ...[
                                  Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8,
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              Languages.of(context)
                                                  .noResultsForSearch,
                                              style: TypefaceStyles
                                                  .poppinsSemiBold22
                                                  .copyWith(
                                                color: ColorsFM.blueDark90,
                                              ),
                                            ),
                                            const SizedBox(height: smallMargin),
                                            Text(
                                              textAlign: TextAlign.center,
                                              Languages.of(context)
                                                  .noResultsForSearchGroups,
                                              style: TypefaceStyles
                                                  .poppinsRegular
                                                  .copyWith(
                                                color: ColorsFM.primary80,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ] else ...[
                                  Expanded(
                                    child: ListView.separated(
                                      padding: const EdgeInsets.only(
                                          bottom: marginStandard),
                                      itemCount: members.length,
                                      itemBuilder: (context, index) {
                                        String icon = '';
                                        if (isScheduleFlow) {
                                          icon = iconPlus;
                                        } else if (isTransferFlow) {
                                          icon = iconTransfer;
                                        } else if (amIAdmin ||
                                            state.user!.userId ==
                                                state.members![index].userId) {
                                          icon = iconCancel;
                                        }
                                        return MemberListItem(
                                          member: members[index],
                                          icon: icon,
                                          onItemPress: (member) {
                                            if (amIAdmin) {
                                              Navigator.pushNamed(
                                                  context, myGroupsMemberRoute,
                                                  arguments:
                                                      MyGroupsMemberScreenArgs(
                                                          state.groupInfo!,
                                                          member));
                                            }
                                          },
                                          onIconPress: (member) {
                                            if (amIAdmin && isScheduleFlow) {
                                              Navigator.of(context).pushNamed(
                                                  directoryRoute,
                                                  arguments: member);
                                            } else if (amIAdmin &&
                                                isTransferFlow) {
                                              showDialog<bool?>(
                                                      context: context,
                                                      builder: (context) =>
                                                          MyGroupsTransferAlert(
                                                              name: member
                                                                  .fullName()))
                                                  .then((accept) {
                                                if (accept != null && accept) {
                                                  Navigator.pop(
                                                      context, member);
                                                }
                                              });
                                            } else if (!amIAdmin &&
                                                state.user!.userId ==
                                                    state.members![index]
                                                        .userId) {
                                              showDialog<bool?>(
                                                      context: context,
                                                      builder: (context) =>
                                                          MyGroupsAlert(
                                                              title: Languages.of(
                                                                      context)
                                                                  .warningUnlinkFromGroup))
                                                  .then((result) {
                                                if (result != null && result) {
                                                  context
                                                      .read<MyGroupsBloc>()
                                                      .add(LeaveGroup());
                                                }
                                              });
                                            } else {
                                              showDialog<bool?>(
                                                  context: context,
                                                  builder: (context) =>
                                                      MyGroupsAlert(
                                                        removeMember: true,
                                                        title:
                                                            member.fullName(),
                                                      )).then((result) {
                                                if (result != null && result) {
                                                  context
                                                      .read<MyGroupsBloc>()
                                                      .add(RemoveMember(
                                                          userId:
                                                              member.userId ??
                                                                  ''));
                                                }
                                              });
                                            }
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              height: extraSmallMargin),
                                    ),
                                  )
                                ],
                                SizedBox(
                                  height: (routeParent == null
                                          ? 56
                                          : marginStandard) +
                                      MediaQuery.of(context).padding.bottom,
                                )
                              ]),
                        ),
                        if (amIAdmin && !keyboardIsOpen)
                          routeParent == null
                              ? Positioned(
                                  bottom: marginStandard +
                                      MediaQuery.of(context).padding.bottom,
                                  right: 0,
                                  left: 0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorsFM.green40,
                                        minimumSize: const Size(56, 56),
                                        shape: const CircleBorder(),
                                        disabledBackgroundColor:
                                            ColorsFM.neutral99),
                                    onPressed: () {
                                      if (!(numberOfMembers + 1 >= 10)) {
                                        showModalBottomSheet<MyGroupsMember?>(
                                            context: context,
                                            clipBehavior: Clip.hardEdge,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            16))),
                                            builder: (context) =>
                                                MyGroupsBottomSheet(
                                                    info:
                                                        state.groupInfo!)).then(
                                            (member) {
                                          if (member != null) {
                                            context
                                                .read<MyGroupsBloc>()
                                                .add(AddMember(member: member));
                                          }
                                        });
                                      } else {
                                        showDialog<bool?>(
                                            context: context,
                                            builder: (context) => MyGroupsAlert(
                                                  inviteMember: true,
                                                  memberLimit: true,
                                                  title: Languages.of(context)
                                                      .memberLimitMessage,
                                                ));
                                      }
                                    },
                                    child: SvgPicture.asset(iconPlus,
                                        height: 28, color: Colors.white),
                                  ),
                                )
                              : Container()
                      ])
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  Languages.of(context).dontBelongToAnyGroupYet,
                                  style:
                                      TypefaceStyles.poppinsSemiBold22.copyWith(
                                    color: ColorsFM.blueDark90,
                                  ),
                                ),
                                const SizedBox(height: smallMargin),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: largeMargin),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    Languages.of(context).hereCanCreateGroup,
                                    style: TypefaceStyles.bodySmallMontserrat12
                                        .copyWith(
                                      color: ColorsFM.primary80,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: marginStandard),
                            child: ButtonText(
                              text: Languages.of(context).createGroup,
                              onPressed: () {
                                context.read<MyGroupsBloc>().add(CreateGroup());
                              },
                            ),
                          ),
                          const SizedBox(height: marginStandard),
                        ],
                      ));
      }),
    );
  }
}
