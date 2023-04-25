import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class StoreCartEvent extends Equatable {
  const StoreCartEvent();
}

class PayCartItem extends StoreCartEvent {
  final void Function(String message) onError;
  const PayCartItem({required this.onError});

  @override
  List<Object?> get props => [onError];
}

class DisposeLoading extends StoreCartEvent {
  @override
  List<Object?> get props => [];
}

class SetCartItem extends StoreCartEvent {
  final CartItem? item;
  const SetCartItem(this.item);

  @override
  List<Object?> get props => [item];
}
