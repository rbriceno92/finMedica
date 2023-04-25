import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum SignInTypesStates {
  initial,
  loading,
  onUserNameChange,
  onPasswordChange,
  signingIn
}

class SignInState extends Equatable {
  final String? messageError;
  final FormzStatus status;
  final bool showPassword;
  final bool invalidCredentials;
  final String password;
  final String email;
  final bool passwordHasErrors;
  final bool emailHasErrors;
  final bool enableForm;
  final bool showChangePasswordNotification;
  final bool showNotification;
  final bool showSessionEndModal;
  final String firebaseToken;

  const SignInState(
      {this.password = '',
      this.email = '',
      this.messageError = '',
      this.showPassword = true,
      this.invalidCredentials = false,
      this.status = FormzStatus.pure,
      this.emailHasErrors = false,
      this.passwordHasErrors = false,
      this.enableForm = false,
      this.showChangePasswordNotification = false,
      this.showNotification = false,
      this.showSessionEndModal = false,
      this.firebaseToken = ''});

  SignInState copyWith(
      {FormzStatus? status,
      String? messageError,
      bool? showPassword,
      bool? invalidCredentials,
      String? password,
      String? email,
      bool? passwordHasErrors,
      bool? emailHasErrors,
      bool? enableForm,
      bool? showChangePasswordNotification,
      bool? showNotification,
      bool? showSessionEndModal,
      String? firebaseToken}) {
    return SignInState(
        messageError: messageError ?? this.messageError,
        status: status ?? this.status,
        showPassword: showPassword ?? this.showPassword,
        invalidCredentials: invalidCredentials ?? this.invalidCredentials,
        password: password ?? this.password,
        email: email ?? this.email,
        emailHasErrors: emailHasErrors ?? this.emailHasErrors,
        passwordHasErrors: passwordHasErrors ?? this.passwordHasErrors,
        enableForm: enableForm ?? this.enableForm,
        showChangePasswordNotification: showChangePasswordNotification ?? false,
        showNotification: showNotification ?? this.showNotification,
        showSessionEndModal: showSessionEndModal ?? this.showSessionEndModal,
        firebaseToken: firebaseToken ?? this.firebaseToken);
  }

  @override
  List<Object?> get props => [
        status,
        messageError,
        status,
        showPassword,
        invalidCredentials,
        password,
        email,
        emailHasErrors,
        passwordHasErrors,
        showChangePasswordNotification,
        showNotification,
        showSessionEndModal,
        firebaseToken
      ];
}
