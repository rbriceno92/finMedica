import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:equatable/equatable.dart';

class ChoosePaymentMethodScreenParam extends Equatable {
  final Time time;
  final String date;
  final int person_id;

  ChoosePaymentMethodScreenParam(
      {required this.time, required this.date, required this.person_id});

  @override
  List<Object?> get props => [time, date, person_id];
}
