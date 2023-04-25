import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/my_groups_info.dart';

class MyGroupsAddExistingState extends Equatable {
  final List<MyGroupsMember> members;
  final String filter;
  final LoadingState loading;
  final bool addSuccess;
  final MyGroupsMember? member;
  final MyGroupsInfo? admin;
  final String errorMessage;

  const MyGroupsAddExistingState(
      {this.members = const [],
      this.filter = '',
      this.loading = LoadingState.dispose,
      this.addSuccess = false,
      this.admin,
      this.errorMessage = '',
      this.member});

  MyGroupsAddExistingState copyWith(
          {List<MyGroupsMember>? members,
          String? filter,
          LoadingState? loading,
          bool? addSuccess,
          MyGroupsInfo? admin,
          String? errorMessage,
          MyGroupsMember? member}) =>
      MyGroupsAddExistingState(
          members: members ?? this.members,
          filter: filter ?? this.filter,
          loading: loading ?? this.loading,
          addSuccess: addSuccess ?? this.addSuccess,
          admin: admin ?? this.admin,
          errorMessage: errorMessage ?? this.errorMessage,
          member: member ?? this.member);

  @override
  List<Object?> get props =>
      [members, filter, loading, addSuccess, admin, errorMessage];
}
