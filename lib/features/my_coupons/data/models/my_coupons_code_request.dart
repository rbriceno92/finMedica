import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_coupons_code_request.g.dart';

@JsonSerializable()
class MyCouponsCodeRequest extends Equatable {
  final int code;

  const MyCouponsCodeRequest({required this.code});

  factory MyCouponsCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$MyCouponsCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyCouponsCodeRequestToJson(this);

  @override
  List<Object?> get props => [code];
}
