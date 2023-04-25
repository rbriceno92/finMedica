import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_payment_method_response.g.dart';

@JsonSerializable()
class DeletePaymentMethodResponse extends Equatable {
  final String message;

  const DeletePaymentMethodResponse({required this.message});

  @override
  List<Object?> get props => [message];

  factory DeletePaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePaymentMethodResponseToJson(this);
}
