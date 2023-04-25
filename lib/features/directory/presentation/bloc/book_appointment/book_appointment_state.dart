import 'package:equatable/equatable.dart';

class BookAppointmentState extends Equatable {
  final bool isLoading;
  final bool bookedAppointment;
  final int consultsAvailable;
  final String errorMessage;

  const BookAppointmentState(
      {this.isLoading = false,
      this.bookedAppointment = false,
      this.consultsAvailable = 0,
      this.errorMessage = ''});

  @override
  List<Object?> get props =>
      [isLoading, bookedAppointment, consultsAvailable, errorMessage];

  BookAppointmentState copyWith(
      {bool? isLoading,
      bool? bookedAppointment,
      int? consultsAvailable,
      String? errorMessage}) {
    return BookAppointmentState(
        isLoading: isLoading ?? this.isLoading,
        bookedAppointment: bookedAppointment ?? this.bookedAppointment,
        consultsAvailable: consultsAvailable ?? this.consultsAvailable,
        errorMessage: errorMessage ?? '');
  }
}
