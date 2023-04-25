import 'package:app/features/my_groups/domain/entities/my_groups_admin.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/my_groups_info.dart';

class MyGroupsState extends Equatable {
  final MyGroupsAdmin? admin;
  final List<MyGroupsMember>? members;
  final String filter;
  final LoadingState loading;
  final bool removeSuccess;
  final ModelUser? user;
  final MyGroupsInfo? groupInfo;
  final bool useFilter;
  final String messageError;
  final bool canDisplay;

  const MyGroupsState(
      {this.admin,
      this.members,
      this.filter = '',
      this.loading = LoadingState.dispose,
      this.removeSuccess = false,
      this.groupInfo,
      this.useFilter = false,
      this.messageError = '',
      this.user,
      this.canDisplay = true});

  MyGroupsState copyWith(
          {MyGroupsAdmin? admin,
          bool? useFilter,
          List<MyGroupsMember>? members,
          String? filter,
          LoadingState? loading,
          bool? removeSuccess,
          MyGroupsInfo? groupInfo,
          String? messageError,
          ModelUser? user,
          bool? canDisplay}) =>
      MyGroupsState(
        admin: admin ?? this.admin,
        members: members ?? this.members,
        useFilter: useFilter ?? this.useFilter,
        filter: filter ?? this.filter,
        loading: loading ?? this.loading,
        removeSuccess: removeSuccess ?? this.removeSuccess,
        groupInfo: groupInfo ?? this.groupInfo,
        messageError: messageError ?? this.messageError,
        user: user ?? this.user,
        canDisplay: canDisplay ?? this.canDisplay,
      );

  @override
  List<Object?> get props => [
        admin,
        members,
        filter,
        loading,
        user,
        removeSuccess,
        groupInfo,
        useFilter,
        messageError,
        canDisplay
      ];
}
