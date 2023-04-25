import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/my_groups_info.dart';

abstract class MyGroupsAddMemberEvent extends Equatable {
  const MyGroupsAddMemberEvent();
}

class FirstNameChange extends MyGroupsAddMemberEvent {
  final String firstName;

  const FirstNameChange({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class SecondNameChange extends MyGroupsAddMemberEvent {
  final String secondName;

  const SecondNameChange({required this.secondName});

  @override
  List<Object?> get props => [secondName];
}

class LastNameChange extends MyGroupsAddMemberEvent {
  final String lastName;

  const LastNameChange({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class MothersLastNameChange extends MyGroupsAddMemberEvent {
  final String mothersLastName;

  const MothersLastNameChange({required this.mothersLastName});

  @override
  List<Object?> get props => [mothersLastName];
}

class GenderChange extends MyGroupsAddMemberEvent {
  final Genders? gender;

  const GenderChange({required this.gender});

  @override
  List<Object?> get props => [gender];
}

class PhoneChange extends MyGroupsAddMemberEvent {
  final String phone;

  const PhoneChange({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class EmailChange extends MyGroupsAddMemberEvent {
  final String email;

  const EmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class CURPChange extends MyGroupsAddMemberEvent {
  final String curp;

  const CURPChange({required this.curp});

  @override
  List<Object?> get props => [curp];
}

class BirthdayChange extends MyGroupsAddMemberEvent {
  final String birthday;

  const BirthdayChange({required this.birthday});

  @override
  List<Object?> get props => [birthday];
}

class ChangeErrorEmailDuplicate extends MyGroupsAddMemberEvent {
  @override
  List<Object?> get props => [];
}

class ChangeErrorCURPDuplicate extends MyGroupsAddMemberEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCURPInfoVisible extends MyGroupsAddMemberEvent {
  @override
  List<Object?> get props => [];
}

class DisposeLoading extends MyGroupsAddMemberEvent {
  @override
  List<Object?> get props => [];
}

class SendSignUpData extends MyGroupsAddMemberEvent {
  final void Function(MyGroupsMember member) next;
  final void Function(String message)? error;

  const SendSignUpData({required this.next, this.error});

  @override
  List<Object?> get props => [next, error];
}

class SetGroupInfo extends MyGroupsAddMemberEvent {
  final MyGroupsInfo info;

  const SetGroupInfo({required this.info});

  @override
  List<Object?> get props => [info];
}
