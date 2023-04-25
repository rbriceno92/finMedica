import 'dart:async';

import 'package:app/core/di/modules.dart';
import 'package:app/features/login/domain/entities/credentials.dart';
import 'package:app/features/login/presentation/bloc/sign_in_event.dart';
import 'package:app/features/login/presentation/bloc/sign_in_state.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:app/util/validators.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/use_cases/sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignIn signIn;
  final UserPreferenceDao sharedPreferences;

  SignInBloc({required this.signIn, required this.sharedPreferences})
      : super(const SignInState()) {
    on<ShowPasswordToggle>(_onShowPassword);
    on<SigningIn>(_onSigninIn);
    on<EmailChange>(_onEmailChange);
    on<PasswordChange>(_onPasswordChange);
    on<ShowChangePasswordNotification>(_onShowChangePasswordNotification);
    on<ShowSessionEndModal>(_onShowSessionEndModal);
    on<ChangeShowNotification>(_onChangeShowNotification);
    on<ChangeShowEndModal>(_onChangeShowEndModal);
    on<GetFirebaseToken>(_onGetFirebaseToken);
  }

  void _onShowPassword(ShowPasswordToggle event, Emitter<SignInState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  FutureOr<void> _onSigninIn(SigningIn event, Emitter<SignInState> emit) async {
    var result = await signIn
        .call(Credentials(email: state.email, password: state.password));
    String token = '';
    result.fold(
        (l) => {
              if (l is ServerFailure)
                if (l.modelServer.isSimple())
                  emit(state.copyWith(
                      status: FormzStatus.submissionFailure,
                      messageError: l.modelServer.message ?? '',
                      invalidCredentials:
                          l.modelServer.statusCode == 404 ? true : false,
                      showNotification: true))
                else
                  emit(state.copyWith(
                      status: FormzStatus.submissionFailure,
                      messageError: l.modelServer.message?.first.message ?? '',
                      invalidCredentials:
                          l.modelServer.statusCode == 404 ? true : false,
                      showNotification: true))
              else // TODO: implement validation with code 401 to take the user to the email verification
                emit(state.copyWith(
                    status: FormzStatus.submissionFailure,
                    messageError: (l as ErrorMessage).message,
                    showNotification: true))
            }, (r) {
      token = r.token;
      sharedPreferences.saveUser(r.user);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
    var prefs = getIt<SharedPreferences>();
    await prefs.setString('token', 'Bearer $token');
  }

  @override
  void onTransition(Transition<SignInEvent, SignInState> transition) {
    super.onTransition(transition);
    // Logger().i(transition);
  }

  void _onEmailChange(EmailChange event, Emitter<SignInState> emit) {
    if (event.email != state.email) {
      if (event.email.isEmpty) {
        emit(state.copyWith(
            email: event.email,
            emailHasErrors: true,
            enableForm: false,
            invalidCredentials: false,
            status: FormzStatus.pure));
      } else if (!Validators.isEmailString(event.email)) {
        emit(state.copyWith(
            email: event.email,
            emailHasErrors: true,
            enableForm: false,
            invalidCredentials: false,
            status: FormzStatus.submissionInProgress));
      } else if (!state.passwordHasErrors && state.password.isNotEmpty) {
        emit(state.copyWith(
            email: event.email,
            emailHasErrors: false,
            enableForm: true,
            invalidCredentials: false,
            status: FormzStatus.submissionInProgress));
      } else {
        emit(state.copyWith(
            email: event.email,
            emailHasErrors: false,
            enableForm: false,
            invalidCredentials: false,
            status: FormzStatus.submissionInProgress));
      }
    }
  }

  void _onPasswordChange(PasswordChange event, Emitter<SignInState> emit) {
    if (event.password != state.password) {
      if (event.password.isEmpty) {
        emit(state.copyWith(
            password: event.password,
            passwordHasErrors: true,
            invalidCredentials: false,
            enableForm: false,
            status: FormzStatus.pure));
      } else if (event.password.length < 3) {
        emit(state.copyWith(
            password: event.password,
            passwordHasErrors: true,
            invalidCredentials: false,
            enableForm: false,
            status: FormzStatus.submissionInProgress));
      } else if (!state.emailHasErrors && state.email.isNotEmpty) {
        emit(state.copyWith(
            password: event.password,
            passwordHasErrors: false,
            enableForm: true,
            invalidCredentials: false,
            status: FormzStatus.submissionInProgress));
      } else {
        emit(state.copyWith(
            password: event.password,
            passwordHasErrors: false,
            enableForm: false,
            invalidCredentials: false,
            status: FormzStatus.submissionInProgress));
      }
    }
  }

  void _onShowChangePasswordNotification(
      ShowChangePasswordNotification event, Emitter<SignInState> emit) {
    emit(state.copyWith(
        showChangePasswordNotification: event.show,
        showNotification: event.show));
  }

  void _onShowSessionEndModal(
      ShowSessionEndModal event, Emitter<SignInState> emit) {
    emit(state.copyWith(
      showSessionEndModal: event.show,
    ));
  }

  void _onChangeShowNotification(
      ChangeShowNotification event, Emitter<SignInState> emit) {
    emit(state.copyWith(showNotification: false));
  }

  void _onChangeShowEndModal(
      ChangeShowEndModal event, Emitter<SignInState> emit) {
    emit(state.copyWith(showSessionEndModal: false));
  }

  FutureOr<void> _onGetFirebaseToken(
      GetFirebaseToken event, Emitter<SignInState> emit) async {
    String? token = await FirebaseMessaging.instance.getToken();
    emit(state.copyWith(firebaseToken: token));
  }
}
