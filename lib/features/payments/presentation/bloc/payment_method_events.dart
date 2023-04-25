import 'package:equatable/equatable.dart';

abstract class PaymentMethodsEvent extends Equatable {
  const PaymentMethodsEvent();
}

class DisposeLoading extends PaymentMethodsEvent {
  @override
  List<Object?> get props => [];
}

class LoadUser extends PaymentMethodsEvent {
  @override
  List<Object?> get props => [];
}

class FetchData extends PaymentMethodsEvent {
  @override
  List<Object?> get props => [];
}

class RemovePaymentMethod extends PaymentMethodsEvent {
  final String paymentMethodId;
  const RemovePaymentMethod({required this.paymentMethodId});

  @override
  List<Object?> get props => [paymentMethodId];
}
