import 'package:app/features/my_coupons/data/models/coupon_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remaining_consults_response.g.dart';

@JsonSerializable()
class RemainingConsults extends Equatable {
  final String message;
  final int totalAvailableConsults;
  final int totalPages;
  final List<CouponModel> activeUserPackage;

  const RemainingConsults({
    required this.message,
    this.totalAvailableConsults = 0,
    required this.activeUserPackage,
    this.totalPages = 0,
  });

  factory RemainingConsults.fromJson(Map<String, dynamic> json) =>
      _$RemainingConsultsFromJson(json);

  Map<String, dynamic> toJson() => _$RemainingConsultsToJson(this);

  @override
  List<Object?> get props =>
      [message, totalAvailableConsults, activeUserPackage, totalPages];
}
