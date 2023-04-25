import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:equatable/equatable.dart';

abstract class MyConsultDetailEvent extends Equatable {
  const MyConsultDetailEvent();
}

class MakeConsultPrivate extends MyConsultDetailEvent {
  @override
  List<Object?> get props => [];
}

class AcceptConsultTerms extends MyConsultDetailEvent {
  @override
  List<Object?> get props => [];
}

class AddConsult extends MyConsultDetailEvent {
  final Consult consult;
  const AddConsult(this.consult);

  @override
  List<Object?> get props => [];
}

class FetchConsultDetail extends MyConsultDetailEvent {
  @override
  List<Object?> get props => [];
}

class DisposeLoading extends MyConsultDetailEvent {
  @override
  List<Object?> get props => [];
}

class CancelOfConsult extends MyConsultDetailEvent {
  const CancelOfConsult();

  @override
  List<Object?> get props => [];
}

class LoadUser extends MyConsultDetailEvent {
  @override
  List<Object?> get props => [];
}

class RescheduleAppointmentEvent extends MyConsultDetailEvent {
  @override
  List<Object?> get props => [];
}

class OnGetRemainingConsults extends MyConsultDetailEvent {
  const OnGetRemainingConsults();

  @override
  List<Object?> get props => [];
}
