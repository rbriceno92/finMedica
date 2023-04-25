import 'package:app/features/store/domain/entity/cart_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> attributes;
  final bool active;
  final List<String> images;
  final double price;
  final String currency;
  final Metadata metadata;
  final String type;
  final int created;
  final int updated;

  const ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.attributes,
      required this.active,
      required this.images,
      required this.price,
      required this.currency,
      required this.metadata,
      required this.type,
      required this.created,
      required this.updated});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  CartItem toEntity() => CartItem(
      amount: price / 100,
      quantity: int.tryParse(metadata.quantity) ?? 0,
      id: id);

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        attributes,
        active,
        images,
        price,
        currency,
        metadata,
        type,
        created,
        updated
      ];
}

@JsonSerializable()
class Metadata extends Equatable {
  final String quantity;

  const Metadata(this.quantity);

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);

  @override
  List<Object?> get props => [quantity];
}
