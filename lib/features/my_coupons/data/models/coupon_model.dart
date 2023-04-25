import 'package:app/features/my_coupons/domain/entities/coupon_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class CouponModel extends Equatable {
  final String id;
  final String name;
  final CouponType type;
  final int quantity;
  final int available;
  final String? description;
  final String? createdAt;
  final double? price;
  @JsonKey(name: 'card_brand')
  final String? brand;
  @JsonKey(name: 'card_last4')
  final String? card;
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  @JsonKey(name: 'cupon_code')
  final String? code;
  @JsonKey(name: 'id_boss')
  final String? bossId;
  @JsonKey(name: 'purchase_id')
  final String? purchaseId;
  @JsonKey(name: 'transfer_by')
  final String? transferredBy;
  @JsonKey(name: 'activation_date')
  final String? activationDate;
  @JsonKey(name: 'expiration_date')
  final String? expirationDate;
  @JsonKey(name: 'consult_activity_id')
  final String? consultActivityId;

  const CouponModel({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.available,
    required this.description,
    required this.createdAt,
    this.price,
    this.brand,
    this.card,
    this.paymentType,
    this.code,
    this.bossId,
    this.purchaseId,
    this.transferredBy,
    this.activationDate,
    this.expirationDate,
    this.consultActivityId,
  });

  Coupon toEntity() {
    return Coupon(
        id: id,
        type: type,
        quantity: quantity,
        quantityAvailable: available,
        purchaseDate: activationDate ?? '',
        amount: price != null ? price! / 100 : 0,
        creditCard: card ?? '',
        couponCode: '',
        transferredBy: transferredBy ?? '',
        creditCardBrand: brand ?? '',
        name: name,
        transferredTo: '');
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        quantity,
        available,
        description,
        createdAt,
        price,
        brand,
        card,
        code,
        transferredBy,
        activationDate,
        consultActivityId
      ];
}
