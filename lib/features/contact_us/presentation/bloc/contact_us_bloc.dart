import 'dart:async';

import 'package:app/features/contact_us/data/models/contact_us_data_request.dart';
import 'package:app/features/contact_us/domain/use_case/contact_us_send_data.dart';
import 'package:app/util/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../util/constants/constants.dart';
import '../../../../util/failure.dart';
import '../../../../util/user_preferences_save.dart';
import 'contact_us_state.dart';
import 'contact_us_event.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsSendDataUseCase contactUsSendDataUseCase;
  UserPreferenceDao dao;
  ContactUsBloc({required this.contactUsSendDataUseCase, required this.dao})
      : super(const ContactUsState()) {
    on<SubjectChange>(_onSubjectChange);
    on<MessageChange>(_onMessageChange);
    on<SendData>(_onSendData);
    on<DisposeLoading>(_onDisposeLoading);
    on<ClearMesssage>(_cleanMessage);
  }

  @override
  void onTransition(Transition<ContactUsEvent, ContactUsState> transition) {
    super.onTransition(transition);
  }

  void _onSubjectChange(SubjectChange event, Emitter<ContactUsState> emit) {
    emit(state.copyWith(
        subject: event.text, subjectHasError: event.text.length > 70));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onMessageChange(MessageChange event, Emitter<ContactUsState> emit) {
    emit(state.copyWith(
        message: event.text, messageHasError: event.text.length > 500));

    emit(state.copyWith(enableContinue: _checkFormReady()));
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<ContactUsState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onSendData(SendData event, Emitter<ContactUsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var userResponse = await dao.getUser();
    return userResponse.fold(
      (l) {},
      (modelUser) async {
        var result = await contactUsSendDataUseCase.call(ContactUsDataRequest(
            title: state.subject, body: state.message, email: modelUser.email));
        result.fold((l) {
          var message = getMessage(l);
          emit(state.copyWith(
              loading: LoadingState.close, messageError: message));
        }, (r) {
          emit(state.copyWith(
            messageSucces: r['Message'],
            loading: LoadingState.close,
            message: '',
            subject: '',
          ));
        });
      },
    );
  }

  bool _checkFormReady() {
    return state.subject.isNotEmpty && state.message.isNotEmpty;
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple() && l.modelServer.message != '') {
        return l.modelServer.message ?? '';
      } else if (l.modelServer.message != '' &&
          l.modelServer.message?.first != null) {
        return l.modelServer.message?.first.message ?? '';
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }

    return ERROR_MESSAGE;
  }

  FutureOr<void> _cleanMessage(
      ClearMesssage event, Emitter<ContactUsState> emit) async {
    emit(state.copyWith(messageError: '', messageSucces: ''));
  }
}
