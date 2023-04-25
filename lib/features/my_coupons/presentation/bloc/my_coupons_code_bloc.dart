import 'package:app/features/my_coupons/domain/use_cases/my_coupons_code.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/constants/constants.dart';
import '../../../../util/failure.dart';
import 'my_coupons_code_events.dart';
import 'my_coupons_code_state.dart';

class MyCouponsCodeBloc extends Bloc<MyCouponsCodeEvent, MyCouponsCodeState> {
  MyCouponsCodeUseCase myCouponsCodeUseCase;
  MyCouponsCodeBloc({required this.myCouponsCodeUseCase})
      : super(const MyCouponsCodeState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<CodeChange>(_onCodeChange);
    on<SendCode>(_onSendCode);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<MyCouponsCodeState> emit) async =>
      emit(state.copyWith(
          loading: LoadingState.dispose, messageError: '', messageSuccess: ''));

  void _onCodeChange(CodeChange event, Emitter<MyCouponsCodeState> emit) async {
    emit(state.copyWith(
        code: event.code,
        enableButtom: !Validators.emptyString(event.code) &&
            event.code.length == 6 &&
            !state.codeError,
        codeError: false));
  }

  void _onSendCode(SendCode event, Emitter<MyCouponsCodeState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var result = await myCouponsCodeUseCase.call(int.parse(state.code));
    result.fold(
      (l) {
        var message = getMessage(l);
        emit(state.copyWith(
            loading: LoadingState.close,
            codeError: true,
            messageError: message));
      },
      (r) {
        emit(state.copyWith(
            messageSuccess: r.message,
            loading: LoadingState.close,
            code: '',
            enableButtom: false,
            codeError: false));
      },
    );
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple()) {
        return l.modelServer.message ?? '';
      } else {
        return l.modelServer.message?.first.message ?? '';
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }
    return ERROR_MESSAGE;
  }
}
