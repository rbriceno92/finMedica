import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_method_request.g.dart';

@JsonSerializable()
class CreatePaymentMethodRequest extends Equatable {
  @JsonKey(name: 'stripe_customer_id')
  final String stripeCustomerId;
  @JsonKey(name: 'payment_method_id')
  final String paymentMethodId;

  const CreatePaymentMethodRequest(
      {required this.stripeCustomerId, required this.paymentMethodId});

  @override
  List<Object?> get props => [stripeCustomerId, paymentMethodId];

  factory CreatePaymentMethodRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentMethodRequestToJson(this);
}
