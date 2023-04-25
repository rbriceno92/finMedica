import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'terms_conditions_response.g.dart';

@JsonSerializable()
class TermsConditionsResponse extends Equatable {
  @JsonKey(name: 'terms_conditions')
  final String message;

  const TermsConditionsResponse({required this.message});

  factory TermsConditionsResponse.fromJson(Map<String, dynamic> json) =>
      _$TermsConditionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TermsConditionsResponseToJson(this);

  @override
  List<Object?> get props => [message];
}
