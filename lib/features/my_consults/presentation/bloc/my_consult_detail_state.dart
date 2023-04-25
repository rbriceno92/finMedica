import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../../util/models/model_user.dart';

enum GoTo { none, successScreen, choosePayScreen }

class MyConsultDetailState extends Equatable {
  final LoadingState loading;
  final bool acceptConditions;
  final bool isPrivate;
  final Consult consult;
  final ModelUser? user;
  final String? message;
  final bool rescheduledAppointment;
  final GoTo goTo;

  const MyConsultDetailState(
      {this.acceptConditions = false,
      this.isPrivate = false,
      this.loading = LoadingState.dispose,
      this.user,
      this.message = '',
      this.rescheduledAppointment = false,
      this.consult =
          const Consult(date: '', private: false, type: ConsultType.SCHEDULE),
      this.goTo = GoTo.none});

  @override
  List<Object?> get props => [
        acceptConditions,
        isPrivate,
        loading,
        consult,
        user,
        message,
        rescheduledAppointment,
        goTo,
      ];

  MyConsultDetailState copyWith(
      {bool? acceptConditions,
      bool? isPrivate,
      LoadingState? loading,
      ModelUser? user,
      Consult? consult,
      String? message,
      bool? rescheduledAppointment,
      GoTo? goTo}) {
    return MyConsultDetailState(
        acceptConditions: acceptConditions ?? this.acceptConditions,
        isPrivate: isPrivate ?? this.isPrivate,
        loading: loading ?? this.loading,
        user: user ?? this.user,
        message: message ?? this.message,
        consult: consult ?? this.consult,
        rescheduledAppointment:
            rescheduledAppointment ?? this.rescheduledAppointment,
        goTo: goTo ?? this.goTo);
  }
}
