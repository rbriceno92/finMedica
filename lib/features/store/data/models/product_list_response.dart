import 'package:app/features/store/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_response.g.dart';

@JsonSerializable()
class ProductListResponse extends Equatable {
  final String message;
  final bool hasMore;
  final List<ProductModel> products;

  const ProductListResponse(
      {required this.message, required this.hasMore, required this.products});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);

  @override
  List<Object?> get props => [message, hasMore, products];
}
