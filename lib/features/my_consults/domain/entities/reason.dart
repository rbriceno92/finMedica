import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reason.g.dart';

@JsonSerializable()
class Reason extends Equatable {
  final String title;
  final String description;
  final bool refund;

  const Reason(
      {required this.title, required this.description, required this.refund});

  @override
  List<Object?> get props => [title, description, refund];

  factory Reason.fromJson(Map<String, dynamic> json) => _$ReasonFromJson(json);
}
