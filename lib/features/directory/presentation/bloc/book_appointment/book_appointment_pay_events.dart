import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:equatable/equatable.dart';

abstract class BookAppointmentPayEvent extends Equatable {
  const BookAppointmentPayEvent();
}

class DisposeLoading extends BookAppointmentPayEvent {
  @override
  List<Object?> get props => [];
}

class FetchProducts extends BookAppointmentPayEvent {
  const FetchProducts();

  @override
  List<Object?> get props => [];
}

class PayItem extends BookAppointmentPayEvent {
  final BookAppointmentParams params;
  const PayItem({required this.params});

  @override
  List<Object?> get props => [];
}
