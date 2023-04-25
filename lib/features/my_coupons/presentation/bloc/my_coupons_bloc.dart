import 'package:app/features/my_coupons/data/models/coupon_detail_request.dart';
import 'package:app/features/my_coupons/data/models/coupon_detail_response.dart';
import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/data/models/remaining_consults_response.dart';
import 'package:app/features/my_coupons/data/models/transfer_coupon_request.dart';
import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/features/my_coupons/domain/use_cases/get_coupon_detail_use_case.dart';
import 'package:app/features/my_coupons/domain/use_cases/get_coupons_available.dart';
import 'package:app/features/my_coupons/domain/use_cases/transfer_coupons_use_case.dart';
import 'package:app/features/my_groups/data/models/my_groups_fetch_data_response.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_admin.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_fetch_data.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_list.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './my_coupons_events.dart';
import './my_coupons_state.dart';

class MyCouponsBloc extends Bloc<MyCouponsEvent, MyCouponsState> {
  GetCouponsAvailableUseCase getCouponsAvailableUseCase;
  MyGroupsFetchDataUseCase myGroupsFetchDataUseCase;
  MyGroupsListUseCase myGroupsListUseCase;
  UserPreferenceDao userDao;
  TransferCouponUseCase transferCouponUseCase;
  GetCouponDetailUseCase getCouponDetailUseCase;

  MyCouponsBloc({
    required this.getCouponsAvailableUseCase,
    required this.userDao,
    required this.myGroupsFetchDataUseCase,
    required this.myGroupsListUseCase,
    required this.transferCouponUseCase,
    required this.getCouponDetailUseCase,
  }) : super(const MyCouponsState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<FilterBy>(_onFilterBy);
    on<FetchData>(_onFetchData);
    on<InitialLoad>(_onInitialLoad);
    on<TransferCoupon>(_onTransferCoupon);
    on<FetchDetail>(_onFetchDetail);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<MyCouponsState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose, errorMessage: ''));

  Future<void> _onFilterBy(FilterBy event, Emitter<MyCouponsState> emit) async {
    // use binary operation to represent is select a chip or not
    var newFilter = state.filterSelect ^ event.filter.value;
    newFilter = event.filter.value == 0 || newFilter == 0 || newFilter == 0x1F
        ? 0
        : newFilter;

    emit(state.copyWith(
      filterSelect: newFilter,
    ));

    await _onFetchData(const FetchData(page: 1), emit);
  }

  void _onInitialLoad(InitialLoad event, Emitter<MyCouponsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    try {
      var userDaoResult = await userDao.getUser();
      var user = userDaoResult.fold((error) => null, (user) => user);

      if (user == null) {
        emit(state.copyWith(
            loading: LoadingState.close, errorMessage: USER_NOT_FOUND));
        return;
      }
      emit(state.copyWith(user: user));

      var responseMyGroupInfo =
          await myGroupsFetchDataUseCase.call(ParametroVacio());

      var groupInfo =
          responseMyGroupInfo.fold((error) => null, (data) => data.toEntity());
      MyGroupsAdmin? admin;
      if (groupInfo != null) {
        var responseMyGroupList =
            await myGroupsListUseCase.call(groupInfo.idAdmin);
        var result = responseMyGroupList.fold(
            (l) => ['error', getMessage(l)], (data) => ['', data]);
        if ((result.first as String).isNotEmpty) {
          emit(state.copyWith(
              loading: LoadingState.close,
              errorMessage: result.last as String));
          return;
        }
        admin =
            (result.last as MyGroupsFetchDataResponse).administrator.toEntity();
      }

      emit(state.copyWith(
        groupsInfo: groupInfo,
        admin: admin,
      ));

      await _onFetchData(const FetchData(page: 1), emit);
    } catch (e) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: ERROR_MESSAGE));
    }
  }

  Future<void> _onFetchData(
      FetchData event, Emitter<MyCouponsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    try {
      var user = state.user!;

      String type = FilterSelect.values
          .fold(
              '',
              (prev, filter) => state.filterSelect & filter.value > 0
                  ? '$prev ${filter.name}'
                  : prev)
          .trim()
          .replaceAll(' ', ',');
      var responseGetAvailable = await getCouponsAvailableUseCase.call(
          RemainingCouponsRequest(
              userId: user.userId ?? '',
              limit: event.limit,
              page: event.page,
              type: type.trim()));

      var resultGetAvailable = responseGetAvailable.fold(
          (error) => ['error', getMessage(error)], (data) => ['', data]);

      if ((resultGetAvailable.first as String).isNotEmpty) {
        emit(state.copyWith(
            loading: LoadingState.close,
            errorMessage: resultGetAvailable.last as String));
        return;
      }

      var temList = (resultGetAvailable.last as RemainingConsults)
          .activeUserPackage
          .map((e) => e.toEntity())
          .toList();

      emit(state.copyWith(
        coupons: event.page == 1 ? temList : [...state.coupons, ...temList],
        availableConsults: (resultGetAvailable.last as RemainingConsults)
            .totalAvailableConsults,
        totalPages: (resultGetAvailable.last as RemainingConsults).totalPages,
        loading: LoadingState.close,
      ));
    } catch (e) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: ERROR_MESSAGE));
    }
  }

  Future<void> _onTransferCoupon(
      TransferCoupon event, Emitter<MyCouponsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    try {
      var response = await transferCouponUseCase.call(TransferCouponRequest(
        userId: event.member?.userId ?? '',
      ));

      var result = response.fold(
          (error) => ['error', getMessage(error)], (data) => ['', data]);

      if ((result.first as String).isNotEmpty) {
        emit(state.copyWith(
            loading: LoadingState.close, errorMessage: result.last as String));
        return;
      }

      await _onFilterBy(const FilterBy(FilterSelect.all), emit);

      event.onSucces(Coupon(
          id: '',
          type: CouponType.transfer,
          quantity: 1,
          quantityAvailable: 1,
          purchaseDate: DateTime.now().toIso8601String(),
          amount: 0,
          creditCard: '',
          couponCode: '',
          transferredBy: '',
          transferredTo: state.groupsInfo!.isAdmin
              ? event.member!.fullName()
              : state.admin!.fullName(),
          creditCardBrand: '',
          name: ''));
    } catch (e) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: ERROR_MESSAGE));
    }
  }

  Future<void> _onFetchDetail(
      FetchDetail event, Emitter<MyCouponsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    try {
      var user = state.user!;

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
        loading: LoadingState.close,
      ));
      event.onSucces(
          (result.last as CouponDetailResponse).couponConsultDetail.toEntity());
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
