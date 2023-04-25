import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_config_request.g.dart';

@JsonSerializable()
class PaymentConfigRequest extends Equatable {
  final String email;

  const PaymentConfigRequest({required this.email});

  @override
  List<Object?> get props => [email];

  factory PaymentConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentConfigRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentConfigRequestToJson(this);
}
