import 'package:equatable/equatable.dart';

abstract class ValidationCodeEvent extends Equatable {
  const ValidationCodeEvent();
}

class CodeSubmitted extends ValidationCodeEvent {
  final String email;
  final String code;

  const CodeSubmitted({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}

class SendingCode extends ValidationCodeEvent {
  final String email;

  const SendingCode({required this.email});

  @override
  List<Object?> get props => [email];
}
