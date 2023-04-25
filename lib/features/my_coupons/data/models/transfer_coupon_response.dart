import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_coupon_response.g.dart';

@JsonSerializable()
class TransferCouponResponse extends Equatable {
  final String message;

  const TransferCouponResponse({required this.message});

  factory TransferCouponResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferCouponResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransferCouponResponseToJson(this);

  @override
  List<Object> get props => [message];
}
