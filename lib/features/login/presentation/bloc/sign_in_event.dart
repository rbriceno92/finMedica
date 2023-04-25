import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class ShowPasswordToggle extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class EmailChange extends SignInEvent {
  final String email;

  const EmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChange extends SignInEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class SigningIn extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class ShowChangePasswordNotification extends SignInEvent {
  final bool show;

  const ShowChangePasswordNotification({required this.show});
  @override
  List<Object?> get props => [show];
}

class ShowSessionEndModal extends SignInEvent {
  final bool show;

  const ShowSessionEndModal({required this.show});
  @override
  List<Object?> get props => [show];
}

class ChangeShowNotification extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class ChangeShowEndModal extends SignInEvent {
  @override
  List<Object?> get props => [];
}

class GetFirebaseToken extends SignInEvent {
  @override
  List<Object?> get props => [];
}
