import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resend_code_response.g.dart';

@JsonSerializable()
class ResendCodeResponse extends Equatable {
  final Map<String, dynamic> message;

  const ResendCodeResponse({required this.message});

  factory ResendCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResendCodeResponseToJson(this);

  @override
  List<Object?> get props => [
        message,
      ];
}
