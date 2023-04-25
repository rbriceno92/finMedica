import 'package:app/features/payments/data/models/payment_method_model.dart';
import 'package:app/features/payments_history/domain/entities/payment_record.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payments_record_model.g.dart';

@JsonSerializable()
class PaymentRecordModel extends Equatable {
  final String? id;
  final PaymentRecordMetadata? metadata;
  final double? amount;
  final int? created;
  final String? status;
  @JsonKey(name: 'payment_method')
  final PaymentMethodModel? paymentMethod;

  const PaymentRecordModel(
      {this.id,
      this.amount,
      this.created,
      this.status,
      this.paymentMethod,
      this.metadata});

  factory PaymentRecordModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRecordModelToJson(this);

  @override
  List<Object?> get props =>
      [id, amount, created, status, paymentMethod, metadata];

  PaymentRecord toEntity() => PaymentRecord(
      id: id ?? '',
      amount: amount ?? 0,
      created: created ?? DateTime.now().millisecondsSinceEpoch,
      productId: metadata?.productId ?? '',
      productName: metadata?.productName ?? '',
      quantity: metadata?.quantity ?? '0',
      status: status ?? '',
      paymentMethod: paymentMethod?.toEntity());
}

@JsonSerializable()
class PaymentRecordMetadata extends Equatable {
  @JsonKey(name: 'product_quantity')
  final String? quantity;
  @JsonKey(name: 'product_name')
  final String? productName;
  @JsonKey(name: 'product_id')
  final String? productId;

  const PaymentRecordMetadata(
      {this.quantity, this.productName, this.productId});

  factory PaymentRecordMetadata.fromJson(Map<String, dynamic> json) =>
      _$PaymentRecordMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRecordMetadataToJson(this);

  @override
  List<Object?> get props => [quantity, productName, productId];
}
