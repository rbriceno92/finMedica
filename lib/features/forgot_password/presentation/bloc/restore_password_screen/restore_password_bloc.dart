import 'dart:async';
import 'dart:convert';

import 'package:app/features/forgot_password/data/models/update_password_model.dart';
import 'package:app/features/forgot_password/domain/use_cases/update_password_use_case.dart';
import 'package:app/features/forgot_password/presentation/bloc/restore_password_screen/restore_password_event.dart';
import 'package:app/features/forgot_password/presentation/bloc/restore_password_screen/restore_password_state.dart';
import 'package:app/util/failure.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestorePasswordBloc
    extends Bloc<RestorePasswordEvent, RestorePasswordState> {
  static const String uppercaseRequired = '.*[A-Z].*';
  static const String lowercaseRequired = '.*[a-z].*';
  static const String numberRequired = '.*[0-9].*';
  static const String charactersRequired = r'.*[!@#$%^&*(),.?":{}|<>].*';
  UpdatePasswordUseCase updatePasswordUseCase;

  RestorePasswordBloc({required this.updatePasswordUseCase})
      : super(const RestorePasswordState()) {
    on<RestorePasswordsSubmitted>(onRestorePasswordSubmitted);
    on<OnChangeRestorePassword>(onChangeRestorePassword);
    on<ChangePasswordVisible>(onChangePasswordVisible);
    on<ChangeConfirmPasswordVisible>(onChangeConfirmPasswordVisible);
    on<UpdatePassword>(onUpdatePassword);
  }

  void onRestorePasswordSubmitted(
      RestorePasswordsSubmitted event, Emitter<RestorePasswordState> emit) {
    if (event.password == state.newPassword) {
      emit(state.copyWith(
          passwordsEquals: true,
          messageError: '',
          validFormats: state.validFormats,
          confirmedPassword: event.password));
    } else {
      emit(state.copyWith(
          passwordsEquals: false,
          messageError: '',
          validFormats: state.validFormats,
          confirmedPassword: event.password));
    }
  }

  void onChangeRestorePassword(
      OnChangeRestorePassword event, Emitter<RestorePasswordState> emit) {
    bool minimumChars = event.password.length >= 8 ? true : false;
    bool minimumOneCapitalLetter =
        RegExp(uppercaseRequired).hasMatch(event.password);
    bool minimumOneLowercaseLetter =
        RegExp(lowercaseRequired).hasMatch(event.password);
    bool minimumNumberRequired =
        RegExp(numberRequired).hasMatch(event.password);
    bool minimumCharactersSpecials =
        RegExp(charactersRequired).hasMatch(event.password);

    var validFormat = false;

    if (minimumChars &&
        minimumOneCapitalLetter &&
        minimumOneLowercaseLetter &&
        minimumNumberRequired &&
        minimumCharactersSpecials) {
      validFormat = true;
    }

    emit(state.copyWith(
        minimumCharacters: minimumChars,
        minimumCapitalLetterRequired: minimumOneCapitalLetter,
        minimumLowerCaseLetterRequired: minimumOneLowercaseLetter,
        minimumNumberRequired: minimumNumberRequired,
        minimumEspecialCharRequired: minimumCharactersSpecials,
        newPassword: event.password,
        passwordsEquals: event.password == state.confirmedPassword,
        messageError: '',
        validFormats: validFormat));
  }

  void onChangePasswordVisible(
      ChangePasswordVisible event, Emitter<RestorePasswordState> emit) {
    emit(state.copyWith(
        showPassword: !state.showPassword, validFormats: state.validFormats));
  }

  void onChangeConfirmPasswordVisible(
      ChangeConfirmPasswordVisible event, Emitter<RestorePasswordState> emit) {
    emit(state.copyWith(
        showConfirmPassword: !state.showConfirmPassword,
        validFormats: state.validFormats));
  }

  FutureOr<void> onUpdatePassword(
      UpdatePassword event, Emitter<RestorePasswordState> emit) async {
    emit(state.copyWith(loading: true, validFormats: state.validFormats));
    var result = await updatePasswordUseCase.call(UpdatePasswordModel(
        token: event.token,
        password: md5.convert(utf8.encode(state.newPassword!)).toString()));
    result.fold((l) {
      if (l is ServerFailure) {
        if (l.modelServer.isSimple()) {
          emit(state.copyWith(
              messageError: l.modelServer.message,
              loading: false,
              validFormats: state.validFormats));
        } else {
          emit(state.copyWith(
              messageError: l.modelServer.message?.first.message,
              loading: false,
              validFormats: state.validFormats));
        }
      }
      if (l is ErrorMessage) {
        emit(state.copyWith(
            messageError: l.message,
            validFormats: state.validFormats,
            loading: false));
      }
    }, (r) {
      emit(state.copyWith(
          messageError: null, changePassword: true, loading: false));
    });
  }
}
