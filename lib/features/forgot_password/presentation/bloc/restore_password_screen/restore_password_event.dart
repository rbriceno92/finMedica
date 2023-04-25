import 'package:equatable/equatable.dart';

abstract class RestorePasswordEvent extends Equatable {
  const RestorePasswordEvent();
}

class RestorePasswordsSubmitted extends RestorePasswordEvent {
  final String password;

  const RestorePasswordsSubmitted(this.password);

  @override
  List<Object?> get props => [password];
}

class OnChangeRestorePassword extends RestorePasswordEvent {
  final String password;

  const OnChangeRestorePassword({required this.password});

  @override
  List<Object?> get props => [password];
}

class ChangePasswordVisible extends RestorePasswordEvent {
  @override
  List<Object?> get props => [];
}

class ChangeConfirmPasswordVisible extends RestorePasswordEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePassword extends RestorePasswordEvent {
  final String token;
  final String password;

  const UpdatePassword({required this.token, required this.password});

  @override
  List<Object?> get props => [token, password];
}
