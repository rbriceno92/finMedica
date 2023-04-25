import 'package:app/features/change_password/data/models/change_password_request.dart';
import 'package:app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_state.dart';
import 'change_password_event.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordBloc({required this.changePasswordUseCase})
      : super(const ChangePasswordState()) {
    on<PasswordChange>(_onPasswordChange);
    on<NewPasswordChange>(_onNewPasswordChange);
    on<ConfirmePasswordChange>(_onConfirmePasswordChange);
    on<ChangePasswordVisible>(_onChangePasswordVisible);
    on<ChangeNewPasswordVisible>(_onChangeNewPasswordVisible);
    on<ChangeConfirmPasswordVisible>(_onChangeConfirmPasswordVisible);
    on<SendRequest>(_onSendRequest);
  }

  @override
  void onTransition(
      Transition<ChangePasswordEvent, ChangePasswordState> transition) {
    super.onTransition(transition);
  }

  void _onPasswordChange(
      PasswordChange event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        password: event.password,
        passwordHasErrors: event.password.length < 8 ||
            event.password.length > 25 ||
            Validators.emptyString(event.password) ||
            !Validators.hasUpperLetters(event.password) ||
            !Validators.haslowerLetters(event.password) ||
            !Validators.hasSpecialCharacters(event.password),
        samePasswordError: false));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onNewPasswordChange(
      NewPasswordChange event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        newPassword: event.password,
        newPasswordHasErrors: event.password.length < 8 ||
            event.password.length > 25 ||
            Validators.emptyString(event.password) ||
            !Validators.hasUpperLetters(event.password) ||
            !Validators.haslowerLetters(event.password) ||
            !Validators.hasSpecialCharacters(event.password),
        confirmePasswordHasErrors: (state.confirmePassword.isNotEmpty &&
            event.password != state.confirmePassword),
        samePasswordError: false));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onConfirmePasswordChange(
      ConfirmePasswordChange event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        confirmePassword: event.password,
        confirmePasswordHasErrors: event.password != state.newPassword));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onChangePasswordVisible(
      ChangePasswordVisible event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onChangeNewPasswordVisible(
      ChangeNewPasswordVisible event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(showNewPassword: !state.showNewPassword));
  }

  void _onChangeConfirmPasswordVisible(
      ChangeConfirmPasswordVisible event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(showConfirmePassword: !state.showConfirmePassword));
  }

  bool _checkFormReady() {
    return state.password.isNotEmpty &&
        !state.passwordHasErrors &&
        state.newPassword.isNotEmpty &&
        !state.newPasswordHasErrors &&
        state.confirmePassword.isNotEmpty &&
        !state.confirmePasswordHasErrors;
  }

  void _onSendRequest(
      SendRequest event, Emitter<ChangePasswordState> emit) async {
    if (state.password == state.newPassword) {
      emit(state.copyWith(samePasswordError: true, enableContinue: false));
      event.onError('ERROR_SAME_PASSWORD');
      return;
    }

    emit(state.copyWith(loading: true));
    var result = await changePasswordUseCase.call(ChangePasswordRequest(
      password: state.newPassword,
      currentPassword: state.password,
    ));
    bool success = false;
    String message = '';

    result.fold(
      (l) {
        if (l is ServerFailure) {
          if (l.modelServer.isSimple()) {
            message = l.modelServer.message;
          } else {
            message = (l.modelServer.message as List<MessageModel>?)!
                .map((e) => e.message)
                .join(', ');
          }
        }
        if (l is ErrorMessage) {
          message = l.message;
        }
      },
      (r) {
        success = true;
      },
    );
    if (success) {
      event.onSuccess();
      emit(state.copyWith(
          password: '',
          newPassword: '',
          confirmePassword: '',
          passwordHasErrors: false,
          newPasswordHasErrors: false,
          confirmePasswordHasErrors: false,
          enableContinue: false));
    } else {
      event.onError(message);
    }

    emit(state.copyWith(loading: false));
  }
}
