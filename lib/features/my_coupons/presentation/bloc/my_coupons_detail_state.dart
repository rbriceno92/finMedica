import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

const Coupon couponEmpty = Coupon(
    id: '',
    type: CouponType.package,
    quantity: 0,
    quantityAvailable: 0,
    purchaseDate: '0000-01-01T00:00:00.000Z',
    amount: 0,
    creditCard: '',
    couponCode: '',
    transferredBy: '',
    transferredTo: '',
    creditCardBrand: '',
    name: '');

class MyCouponsDetailState extends Equatable {
  final Coupon bundle;
  final LoadingState loading;
  final String errorMessage;

  const MyCouponsDetailState({
    this.bundle = couponEmpty,
    this.loading = LoadingState.dispose,
    this.errorMessage = '',
  });

  MyCouponsDetailState copyWith({
    Coupon? coupon,
    LoadingState? loading,
    String? errorMessage,
  }) =>
      MyCouponsDetailState(
        bundle: coupon ?? bundle,
        loading: loading ?? this.loading,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        bundle,
        loading,
        errorMessage,
      ];
}
