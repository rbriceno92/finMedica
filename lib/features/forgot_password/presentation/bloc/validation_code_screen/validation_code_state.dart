import 'package:equatable/equatable.dart';

class ValidationCodeState extends Equatable {
  final String? messageError;
  final bool? codeAccepted;
  final String? code;
  final String? token;
  final bool? loading;

  const ValidationCodeState(
      {this.messageError,
      this.codeAccepted = false,
      this.code,
      this.token,
      this.loading});

  ValidationCodeState copyWith(
      {String? messageError,
      bool? codeAccepted,
      String? code,
      String? token,
      bool? loading}) {
    return ValidationCodeState(
        messageError: messageError ?? this.messageError,
        codeAccepted: codeAccepted,
        code: code ?? this.code,
        token: token ?? this.token,
        loading: loading);
  }

  @override
  List<Object?> get props => [code, messageError, codeAccepted, token, loading];
}
