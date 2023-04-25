import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_method_response.g.dart';

@JsonSerializable()
class CreatePaymentMethodResponse extends Equatable {
  final String message;

  const CreatePaymentMethodResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];

  factory CreatePaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentMethodResponseToJson(this);
}
