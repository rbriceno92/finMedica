import 'package:app/features/payments/domain/entity/payment_method.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

const List<PaymentMethod> empty = [];

class PaymentMethodsState extends Equatable {
  final List<PaymentMethod> paymentMethods;
  final LoadingState loading;
  final String errorMessage;
  final String successMessage;
  final ModelUser user;

  const PaymentMethodsState(
      {this.paymentMethods = empty,
      this.errorMessage = '',
      this.successMessage = '',
      this.loading = LoadingState.dispose,
      this.user = const ModelUser()});

  PaymentMethodsState copyWith(
          {List<PaymentMethod>? paymentMethods,
          LoadingState? loading,
          String? errorMessage,
          String? successMessage,
          ModelUser? user}) =>
      PaymentMethodsState(
          errorMessage: errorMessage ?? this.errorMessage,
          successMessage: successMessage ?? this.successMessage,
          loading: loading ?? this.loading,
          paymentMethods: paymentMethods ?? this.paymentMethods,
          user: user ?? this.user);

  @override
  List<Object?> get props =>
      [paymentMethods, loading, user, errorMessage, successMessage];
}
