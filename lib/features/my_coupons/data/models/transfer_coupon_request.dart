import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer_coupon_request.g.dart';

@JsonSerializable()
class TransferCouponRequest extends Equatable {
  @JsonKey(name: 'user_id')
  final String userId;

  const TransferCouponRequest({this.userId = ''});

  factory TransferCouponRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferCouponRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransferCouponRequestToJson(this);

  @override
  List<Object> get props => [userId];
}
