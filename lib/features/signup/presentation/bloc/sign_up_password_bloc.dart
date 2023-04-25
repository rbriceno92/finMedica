import 'package:app/features/signup/presentation/bloc/sign_up_event.dart';
import 'package:app/util/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_password_state.dart';

class SignUpPasswordBloc extends Bloc<SignUpEvent, SignUpPasswordState> {
  SignUpPasswordBloc() : super(const SignUpPasswordState()) {
    on<PasswordChange>(_onPasswordChange);
    on<ConfirmPasswordChange>(_onConfirmPasswordChange);
    on<ChangePasswordVisible>(_onChangePasswordVisible);
    on<ChangeConfirmPasswordVisible>(_onChangeConfirmPasswordVisible);
  }

  @override
  void onTransition(Transition<SignUpEvent, SignUpPasswordState> transition) {
    super.onTransition(transition);
  }

  void _onPasswordChange(
      PasswordChange event, Emitter<SignUpPasswordState> emit) {
    emit(state.copyWith(
        password: event.password,
        passwordHasErrors: event.password.length < 8 ||
            event.password.length > 25 ||
            Validators.emptyString(event.password) ||
            !Validators.hasUpperLetters(event.password) ||
            !Validators.haslowerLetters(event.password) ||
            !Validators.hasSpecialCharacters(event.password),
        confirmPasswordHasErrors: (state.confirmPassword.isNotEmpty &&
            event.password != state.confirmPassword)));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onConfirmPasswordChange(
      ConfirmPasswordChange event, Emitter<SignUpPasswordState> emit) {
    emit(state.copyWith(
        confirmPassword: event.password,
        confirmPasswordHasErrors: event.password != state.password));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onChangePasswordVisible(
      ChangePasswordVisible event, Emitter<SignUpPasswordState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onChangeConfirmPasswordVisible(
      ChangeConfirmPasswordVisible event, Emitter<SignUpPasswordState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  bool _checkFormReady() {
    return state.password.isNotEmpty &&
        !state.passwordHasErrors &&
        state.confirmPassword.isNotEmpty &&
        !state.confirmPasswordHasErrors;
  }
}
