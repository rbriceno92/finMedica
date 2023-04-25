import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class FirstNameChange extends SignUpEvent {
  final String firstName;

  const FirstNameChange({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class SecondNameChange extends SignUpEvent {
  final String secondName;

  const SecondNameChange({required this.secondName});

  @override
  List<Object?> get props => [secondName];
}

class LastNameChange extends SignUpEvent {
  final String lastName;

  const LastNameChange({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class MothersLastNameChange extends SignUpEvent {
  final String mothersLastName;

  const MothersLastNameChange({required this.mothersLastName});

  @override
  List<Object?> get props => [mothersLastName];
}

class GenderChange extends SignUpEvent {
  final Genders? gender;

  const GenderChange({required this.gender});

  @override
  List<Object?> get props => [gender];
}

class PhoneChange extends SignUpEvent {
  final String phone;

  const PhoneChange({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class EmailChange extends SignUpEvent {
  final String email;

  const EmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChange extends SignUpEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChange extends SignUpEvent {
  final String password;

  const ConfirmPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class CURPChange extends SignUpEvent {
  final String curp;

  const CURPChange({required this.curp});

  @override
  List<Object?> get props => [curp];
}

class BirthdayChange extends SignUpEvent {
  final String birthday;

  const BirthdayChange({required this.birthday});

  @override
  List<Object?> get props => [birthday];
}

class ChangePasswordVisible extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class ChangeConfirmPasswordVisible extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class ChangeErrorEmailDuplicate extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class ChangeErrorCURPDuplicate extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class ChangeCURPInfoVisible extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class DeclaresAcceptChange extends SignUpEvent {
  final bool declaresAccept;

  const DeclaresAcceptChange({required this.declaresAccept});
  @override
  List<Object?> get props => [declaresAccept];
}

class SendSignUpData extends SignUpEvent {
  final void Function() next;
  final SignUpData data;

  const SendSignUpData({required this.next, required this.data});

  @override
  List<Object?> get props => [next, data];
}

class DisposeLoading extends SignUpEvent {
  @override
  List<Object?> get props => [];
}
