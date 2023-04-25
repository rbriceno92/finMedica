import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'discounts_consult_param.g.dart';

@JsonSerializable()
class DiscountsConsultParam extends Equatable {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'consult_alephoo_id')
  final int? consultAlephooId;

  const DiscountsConsultParam({required this.userId, this.consultAlephooId});

  factory DiscountsConsultParam.fromJson(Map<String, dynamic> json) =>
      _$DiscountsConsultParamFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountsConsultParamToJson(this);

  @override
  List<Object?> get props => [userId, consultAlephooId];
}
