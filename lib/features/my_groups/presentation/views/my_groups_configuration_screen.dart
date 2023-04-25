import 'package:app/core/di/modules.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_configuration_bloc.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_configuration_events.dart';
import 'package:app/features/my_groups/presentation/bloc/my_groups_configuration_state.dart';
import 'package:app/features/my_groups/presentation/widgets/filter_input.dart';
import 'package:app/features/my_groups/presentation/widgets/member_list_item.dart';
import 'package:app/features/my_groups/presentation/widgets/my_groups_alert.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyGroupsConfigurationScreen extends StatelessWidget {
  final List<MyGroupsMember>? members;

  const MyGroupsConfigurationScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<MyGroupsConfigurationBloc>()..add(FetchData(members ?? [])),
        child: const MyGroupsConfigurationView());
  }
}

class MyGroupsConfigurationView extends StatelessWidget {
  const MyGroupsConfigurationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyGroupsConfigurationBloc, MyGroupsConfigurationState>(
        listener: (context, state) {
      if (state.loading == LoadingState.close) {
        context.read<MyGroupsConfigurationBloc>().add(DisposeLoading());
      }
    }, builder: ((context, state) {
      List<MyGroupsMember> members =
          state.filter.isEmpty || state.members.isEmpty
              ? state.members
              : state.members
                  .where((e) => e
                      .fullName()
                      .toLowerCase()
                      .contains(state.filter.toLowerCase()))
                  .toList();

      if (!members.contains(state.selectMember)) {
        context
            .read<MyGroupsConfigurationBloc>()
            .add(const SelectMember(member: null));
      }
      return Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).groupConfiguration),
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
              Languages.of(context).groupAdministration,
              style: TypefaceStyles.poppinsSemiBold22
                  .copyWith(color: ColorsFM.primary),
            ),
            const SizedBox(height: extraSmallMargin),
            Text(Languages.of(context).transferGroupManagement,
                style: TypefaceStyles.bodyMediumMontserrat.copyWith(
                    color: ColorsFM.primary, fontWeight: FontWeight.w600)),
            const SizedBox(height: mediumMargin),
            FilterByNameInput(
              hintText: Languages.of(context).filterByName,
              onChanged: (value) {
                context
                    .read<MyGroupsConfigurationBloc>()
                    .add(ChangeFilter(filter: value));
              },
            ),
            const SizedBox(height: marginStandard),
            if (members.isEmpty) ...[
              const Spacer(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      Languages.of(context).noResultsForSearch,
                      style: TypefaceStyles.poppinsSemiBold22.copyWith(
                        color: ColorsFM.blueDark90,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: marginStandard),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    bool isSelected = members[index] == state.selectMember;
                    return MemberListItem(
                      configuration: true,
                      isSelected: isSelected,
                      member: members[index],
                      icon: isSelected ? iconAdmin : iconAdminOpacity,
                      onItemPress: (member) {},
                      onIconPress: (member) {
                        context.read<MyGroupsConfigurationBloc>().add(
                            SelectMember(
                                member: isSelected
                                    ? const MyGroupsMember()
                                    : member));
                      },
                      iconColor: isSelected
                          ? ColorsFM.green40
                          : const Color.fromRGBO(255, 255, 255, 0.5),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: extraSmallMargin),
                ),
              ),
            ],
            ButtonText(
              text: Languages.of(context).saveChanges,
              onPressed: state.selectMember != null
                  ? () {
                      showDialog<bool?>(
                              context: context,
                              builder: (context) => MyGroupsAlert(
                                  title: Languages.of(context)
                                      .warningTransferGroupManagement(
                                          state.selectMember!.fullName())))
                          .then((result) {
                        if (result != null && result) {
                          context.read<MyGroupsConfigurationBloc>().add(
                              SendData(
                                  onError: () => AlertNotification.error(
                                      context,
                                      'Hubo un error, intente nuevamente'),
                                  onSuccess: () {
                                    Navigator.pop(context, state.selectMember);
                                  }));
                        }
                      });
                    }
                  : null,
            ),
          ]),
        ),
      );
    }));
  }
}
