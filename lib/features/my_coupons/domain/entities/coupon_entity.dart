import 'package:equatable/equatable.dart';

enum CouponType {
  package(0x1),
  bonus(0x2),
  refund(0x4),
  transfer(0x8),
  membership(0x10);

  const CouponType(this.value);
  final int value;
}

class Coupon extends Equatable {
  final String id;
  final CouponType type;
  final int quantity;
  final int quantityAvailable;
  final String purchaseDate;
  final double amount;
  final String creditCard;
  final String creditCardBrand;
  final String couponCode;
  final String transferredBy;
  final String transferredTo;
  final String name;

  const Coupon(
      {required this.id,
      required this.type,
      required this.quantity,
      required this.quantityAvailable,
      required this.purchaseDate,
      required this.amount,
      required this.creditCard,
      required this.couponCode,
      required this.transferredBy,
      required this.transferredTo,
      required this.creditCardBrand,
      required this.name});

  @override
  List<Object?> get props => [
        id,
        type,
        quantity,
        quantityAvailable,
        purchaseDate,
        amount,
        creditCard,
        couponCode,
        transferredBy,
        creditCardBrand,
        name,
        transferredTo
      ];
}
