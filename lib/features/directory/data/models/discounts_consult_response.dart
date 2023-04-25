import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discounts_consult_response.g.dart';

@JsonSerializable()
class DiscountsConsultResponde extends Equatable {
  final String purchaseId;
  final String message;

  const DiscountsConsultResponde(
      {required this.message, required this.purchaseId});

  factory DiscountsConsultResponde.fromJson(Map<String, dynamic> json) =>
      _$DiscountsConsultRespondeFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountsConsultRespondeToJson(this);

  @override
  List<Object?> get props => [message, purchaseId];
}
