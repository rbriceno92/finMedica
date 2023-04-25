import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_consult_response.g.dart';

@JsonSerializable()
class CancelConsultResponse extends Equatable {
  final bool cancelConsultSuccess;

  const CancelConsultResponse({required this.cancelConsultSuccess});

  factory CancelConsultResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelConsultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelConsultResponseToJson(this);

  @override
  List<Object?> get props => [cancelConsultSuccess];
}
