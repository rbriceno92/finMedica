import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/features/my_coupons/presentation/bloc/my_coupons_state.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:equatable/equatable.dart';

abstract class MyCouponsEvent extends Equatable {
  const MyCouponsEvent();
}

class DisposeLoading extends MyCouponsEvent {
  @override
  List<Object?> get props => [];
}

class InitialLoad extends MyCouponsEvent {
  const InitialLoad();

  @override
  List<Object?> get props => [];
}

class FetchData extends MyCouponsEvent {
  final int limit;
  final int page;

  const FetchData({
    this.limit = remainingConsultsQueryLimit,
    this.page = 1,
  });

  @override
  List<Object?> get props => [limit, page];
}

class FilterBy extends MyCouponsEvent {
  final FilterSelect filter;
  const FilterBy(this.filter);

  @override
  List<Object?> get props => [filter];
}

class TransferCoupon extends MyCouponsEvent {
  final MyGroupsMember? member;
  final void Function(Coupon coupon) onSucces;
  const TransferCoupon({this.member, required this.onSucces});

  @override
  List<Object?> get props => [member, onSucces];
}

class FetchDetail extends MyCouponsEvent {
  final String couponId;
  final CouponType couponType;
  final void Function(Coupon coupon) onSucces;

  const FetchDetail(
      {required this.couponId,
      required this.couponType,
      required this.onSucces});

  @override
  List<Object?> get props => [couponId, couponType];
}
