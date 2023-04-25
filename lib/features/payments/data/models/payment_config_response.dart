import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_config_response.g.dart';

@JsonSerializable()
class PaymentConfigResponse extends Equatable {
  final String? message;
  final String? publishableKey;

  const PaymentConfigResponse({this.message, this.publishableKey});

  @override
  List<Object?> get props => [message, publishableKey];

  factory PaymentConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentConfigResponseToJson(this);
}
