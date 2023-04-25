import 'package:equatable/equatable.dart';

class DeletePaymentMethodRequest extends Equatable {
  final String stripeCustomerId;
  final String paymentMethodId;

  const DeletePaymentMethodRequest(
      {required this.stripeCustomerId, required this.paymentMethodId});

  @override
  List<Object?> get props => [stripeCustomerId, paymentMethodId];
}
