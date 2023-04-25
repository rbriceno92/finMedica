import 'package:equatable/equatable.dart';

abstract class AddPaymentMethodEvent extends Equatable {
  const AddPaymentMethodEvent();
}

class DisposeLoading extends AddPaymentMethodEvent {
  @override
  List<Object?> get props => [];
}

class LoadUser extends AddPaymentMethodEvent {
  @override
  List<Object?> get props => [];
}

class CreatePaymentMethod extends AddPaymentMethodEvent {
  @override
  List<Object?> get props => [];
}
