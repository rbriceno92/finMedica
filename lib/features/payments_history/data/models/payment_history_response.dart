import 'package:app/features/payments_history/data/models/payments_record_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_history_response.g.dart';

@JsonSerializable()
class PaymentHistoryResponse extends Equatable {
  final List<PaymentRecordModel> userPaymentHistory;
  @JsonKey(name: 'next_page')
  final String? nextPage;
  final bool hasMore;

  const PaymentHistoryResponse({
    required this.userPaymentHistory,
    this.nextPage,
    required this.hasMore,
  });

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentHistoryResponseToJson(this);

  @override
  List<Object?> get props => [userPaymentHistory, nextPage, hasMore];
}
