import 'package:json_annotation/json_annotation.dart';

part 'cancel_consult_request.g.dart';

@JsonSerializable()
class CancelConsultRequest {
  final int consultId;

  const CancelConsultRequest({
    required this.consultId,
  });

  factory CancelConsultRequest.fromJson(Map<String, dynamic> json) =>
      _$CancelConsultRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CancelConsultRequestToJson(this);
}
