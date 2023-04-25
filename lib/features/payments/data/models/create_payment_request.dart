import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_request.g.dart';

@JsonSerializable()
class CreatePaymentRequest extends Equatable {
  final String email;
  @JsonKey(name: 'product_id')
  final String productId;
  @JsonKey(name: 'consult_alephoo_id')
  final int? consultAlephooId;

  const CreatePaymentRequest(
      {required this.email, required this.productId, this.consultAlephooId});

  @override
  List<Object?> get props => [email, productId];

  factory CreatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentRequestToJson(this);
}
