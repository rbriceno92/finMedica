import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_coupons_code_response.g.dart';

@JsonSerializable()
class MyCouponsCodeResponse extends Equatable {
  @JsonKey(name: 'Message')
  final String message;

  const MyCouponsCodeResponse({required this.message});

  factory MyCouponsCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$MyCouponsCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyCouponsCodeResponseToJson(this);

  @override
  List<Object?> get props => [message];
}
