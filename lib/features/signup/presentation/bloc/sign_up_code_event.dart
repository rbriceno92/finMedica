import 'package:app/features/signup/presentation/views/sign_up_code_screen.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpCodeEvent extends Equatable {
  const SignUpCodeEvent();
}

class CodeChange extends SignUpCodeEvent {
  final String code;

  const CodeChange({required this.code});
  @override
  List<Object?> get props => [code];
}

class SendData extends SignUpCodeEvent {
  final void Function() next;
  final void Function() error;
  final SignUpCodeParams data;

  const SendData({required this.next, required this.data, required this.error});

  @override
  List<Object?> get props => [next];
}

class ResendCodeEvent extends SignUpCodeEvent {
  final String userId;

  const ResendCodeEvent({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class CleanMessage extends SignUpCodeEvent {
  @override
  List<Object?> get props => [];
}
