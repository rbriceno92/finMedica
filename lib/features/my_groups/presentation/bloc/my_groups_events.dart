import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/my_groups_info.dart';

abstract class MyGroupsEvent extends Equatable {
  const MyGroupsEvent();
}

class DisposeLoading extends MyGroupsEvent {
  @override
  List<Object?> get props => [];
}

class RemoveMember extends MyGroupsEvent {
  final String userId;
  const RemoveMember({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class ChangeFilter extends MyGroupsEvent {
  final String filter;
  const ChangeFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class FetchData extends MyGroupsEvent {
  @override
  List<Object?> get props => [];
}

class AddMember extends MyGroupsEvent {
  final MyGroupsMember member;

  const AddMember({required this.member});
  @override
  List<Object?> get props => [member];
}

class FetchUser extends MyGroupsEvent {
  @override
  List<Object?> get props => [];
}

class TransferManagement extends MyGroupsEvent {
  final MyGroupsMember member;

  const TransferManagement({required this.member});
  @override
  List<Object?> get props => [member];
}

class LeaveGroup extends MyGroupsEvent {
  @override
  List<Object?> get props => [];
}

class CreateGroup extends MyGroupsEvent {
  @override
  List<Object?> get props => [];
}

class ScreenArguments {
  final MyGroupsInfo? admin;
  final MyGroupsMember? member;

  ScreenArguments(this.admin, this.member);
}

class SetAdminData extends MyGroupsEvent {
  final MyGroupsInfo admin;

  const SetAdminData({required this.admin});

  @override
  List<Object?> get props => [admin];
}

class ClearMesssage extends MyGroupsEvent {
  @override
  List<Object?> get props => [];
}
