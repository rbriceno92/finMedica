import 'dart:async';

import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_event.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_state.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/book_appointment_use_case.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  final BookAppointmentUseCase useCase;

  BookAppointmentBloc({required this.useCase})
      : super(const BookAppointmentState()) {
    on<BookAppointment>(_onBookAppointment);
  }

  FutureOr<void> _onBookAppointment(
      BookAppointment event, Emitter<BookAppointmentState> emit) async {
    emit(state.copyWith(isLoading: true, bookedAppointment: false));
    final response = await useCase.call(event.params);
    response.fold(
        (l) =>
            emit(state.copyWith(errorMessage: getMessage(l), isLoading: false)),
        (r) =>
            {emit(state.copyWith(isLoading: false, bookedAppointment: true))});
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
