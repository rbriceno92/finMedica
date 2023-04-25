import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MyCouponsDetailEvent extends Equatable {
  const MyCouponsDetailEvent();
}

class DisposeLoading extends MyCouponsDetailEvent {
  @override
  List<Object?> get props => [];
}

class FetchData extends MyCouponsDetailEvent {
  final String couponId;
  final CouponType couponType;

  const FetchData({required this.couponId, required this.couponType});

  @override
  List<Object?> get props => [couponId, couponType];
}
