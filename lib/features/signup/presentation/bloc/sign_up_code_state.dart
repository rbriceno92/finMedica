import 'package:equatable/equatable.dart';

class SignUpCodeState extends Equatable {
  final bool enableButton;
  final bool codeError;
  final String code;
  final bool loading;
  final String message;
  final String messageError;

  const SignUpCodeState(
      {this.enableButton = false,
      this.code = '',
      this.message = '',
      this.messageError = '',
      this.loading = false,
      this.codeError = false});

  SignUpCodeState copyWith(
      {bool? enableButton,
      String? code,
      bool? loading,
      bool? codeError,
      String? message,
      String? messageError}) {
    return SignUpCodeState(
        messageError: messageError ?? this.messageError,
        message: message ?? this.message,
        enableButton: enableButton ?? this.enableButton,
        codeError: codeError ?? this.codeError,
        code: code ?? this.code,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props =>
      [code, enableButton, loading, message, messageError];
}
