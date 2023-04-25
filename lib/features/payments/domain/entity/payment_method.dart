import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String id;
  final String number;
  final String brand;

  const PaymentMethod(
      {required this.number, required this.brand, required this.id});

  @override
  List<Object?> get props => [id, number, brand];
}
