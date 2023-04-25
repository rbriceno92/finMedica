import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:equatable/equatable.dart';

abstract class BookAppointmentEvent extends Equatable {
  const BookAppointmentEvent();
}

class BookAppointment extends BookAppointmentEvent {
  BookAppointmentParams params;
  BookAppointment({required this.params});

  @override
  List<Object?> get props => [params];
}
