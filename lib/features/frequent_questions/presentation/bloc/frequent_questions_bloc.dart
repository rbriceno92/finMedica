import 'dart:async';

import 'package:app/util/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/failure.dart';
import '../../../../util/use_case.dart';
import '../../domain/use_case/get_frequent_questions.dart';
import 'frequent_questions_event.dart';
import 'frequent_questions_state.dart';

class FrequentQuestionsBloc
    extends Bloc<FrequentQuestionsEvent, FrequentQuestionsState> {
  FrequentQuestionsUseCase frequentQuestionsUseCase;
  FrequentQuestionsBloc({required this.frequentQuestionsUseCase})
      : super(const FrequentQuestionsState()) {
    on<DonwloadFrequentQuestions>(_onDonwloadFrequentQuestions);
  }

  FutureOr<void> _onDonwloadFrequentQuestions(DonwloadFrequentQuestions event,
      Emitter<FrequentQuestionsState> emit) async {
    emit(state.copyWith(loading: true));
    var result = await frequentQuestionsUseCase.call(ParametroVacio());
    result.fold(
      (l) {
        emit(state.copyWith(
          loading: false,
          errorMessage: getMessage(l),
        ));
      },
      (r) {
        var data = r.result;
        emit(state.copyWith(
            loading: false, frequentQuestions: data, errorMessage: ''));
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
