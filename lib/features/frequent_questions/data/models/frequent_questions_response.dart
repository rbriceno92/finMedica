import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'frequent_questions_response.g.dart';

@JsonSerializable()
class FrequentQuestionsResponse extends Equatable {
  final List result;

  const FrequentQuestionsResponse({required this.result});

  factory FrequentQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$FrequentQuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FrequentQuestionsResponseToJson(this);

  @override
  List<Object?> get props => [result];
}
