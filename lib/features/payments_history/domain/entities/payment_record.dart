import 'package:app/features/payments/domain/entity/payment_method.dart';
import 'package:equatable/equatable.dart';

class PaymentRecord extends Equatable {
  final String id;
  final double amount;
  final String status;
  final int created;
  final String quantity;
  final String productName;
  final String productId;
  final PaymentMethod? paymentMethod;

  const PaymentRecord({
    required this.id,
    required this.amount,
    required this.created,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.status,
    this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        id,
        created,
        amount,
        status,
        paymentMethod,
        quantity,
        productId,
        productName
      ];
}
