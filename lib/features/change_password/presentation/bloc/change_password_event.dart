import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class PasswordChange extends ChangePasswordEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class NewPasswordChange extends ChangePasswordEvent {
  final String password;

  const NewPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmePasswordChange extends ChangePasswordEvent {
  final String password;

  const ConfirmePasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class ChangePasswordVisible extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}

class ChangeNewPasswordVisible extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}

class ChangeConfirmPasswordVisible extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}

class SendRequest extends ChangePasswordEvent {
  final void Function() onSuccess;
  final void Function(String message) onError;

  const SendRequest({required this.onSuccess, required this.onError});

  @override
  List<Object?> get props => [];
}
