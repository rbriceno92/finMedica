import 'package:app/features/payments/domain/entity/payment_method.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel extends Equatable {
  final String id;
  @JsonKey(name: 'billing_details')
  final BillingDetailsModel? billingDetails;
  final CardModel? card;
  final String type;

  const PaymentMethodModel(
      {required this.id, this.billingDetails, this.card, required this.type});

  PaymentMethod toEntity() => PaymentMethod(
      number: card?.last4 ?? '', brand: card?.brand ?? 'unknown', id: id);

  @override
  List<Object?> get props => [id, billingDetails, card, type];

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}

@JsonSerializable()
class BillingDetailsModel extends Equatable {
  final AddressModel? address;
  final String? email;
  final String? name;
  final String? phone;

  const BillingDetailsModel({this.address, this.email, this.name, this.phone});

  @override
  List<Object?> get props => [address, email, name];

  factory BillingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BillingDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillingDetailsModelToJson(this);
}

@JsonSerializable()
class AddressModel extends Equatable {
  final String? city;
  final String? country;
  final String? line1;
  final String? line2;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  final String? state;

  const AddressModel(
      {this.city,
      this.country,
      this.line1,
      this.line2,
      this.postalCode,
      this.state});

  @override
  List<Object?> get props => [city, country, line1, line2, postalCode, state];

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class CardModel extends Equatable {
  final String? brand;
  final String? country;
  @JsonKey(name: 'exp_month')
  final int? expMonth;
  @JsonKey(name: 'exp_year')
  final int? expYear;
  final String? funding;
  final String? last4;

  const CardModel(
      {this.brand,
      this.country,
      this.expMonth,
      this.expYear,
      this.funding,
      this.last4});

  @override
  List<Object?> get props =>
      [brand, country, expMonth, expYear, funding, last4];

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
