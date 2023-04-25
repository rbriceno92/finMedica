import 'package:app/features/my_coupons/data/models/coupon_detail_request.dart';
import 'package:app/features/my_coupons/data/models/coupon_detail_response.dart';
import 'package:app/features/my_coupons/domain/use_cases/get_coupon_detail_use_case.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_coupons_detail_events.dart';
import 'my_coupons_detail_state.dart';

class MyCouponsDetailBloc
    extends Bloc<MyCouponsDetailEvent, MyCouponsDetailState> {
  GetCouponDetailUseCase getCouponDetailUseCase;
  UserPreferenceDao userDao;

  MyCouponsDetailBloc({
    required this.getCouponDetailUseCase,
    required this.userDao,
  }) : super(const MyCouponsDetailState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<FetchData>(_onFetchData);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<MyCouponsDetailState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose, errorMessage: ''));

  Future<void> _onFetchData(
      FetchData event, Emitter<MyCouponsDetailState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    try {
      var userDaoResult = await userDao.getUser();
      var user = userDaoResult.fold((error) => null, (user) => user);

      if (user == null) {
        emit(state.copyWith(
            loading: LoadingState.close, errorMessage: USER_NOT_FOUND));
        return;
      }

      var responseDetail =
          await getCouponDetailUseCase.call(CouponDetailRequest(
        userId: user.userId ?? '',
        couponId: event.couponId,
        type: event.couponType.name,
      ));

      var result = responseDetail.fold(
          (error) => ['error', getMessage(error)], (data) => ['', data]);

      if ((result.first as String).isNotEmpty) {
        emit(state.copyWith(
            loading: LoadingState.close, errorMessage: result.last as String));
        return;
      }

      emit(state.copyWith(
        coupon: (result.last as CouponDetailResponse)
            .couponConsultDetail
            .toEntity(),
        loading: LoadingState.close,
      ));
    } catch (e) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: ERROR_MESSAGE));
    }
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
