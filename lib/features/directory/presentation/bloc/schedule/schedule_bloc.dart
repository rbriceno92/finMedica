import 'dart:async';

import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:app/features/directory/data/models/schedule_doctor_param.dart';
import 'package:app/features/directory/presentation/bloc/schedule/schedule_event.dart';
import 'package:app/features/directory/presentation/bloc/schedule/schedule_state.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/format_date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../profile/domain/use_cases/get_user_info.dart';
import '../../../domain/entities/hours_date_appointment.dart';
import '../../../domain/use_cases/get_schedule_doctor.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetScheduleUseCase useCase;
  final GetUserInfo userInfo;
  ScheduleBloc({required this.useCase, required this.userInfo})
      : super(ScheduleState()) {
    on<SetDate>(_onSetDate);
    on<SetHour>(_onSetHour);
    on<GetSchedule>(_onGetSchedule);
    on<LoadUser>(_onLoadUser);
  }

  FutureOr<void> _onLoadUser(
      LoadUser event, Emitter<ScheduleState> emit) async {
    var user = await userInfo.repository.getUserInfo();
    user.fold((l) => null, (r) => emit(state.copyWith(user: r)));
  }

  FutureOr<void> _onSetDate(SetDate event, Emitter<ScheduleState> emit) {
    final list = getHourByDate(event.date.dateFormatCalendar(), state.schedule);
    list.first.selected = true;
    emit(state.copyWith(date: event.date, listTimes: list, hour: ''));
  }

  FutureOr<void> _onSetHour(SetHour event, Emitter<ScheduleState> emit) {
    if (event.hour.isEmpty) {
      emit(state.copyWith(hour: ''));
    } else {
      final listDate = event.hour.split(':');
      final hourDate = DateTime(
          state.date?.year ?? 0,
          state.date?.month ?? 1,
          state.date?.day ?? 1,
          int.parse(listDate.first),
          int.parse(listDate[1]));
      emit(state.copyWith(hour: event.hour, date: hourDate, time: event.time));
    }
  }

  FutureOr<void> _onGetSchedule(
      GetSchedule event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(isLoading: true));
    final startDate = DateTime.now();
    final endDate =
        DateTime(startDate.year, startDate.month + 1, startDate.day);
    ScheduleDoctorParam param = ScheduleDoctorParam(
        professional_id: event.doctor,
        date: startDate.dateFormatCalendar(),
        endDate: endDate.dateFormatCalendar());
    var scheduleDoctor = await useCase.call(param);
    scheduleDoctor.fold(
        (l) => {emit(state.copyWith(isLoading: false, message: getMessage(l)))},
        (r) {
      final listHours = getHourByDate(r.earliestDate.date, r);
      listHours.first.selected = true;
      final timeObject = Time(
          time: r.earliestDate.time,
          type: r.earliestDate.type,
          orden: r.earliestDate.orden,
          schedule: r.earliestDate.agenda,
          speciality: r.earliestDate.speciality);
      emit(state.copyWith(
        schedule: r,
        hour: r.earliestDate.time,
        date: DateTime.parse(r.earliestDate.date),
        time: timeObject,
        listTimes: listHours,
      ));
    });
  }

  List<HourDateAppointment> getHourByDate(
      String? date, ScheduleDoctor? schedule) {
    final dateSelected =
        schedule?.availableDates.firstWhere((element) => element.date == date);
    List<HourDateAppointment> list = dateSelected?.times
            .map((element) => HourDateAppointment(
                hour: element.time,
                available: true,
                selected: false,
                time: element))
            .toList() ??
        [];
    return list;
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
