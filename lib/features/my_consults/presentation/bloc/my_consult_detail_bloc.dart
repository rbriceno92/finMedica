import 'dart:async';

import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/directory/data/models/book_appointment_response.dart';
import 'package:app/features/directory/data/models/discounts_consult_param.dart';
import 'package:app/features/directory/domain/use_cases/book_appointment_use_case.dart';
import 'package:app/features/directory/domain/use_cases/discount_consult_use_case.dart';
import 'package:app/features/my_consults/data/models/reschedule_appointment_param.dart';
import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/domain/use_cases/consult_detail_use_case.dart';
import 'package:app/features/my_consults/domain/use_cases/doctor_photo_use_case.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_state.dart';
import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/domain/use_cases/get_coupons_available.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/format_date.dart';
import 'package:app/util/models/model_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/cancel_consult.dart';

import '../../../profile/domain/use_cases/get_user_info.dart';
import '../../domain/use_cases/reschedule_appointment_use_case.dart';
import 'my_consult_detail_event.dart';

class MyConsultDetailBloc
    extends Bloc<MyConsultDetailEvent, MyConsultDetailState> {
  final ConsultDetailUseCase consultDetailUseCase;
  final CancelConsultUseCase cancelConsultUseCase;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;
  final GetUserInfo userInfo;
  final GetCouponsAvailableUseCase getCouponsAvailableUseCase;
  final BookAppointmentUseCase bookAppointmentUseCase;
  final DiscountConsultUseCase discountConsultUseCase;
  final DoctorPhotoUseCase doctorPhotoUseCase;

  MyConsultDetailBloc({
    required this.consultDetailUseCase,
    required this.cancelConsultUseCase,
    required this.userInfo,
    required this.rescheduleAppointmentUseCase,
    required this.getCouponsAvailableUseCase,
    required this.bookAppointmentUseCase,
    required this.discountConsultUseCase,
    required this.doctorPhotoUseCase,
  }) : super(const MyConsultDetailState()) {
    on<MakeConsultPrivate>(setPrivateConsult);
    on<AcceptConsultTerms>(setAcceptConsultTerms);
    on<AddConsult>(_onAddConsult);
    on<FetchConsultDetail>(_onFetchConsultDetail);
    on<DisposeLoading>(_onDisposeLoading);
    on<CancelOfConsult>(_onCancelOfConsult);
    on<LoadUser>(_onLoadUser);
    on<RescheduleAppointmentEvent>(_onRescheduleAppointmentEvent);
    on<OnGetRemainingConsults>(onGetRemainingConsults);
  }

  FutureOr<void> setPrivateConsult(
      MakeConsultPrivate event, Emitter<MyConsultDetailState> emit) {
    emit(state.copyWith(isPrivate: !state.isPrivate));
  }

  FutureOr<void> setAcceptConsultTerms(
      AcceptConsultTerms event, Emitter<MyConsultDetailState> emit) {
    emit(state.copyWith(acceptConditions: !state.acceptConditions));
  }

  void _onAddConsult(AddConsult event, Emitter<MyConsultDetailState> emit) {
    emit(state.copyWith(consult: event.consult));
  }

  FutureOr<void> _onFetchConsultDetail(
      FetchConsultDetail event, Emitter<MyConsultDetailState> emit) async {
    if (state.consult.type == ConsultType.SCHEDULING) {
      emit(state.copyWith(rescheduledAppointment: false));
      return;
    }

    emit(state.copyWith(
        loading: LoadingState.show, rescheduledAppointment: false));

    var result = await consultDetailUseCase.call(state.consult.consultId ?? 0);
    List<Object?> status1 = result.fold(
      (l) {
        return ['error', getMessage(l)];
      },
      (r) {
        return [null, r.toEntity()];
      },
    );

    if (status1.first != null) {
      emit(state.copyWith(
          loading: LoadingState.close, message: status1.last as String));
      return;
    }

    var detail = (status1.last as Consult);
    var resultPhoto =
        await doctorPhotoUseCase.call(detail.doctor?.personaId ?? 0);

    detail.doctor?.photo = resultPhoto.fold((l) => null, (r) => r.photo);
    emit(state.copyWith(loading: LoadingState.close, consult: detail));
  }

  void _onDisposeLoading(
      DisposeLoading event, Emitter<MyConsultDetailState> emit) {
    emit(state.copyWith(loading: LoadingState.dispose));
  }

  FutureOr<void> _onCancelOfConsult(
      CancelOfConsult event, Emitter<MyConsultDetailState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var result = await cancelConsultUseCase.call(state.consult.consultId ?? 0);
    result.fold(
      (l) {
        emit(state.copyWith(
            loading: LoadingState.close, message: getMessage(l)));
      },
      (r) {
        emit(state.copyWith(loading: LoadingState.close));
      },
    );
  }

  FutureOr<void> _onLoadUser(
      LoadUser event, Emitter<MyConsultDetailState> emit) async {
    var user = await userInfo.repository.getUserInfo();
    user.fold((l) => null, (r) {
      emit(state.copyWith(user: r));
    });
  }

  FutureOr<void> _onRescheduleAppointmentEvent(RescheduleAppointmentEvent event,
      Emitter<MyConsultDetailState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    final date = state.consult.date.dateFormatCalendar();
    final hour = state.consult.date.getHour();
    var response = await rescheduleAppointmentUseCase.call(
        RescheduleAppointmentParam(
            consultId: state.consult.consultId ?? 1,
            newDate: date,
            newTime: hour));

    await response.fold((l) async {
      emit(state.copyWith(loading: LoadingState.close));
    }, (r) async {
      emit(state.copyWith(
          loading: LoadingState.close, rescheduledAppointment: true));
    });
  }

  FutureOr<void> onGetRemainingConsults(
      OnGetRemainingConsults event, Emitter<MyConsultDetailState> emit) async {
    emit(state.copyWith(loading: LoadingState.show, goTo: GoTo.none));

    var userId = await userInfo.call(null);
    var user = userId.fold((l) => getMessage(l), (r) => r);

    if (user is String) {
      emit(state.copyWith(message: user, loading: LoadingState.close));
      return;
    }
    final responseCoupons = await getCouponsAvailableUseCase.call(
        RemainingCouponsRequest(
            limit: 0,
            page: 1,
            type: '',
            userId: (user as ModelUser).userId ?? ''));
    List results = responseCoupons.fold((l) => ['error', getMessage(l)],
        (remainingConsults) => ['', remainingConsults.totalAvailableConsults]);
    if ((results.first as String).isNotEmpty) {
      emit(state.copyWith(
          loading: LoadingState.close,
          message: results.last as String,
          goTo: GoTo.none));
      return;
    }

    if ((results.last as int) == 0) {
      emit(state.copyWith(
          loading: LoadingState.close,
          message: '',
          goTo: GoTo.choosePayScreen));
      return;
    }
    final params = BookAppointmentParams(
      type: state.consult.timeConsult?.type ?? '',
      time: state.consult.timeConsult?.time ?? '',
      date: state.consult.date.dateFormatCalendar(),
      orden: state.consult.timeConsult?.orden ?? 0,
      agendaId: state.consult.timeConsult?.schedule ?? 1,
      personaId: state.consult.patient?.personId ?? 1,
      specialityId: state.consult.doctor?.professionalId ?? 1,
      privacy: state.isPrivate,
    );

    final responseBookA = await bookAppointmentUseCase.call(params);
    results =
        responseBookA.fold((l) => ['error', getMessage(l)], (r) => ['', r]);

    if ((results.first as String).isNotEmpty) {
      emit(state.copyWith(
          loading: LoadingState.close,
          message: results.last as String,
          goTo: GoTo.none));
      return;
    }

    final responseDiscount = await discountConsultUseCase.call(
        DiscountsConsultParam(
            userId: user.userId ?? '',
            consultAlephooId: (results.last as BookAppointmentResponse)
                .alephooResponse
                .data
                .id));
    results =
        responseDiscount.fold((l) => ['error', getMessage(l)], (r) => ['', r]);
    if ((results.first as String).isNotEmpty) {
      emit(state.copyWith(
          loading: LoadingState.close,
          message: results.last as String,
          goTo: GoTo.none));
      return;
    }

    emit(state.copyWith(
        loading: LoadingState.close, message: '', goTo: GoTo.successScreen));
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
