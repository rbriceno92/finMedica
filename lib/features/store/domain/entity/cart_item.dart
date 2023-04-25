import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final double amount;
  final int quantity;
  final String id;

  const CartItem(
      {required this.amount, required this.quantity, required this.id});

  @override
  List<Object?> get props => [amount, quantity, id];
}
