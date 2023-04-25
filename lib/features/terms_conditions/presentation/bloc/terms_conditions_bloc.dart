import 'package:app/features/signup/domain/use_cases/sign_up.dart';
import 'package:app/features/terms_conditions/domain/use_cases/terms_conditions_use_case.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'terms_conditions_state.dart';
import 'terms_conditions_event.dart';

class TermsConditionsBloc
    extends Bloc<TermsConditionsEvent, TermsConditionsState> {
  TermsConditionsUseCase termsConditionsUseCase;
  SignUp signUpUseCase;

  TermsConditionsBloc(
      {required this.termsConditionsUseCase, required this.signUpUseCase})
      : super(const TermsConditionsState()) {
    on<DonwloadTerms>(_onDonwloadTerms);
    on<AcceptedTermsChange>(_onAcceptedTermsChange);
    on<DisposeLoading>(_onDisposeLoading);
    on<SendSignUpData>(_onSendSignUpData);
  }

  @override
  void onTransition(
      Transition<TermsConditionsEvent, TermsConditionsState> transition) {
    super.onTransition(transition);
  }

  void _onDonwloadTerms(
      DonwloadTerms event, Emitter<TermsConditionsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var result = await termsConditionsUseCase.call(ParametroVacio());

    result.fold(
      (l) {
        emit(state.copyWith(
            terms: '', loading: LoadingState.close, error: getMessage(l)));
      },
      (r) {
        emit(state.copyWith(
            terms: r.message, loading: LoadingState.close, error: ''));
      },
    );
  }

  void _onAcceptedTermsChange(AcceptedTermsChange event,
          Emitter<TermsConditionsState> emit) async =>
      emit(state.copyWith(acceptedTerms: event.acceptedTerms));

  void _onDisposeLoading(
          DisposeLoading event, Emitter<TermsConditionsState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onSendSignUpData(
      SendSignUpData event, Emitter<TermsConditionsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    try {
      var result = await signUpUseCase.call(event.data);

      bool success = false;
      String userId = '';
      String error = '';

      result.fold(
        (l) {
          if (l is ServerFailure) {
            if (l.modelServer.isSimple()) {
              error = l.modelServer.message;
            } else {
              if (l.modelServer.message!.first.message ==
                  'USER_CREATION_ERROR') {
                error = 'Error al crear al usuario';
              } else {
                error = l.modelServer.message!.map((e) => e.message).join(', ');
              }
              error = l.modelServer.message!.map((e) => e.message).join(', ');
            }
          }
          if (l is ErrorMessage) {
            error = l.message;
          }
        },
        (r) {
          success = true;
          userId = r.user?.userId ?? '';
        },
      );

      if (success) {
        event.next(userId);
      } else {
        event.error(error);
      }
    } catch (e) {
      event.error(e.toString());
    }

    emit(state.copyWith(loading: LoadingState.close));
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
