import 'dart:async';

import 'package:app/features/forgot_password/presentation/bloc/forgot_password_screen/forgot_password_event.dart';
import 'package:app/features/forgot_password/presentation/bloc/forgot_password_screen/forgot_password_state.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/send_email.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  SendEmail sendEmail;

  ForgotPasswordBloc({required this.sendEmail})
      : super(const ForgotPasswordState()) {
    on<EmailChange>(_onEmailChange);
    on<SendingEmail>(_onSendingEmail);
  }

  void _onEmailChange(EmailChange event, Emitter<ForgotPasswordState> emit) {
    if (!Validators.isEmailString(event.email)) {
      emit(state.copyWith(
          email: event.email,
          formatEmailInvalid: false,
          messageError: null,
          emailInvalid: false,
          emailAlreadySended: false));
    } else {
      emit(state.copyWith(
          email: event.email,
          formatEmailInvalid: true,
          messageError: null,
          emailInvalid: false,
          emailAlreadySended: false));
    }
  }

  FutureOr<void> _onSendingEmail(
      SendingEmail event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await sendEmail.call(event.email);
    result.fold((l) {
      if (l is ServerFailure) {
        if (l.modelServer.isSimple()) {
          emit(state.copyWith(
              emailInvalid: true,
              messageError: l.modelServer.message,
              loading: false));
        } else {
          emit(state.copyWith(
              emailInvalid: true,
              messageError: l.modelServer.message?.first.message,
              loading: false));
        }
      }
      if (l is ErrorMessage) {
        emit(state.copyWith(
            messageError: l.message, emailInvalid: true, loading: false));
      }
    }, (r) {
      emit(state.copyWith(
          emailAlreadySended: true,
          messageError: '',
          emailInvalid: false,
          email: event.email,
          name: r.user.firstName,
          loading: false));
    });
  }
}
