import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment extends Equatable {
  final String target;
  final double amount;

  const Payment({required this.target, required this.amount});

  @override
  List<Object?> get props => [target, amount];

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
