import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'next_consults_request.g.dart';

@JsonSerializable()
class NextConsultRequest extends Equatable {
  final bool addPastDates;
  final List statesRequired;
  @JsonKey(name: 'alephoo_id')
  final String alephooId;
  @JsonKey(name: 'document_id')
  final String documentId;

  const NextConsultRequest(
      {required this.alephooId,
      required this.documentId,
      required this.addPastDates,
      required this.statesRequired});

  @override
  List<Object?> get props =>
      [alephooId, documentId, addPastDates, statesRequired];

  factory NextConsultRequest.fromJson(Map<String, dynamic> json) =>
      _$NextConsultRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NextConsultRequestToJson(this);
}
