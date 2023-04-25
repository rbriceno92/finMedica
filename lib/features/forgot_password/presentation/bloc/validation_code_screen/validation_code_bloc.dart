import 'dart:async';

import 'package:app/features/forgot_password/presentation/bloc/validation_code_screen/validation_code_event.dart';
import 'package:app/features/forgot_password/presentation/bloc/validation_code_screen/validation_code_state.dart';
import 'package:app/util/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/send_email_model.dart';
import '../../../domain/use_cases/send_code.dart';

class ValidationCodeBloc
    extends Bloc<ValidationCodeEvent, ValidationCodeState> {
  SendCode sendCode;
  final String invalideCode = 'CODE_ERROR';

  ValidationCodeBloc({required this.sendCode})
      : super(const ValidationCodeState()) {
    on<CodeSubmitted>(onCodeSubmitted);
    on<SendingCode>(onSendingCode);
  }

  void onCodeSubmitted(CodeSubmitted event, Emitter<ValidationCodeState> emit) {
    emit(state.copyWith(
        code: event.code, codeAccepted: null, messageError: '', token: null));
  }

  FutureOr<void> onSendingCode(
      SendingCode event, Emitter<ValidationCodeState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await sendCode.call(SendEmailModel(
      email: event.email,
      code: state.code,
      validateCode: true,
    ));
    result.fold((l) {
      if (l is ServerFailure) {
        if (l.modelServer.isSimple()) {
          emit(state.copyWith(
              messageError: l.modelServer.message ?? '',
              codeAccepted:
                  l.modelServer.message == invalideCode ? false : null,
              token: null,
              loading: false));
        } else {
          emit(state.copyWith(
              messageError: l.modelServer.message?.first.message ?? '',
              codeAccepted: l.modelServer.message?.first.type == invalideCode
                  ? false
                  : null,
              token: null,
              loading: false));
        }
      }
      if (l is ErrorMessage) {
        emit(state.copyWith(
            messageError: l.message,
            codeAccepted: null,
            token: null,
            loading: false));
      }
    }, (token) {
      emit(state.copyWith(
          messageError: null,
          codeAccepted: true,
          token: token,
          loading: false));
    });
  }
}
