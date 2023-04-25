import 'package:equatable/equatable.dart';

class SignUpPasswordState extends Equatable {
  final String password;
  final String confirmPassword;
  final bool passwordHasErrors;
  final bool confirmPasswordHasErrors;
  final bool showPassword;
  final bool showConfirmPassword;
  final bool enableContinue;

  const SignUpPasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.passwordHasErrors = false,
    this.confirmPasswordHasErrors = false,
    this.showPassword = false,
    this.showConfirmPassword = false,
    this.enableContinue = false,
  });

  SignUpPasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? passwordHasErrors,
    bool? confirmPasswordHasErrors,
    bool? showPassword,
    bool? showConfirmPassword,
    bool? enableContinue,
  }) {
    return SignUpPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordHasErrors: passwordHasErrors ?? this.passwordHasErrors,
      confirmPasswordHasErrors:
          confirmPasswordHasErrors ?? this.confirmPasswordHasErrors,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      enableContinue: enableContinue ?? this.enableContinue,
    );
  }

  @override
  List<Object?> get props => [
        password,
        confirmPassword,
        passwordHasErrors,
        confirmPasswordHasErrors,
        showPassword,
        showConfirmPassword,
        enableContinue
      ];
}
