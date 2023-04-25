import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class EmailChange extends ForgotPasswordEvent {
  final String email;

  const EmailChange({required this.email});
  @override
  List<Object?> get props => [email];
}

class EmailValidFormat extends ForgotPasswordEvent {
  final bool valid;

  const EmailValidFormat({required this.valid});

  @override
  List<Object?> get props => [valid];
}

class SendingEmail extends ForgotPasswordEvent {
  final String email;

  const SendingEmail({required this.email});

  @override
  List<Object?> get props => [email];
}
