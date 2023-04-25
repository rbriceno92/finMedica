import 'package:app/features/payments/data/models/payment_method_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_methods_response.g.dart';

@JsonSerializable()
class PaymentMethodsResponse extends Equatable {
  final String message;
  final List<PaymentMethodModel> userPaymentMethods;
  final bool hasMore;

  const PaymentMethodsResponse(
      {required this.message,
      required this.userPaymentMethods,
      required this.hasMore});

  @override
  List<Object?> get props => [message, userPaymentMethods, hasMore];

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsResponseToJson(this);
}
