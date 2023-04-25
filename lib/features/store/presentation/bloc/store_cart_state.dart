import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class StoreCartState extends Equatable {
  final LoadingState loading;
  final CartItem? item;
  final String? paymentIntentClientSecret;
  final String? customerId;
  final String? customerEphemeralKeySecret;

  const StoreCartState(
      {this.loading = LoadingState.dispose,
      this.item,
      this.customerEphemeralKeySecret,
      this.customerId,
      this.paymentIntentClientSecret});

  StoreCartState copyWith(
          {LoadingState? loading,
          CartItem? item,
          String? paymentIntentClientSecret,
          String? customerId,
          String? customerEphemeralKeySecret}) =>
      StoreCartState(
          loading: loading ?? this.loading,
          item: item ?? this.item,
          paymentIntentClientSecret:
              paymentIntentClientSecret ?? this.paymentIntentClientSecret,
          customerEphemeralKeySecret:
              customerEphemeralKeySecret ?? this.customerEphemeralKeySecret,
          customerId: customerId ?? this.customerId);

  @override
  List<Object?> get props => [
        loading,
        item,
        paymentIntentClientSecret,
        customerEphemeralKeySecret,
        customerId
      ];
}
