import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:equatable/equatable.dart';

abstract class MyGroupsConfigurationEvent extends Equatable {
  const MyGroupsConfigurationEvent();
}

class DisposeLoading extends MyGroupsConfigurationEvent {
  @override
  List<Object?> get props => [];
}

class SelectMember extends MyGroupsConfigurationEvent {
  final MyGroupsMember? member;

  const SelectMember({required this.member});

  @override
  List<Object?> get props => [member];
}

class ChangeFilter extends MyGroupsConfigurationEvent {
  final String filter;

  const ChangeFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class FetchData extends MyGroupsConfigurationEvent {
  final List<MyGroupsMember> members;

  const FetchData(this.members);

  @override
  List<Object?> get props => [members];
}

class SendData extends MyGroupsConfigurationEvent {
  final void Function() onError;
  final void Function() onSuccess;

  const SendData({required this.onError, required this.onSuccess});

  @override
  List<Object?> get props => [onError, onSuccess];
}
