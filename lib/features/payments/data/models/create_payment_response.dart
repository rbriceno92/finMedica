import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_response.g.dart';

@JsonSerializable()
class CreatePaymentResponse extends Equatable {
  final String message;
  final String clientSecret;
  final String ephemeralKey;

  const CreatePaymentResponse(
      {required this.message,
      required this.clientSecret,
      required this.ephemeralKey});

  @override
  List<Object?> get props => [message, clientSecret, ephemeralKey];

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentResponseToJson(this);
}
