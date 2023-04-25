import 'package:equatable/equatable.dart';

const remainingConsultsQueryLimit = 15;

class CouponDetailRequest extends Equatable {
  final String couponId;
  final String type;
  final String userId;

  const CouponDetailRequest(
      {required this.couponId, required this.type, required this.userId});

  @override
  List<Object> get props => [couponId, type, userId];
}
