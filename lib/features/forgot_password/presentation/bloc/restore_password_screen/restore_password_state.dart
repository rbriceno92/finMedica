import 'package:equatable/equatable.dart';

class RestorePasswordState extends Equatable {
  final String? messageError;
  final bool passwordsEquals;
  final String? newPassword;
  final String? confirmedPassword;
  final bool? minimumCharacters;
  final bool? minimumCapitalLetterRequired;
  final bool? minimumLowerCaseLetterRequired;
  final bool? minimumNumberRequired;
  final bool? minimumEspecialCharRequired;
  final bool showPassword;
  final bool showConfirmPassword;
  final String? token;
  final bool? changePassword;
  final bool? loading;
  final bool? validFormats;

  const RestorePasswordState(
      {this.messageError,
      this.confirmedPassword,
      this.passwordsEquals = false,
      this.newPassword,
      this.minimumCharacters = false,
      this.minimumCapitalLetterRequired = false,
      this.minimumLowerCaseLetterRequired = false,
      this.minimumNumberRequired = false,
      this.minimumEspecialCharRequired = false,
      this.showPassword = false,
      this.showConfirmPassword = false,
      this.token,
      this.changePassword = false,
      this.loading,
      this.validFormats = false});

  RestorePasswordState copyWith(
      {String? messageError,
      bool? passwordsEquals,
      String? newPassword,
      bool? minimumCharacters,
      bool? minimumCapitalLetterRequired,
      bool? minimumLowerCaseLetterRequired,
      bool? minimumNumberRequired,
      bool? minimumEspecialCharRequired,
      bool? showPassword,
      bool? showConfirmPassword,
      String? token,
      bool? changePassword,
      bool? loading,
      bool? validFormats,
      String? confirmedPassword}) {
    return RestorePasswordState(
        messageError: messageError ?? this.messageError,
        passwordsEquals: passwordsEquals ?? this.passwordsEquals,
        newPassword: newPassword ?? this.newPassword,
        minimumCharacters: minimumCharacters ?? this.minimumCharacters,
        minimumCapitalLetterRequired:
            minimumCapitalLetterRequired ?? this.minimumCapitalLetterRequired,
        minimumLowerCaseLetterRequired: minimumLowerCaseLetterRequired ??
            this.minimumLowerCaseLetterRequired,
        minimumNumberRequired:
            minimumNumberRequired ?? this.minimumNumberRequired,
        minimumEspecialCharRequired:
            minimumEspecialCharRequired ?? this.minimumEspecialCharRequired,
        showPassword: showPassword ?? this.showPassword,
        showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
        token: token ?? this.token,
        changePassword: changePassword ?? this.changePassword,
        loading: loading,
        validFormats: validFormats ?? false,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword);
  }

  @override
  List<Object?> get props => [
        messageError,
        passwordsEquals,
        newPassword,
        minimumCharacters,
        minimumCapitalLetterRequired,
        minimumLowerCaseLetterRequired,
        minimumNumberRequired,
        minimumEspecialCharRequired,
        showPassword,
        showConfirmPassword,
        token,
        changePassword,
        loading,
        validFormats
      ];
}
