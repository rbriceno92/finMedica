import 'dart:async';

import 'package:app/features/dashboard/domain/use_cases/get_next_consults.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:app/features/my_consults/domain/use_cases/doctor_photo_use_case.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_fetch_data.dart';
import 'package:app/features/payments/domain/use_cases/get_payment_config_use_case.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../util/constants/constants.dart';
import '../../../../util/user_preferences_save.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  GetNextConsults nextConsults;
  UserPreferenceDao preferenceDao;
  GetPaymentConfigUseCase paymentConfigUseCase;
  MyGroupsFetchDataUseCase myGroupsFetchDataUseCase;
  DoctorPhotoUseCase doctorPhotoUseCase;

  DashboardBloc({
    required this.nextConsults,
    required this.preferenceDao,
    required this.paymentConfigUseCase,
    required this.myGroupsFetchDataUseCase,
    required this.doctorPhotoUseCase,
  }) : super(const DashboardState()) {
    on<GettingNextConsults>(_onGettingNextConsults);
    on<GetUserName>(_getUserName);
    on<GetStripeConfig>(_onGetStripeConfig);
    on<SetRefresh>(_onSetRefresh);
    on<DisposeLoading>(_onDisposeLoading);
    on<GetMyGroupInfo>(_onGetMyGroupInfo);
    on<GetFirebaseToken>(_onGetFirebaseToken);
  }

  FutureOr<void> _onGettingNextConsults(
      GettingNextConsults event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: !state.refresh, refresh: false));

    var response = await nextConsults.call(event.states);
    var list = await response.fold((l) async {
      var message = getMessage(l);
      emit(state.copyWith(
          isLoading: false, errorMessage: message, consult: null));
      return null;
    }, (r) async {
      int index = 0;
      return await Future.wait(r.map((e) async {
        var consult = e.toEntity();
        if (index < 2) {
          var resultPhoto =
              await doctorPhotoUseCase.call(consult.doctor?.personaId ?? 0);
          consult.doctor?.photo = resultPhoto.fold((l) => null, (r) => r.photo);
        }
        index += 1;
        return consult;
      }).toList());
    });
    emit(state.copyWith(isLoading: false, errorMessage: null, consult: list));
  }

  FutureOr<void> _onGetStripeConfig(
      GetStripeConfig event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    var user = await preferenceDao.getUser();
    String data = user.fold((l) => getMessage(l), (r) => r.email ?? '');
    if (!data.contains('@')) {
      emit(state.copyWith(isLoading: false, errorMessage: data, consult: null));
      return;
    }

    var responsePC = await paymentConfigUseCase.call(data);
    data = responsePC.fold((l) {
      return getMessage(l);
    }, (r) {
      Stripe.publishableKey = r.publishableKey ?? '';
      Stripe.instance.applySettings();
      return '';
    });

    if (data.isNotEmpty) {
      emit(state.copyWith(isLoading: false, errorMessage: data, consult: null));
      return;
    }
  }

  FutureOr<void> _getUserName(
      GetUserName event, Emitter<DashboardState> emit) async {
    var user = await preferenceDao.getUser();
    print(user);
    user.fold((l) => {emit(state.copyWith(name: 'user'))},
        (r) => {emit(state.copyWith(name: r.firstName))});
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

  FutureOr<void> _onSetRefresh(SetRefresh event, Emitter<DashboardState> emit) {
    emit(state.copyWith(refresh: event.refresh));
  }

  FutureOr<void> _onDisposeLoading(
      DisposeLoading event, Emitter<DashboardState> emit) {
    emit(DashboardState(
        consult: state.consult,
        errorMessage: '',
        isAdmin: null,
        isLoading: state.isLoading,
        loading2: LoadingState.dispose,
        name: state.name,
        refresh: state.refresh,
        states: state.states));
  }

  void _onGetMyGroupInfo(
      GetMyGroupInfo event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(loading2: LoadingState.show));
    var result = await myGroupsFetchDataUseCase.call(ParametroVacio());

    try {
      List<String> status = result.fold((l) {
        if (l is ServerFailure &&
            !l.modelServer.isSimple() &&
            (l.modelServer.message.first as MessageModel).type ==
                'GROUP_ERROR') {
          return ['', ''];
        } else {
          return ['error', getMessage(l)];
        }
      }, (r) {
        return ['', r.isAdmin ? '1' : ''];
      });

      if (status.first.isNotEmpty) {
        emit(state.copyWith(
            loading2: LoadingState.close, errorMessage: status.last));
      } else {
        emit(state.copyWith(
            loading2: LoadingState.close,
            errorMessage: '',
            isAdmin: status.last.isNotEmpty));
      }
    } catch (e) {
      emit(state.copyWith(
          loading2: LoadingState.close, errorMessage: ERROR_MESSAGE));
    }
  }

  FutureOr<void> _onGetFirebaseToken(
      GetFirebaseToken event, Emitter<DashboardState> emit) async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    String? token = await FirebaseMessaging.instance.getToken();
    emit(state.copyWith(
        token: token, link: initialLink?.link.queryParameters['member_id']));
  }
}
