import 'package:equatable/equatable.dart';

class ChangePasswordState extends Equatable {
  final String password;
  final String newPassword;
  final String confirmePassword;
  final bool passwordHasErrors;
  final bool newPasswordHasErrors;
  final bool confirmePasswordHasErrors;
  final bool showPassword;
  final bool showNewPassword;
  final bool showConfirmePassword;
  final bool enableContinue;
  final bool samePasswordError;
  final bool loading;

  const ChangePasswordState({
    this.password = '',
    this.newPassword = '',
    this.confirmePassword = '',
    this.passwordHasErrors = false,
    this.newPasswordHasErrors = false,
    this.confirmePasswordHasErrors = false,
    this.showPassword = false,
    this.showNewPassword = false,
    this.showConfirmePassword = false,
    this.enableContinue = false,
    this.loading = false,
    this.samePasswordError = false,
  });

  ChangePasswordState copyWith({
    String? password,
    String? newPassword,
    String? confirmePassword,
    bool? passwordHasErrors,
    bool? newPasswordHasErrors,
    bool? confirmePasswordHasErrors,
    bool? showPassword,
    bool? showNewPassword,
    bool? showConfirmePassword,
    bool? enableContinue,
    bool? loading,
    bool? samePasswordError,
  }) {
    return ChangePasswordState(
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      confirmePassword: confirmePassword ?? this.confirmePassword,
      passwordHasErrors: passwordHasErrors ?? this.passwordHasErrors,
      newPasswordHasErrors: newPasswordHasErrors ?? this.newPasswordHasErrors,
      confirmePasswordHasErrors:
          confirmePasswordHasErrors ?? this.confirmePasswordHasErrors,
      showPassword: showPassword ?? this.showPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmePassword: showConfirmePassword ?? this.showConfirmePassword,
      enableContinue: enableContinue ?? this.enableContinue,
      loading: loading ?? this.loading,
      samePasswordError: samePasswordError ?? this.samePasswordError,
    );
  }

  @override
  List<Object?> get props => [
        password,
        newPassword,
        confirmePassword,
        passwordHasErrors,
        newPasswordHasErrors,
        confirmePasswordHasErrors,
        showPassword,
        showNewPassword,
        showConfirmePassword,
        enableContinue,
        loading,
      ];
}
