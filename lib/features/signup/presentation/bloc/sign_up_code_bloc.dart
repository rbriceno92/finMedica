import 'dart:async';

import 'package:app/features/signup/data/models/sign_up_code_request.dart';
import 'package:app/features/signup/domain/use_cases/sign_up_code.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_code_event.dart';
import 'package:app/features/signup/presentation/bloc/sign_up_code_state.dart';
import 'package:app/util/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:logging/logging.dart';

import '../../../../util/models/message_model.dart';
import '../../data/models/resend_code_model.dart';
import '../../domain/use_cases/resend_code.dart';

final log = Logger('sign_up_code_bloc.dart');

class SignUpCodeBloc extends Bloc<SignUpCodeEvent, SignUpCodeState> {
  SignUpCode signUpCode;
  ResendCode resendCode;
  SignUpCodeBloc({required this.signUpCode, required this.resendCode})
      : super(
          const SignUpCodeState(),
        ) {
    on<CodeChange>(onCodeChange);
    on<SendData>(onSendData);
    on<ResendCodeEvent>(onResendCode);
    on<CleanMessage>(_onCleanMessage);
  }

  FutureOr<void> onResendCode(
      ResendCodeEvent event, Emitter<SignUpCodeState> emit) async {
    var result = await resendCode.call(ResendCodeModel(userId: event.userId));
    result.fold(
      (l) {
        if (l is ServerFailure) {
          if (l.modelServer.isSimple()) {
            emit(state.copyWith(
                messageError: (l.modelServer.message as String)));
          } else {
            emit(state.copyWith(
                messageError: (l.modelServer.message as List<MessageModel>)
                    .map((e) => e.message)
                    .join(', ')));
          }
        }
        if (l is ErrorMessage) {
          emit(state.copyWith(messageError: (l.message)));
        }
      },
      (r) {
        var response = r.message;
        emit(state.copyWith(message: response['message'], loading: false));
      },
    );
  }

  void onCodeChange(CodeChange event, Emitter<SignUpCodeState> emit) {
    emit(state.copyWith(
        code: event.code,
        enableButton: event.code.isNotEmpty && event.code.length == 6,
        codeError: false));
  }

  void onSendData(SendData event, Emitter<SignUpCodeState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await signUpCode
        .call(SignUpCodeRequest(userId: event.data.userId, code: state.code));
    bool success = result.fold(
      (l) {
        if (l is ServerFailure) {
          log.info('error ${l.modelServer.message}');
        }
        if (l is ErrorMessage) {
          log.info('error ${l.message}');
        }
        return false;
      },
      (r) {
        log.info('success');
        return true;
      },
    );
    if (success) {
      event.next();
    } else {
      event.error();
      emit(state.copyWith(codeError: true));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _onCleanMessage(
      CleanMessage event, Emitter<SignUpCodeState> emit) async {
    emit(state.copyWith(messageError: '', message: ''));
  }
}
