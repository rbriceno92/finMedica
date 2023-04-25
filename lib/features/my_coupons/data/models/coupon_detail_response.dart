import 'package:app/features/my_coupons/data/models/coupon_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon_detail_response.g.dart';

@JsonSerializable()
class CouponDetailResponse extends Equatable {
  final String message;
  final CouponModel couponConsultDetail;

  const CouponDetailResponse({
    required this.message,
    required this.couponConsultDetail,
  });

  factory CouponDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponDetailResponseToJson(this);

  @override
  List<Object?> get props => [message, couponConsultDetail];
}
