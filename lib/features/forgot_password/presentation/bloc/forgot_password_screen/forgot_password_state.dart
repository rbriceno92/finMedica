import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool emailInvalid;
  final String? messageError;
  final String? email;
  final bool formatEmailInvalid;
  final bool emailAlreadySended;
  final bool? loading;
  final String? name;

  const ForgotPasswordState(
      {this.emailInvalid = false,
      this.messageError = '',
      this.email = '',
      this.formatEmailInvalid = false,
      this.emailAlreadySended = false,
      this.loading,
      this.name});

  ForgotPasswordState copyWith(
      {bool? emailInvalid,
      String? messageError,
      String? email,
      bool? formatEmailInvalid,
      bool? emailAlreadySended,
      bool? loading,
      String? name}) {
    return ForgotPasswordState(
        emailInvalid: emailInvalid ?? this.emailInvalid,
        messageError: messageError ?? this.messageError,
        email: email ?? this.email,
        formatEmailInvalid: formatEmailInvalid ?? this.formatEmailInvalid,
        emailAlreadySended: emailAlreadySended ?? this.emailAlreadySended,
        loading: loading,
        name: name ?? this.name);
  }

  @override
  List<Object?> get props => [
        emailInvalid,
        messageError,
        email,
        formatEmailInvalid,
        emailAlreadySended,
        loading
      ];
}
