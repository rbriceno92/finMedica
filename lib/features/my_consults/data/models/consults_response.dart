import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'consult_model.dart';
part 'consults_response.g.dart';

@JsonSerializable()
class ConsultResponse extends Equatable {
  final List<ConsultModel> consults;

  const ConsultResponse({required this.consults});
  @override
  List<Object?> get props => [consults];

  factory ConsultResponse.fromJson(Map<String, dynamic> json) =>
      _$ConsultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultResponseToJson(this);
}
