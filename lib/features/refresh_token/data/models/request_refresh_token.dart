import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_refresh_token.g.dart';

@JsonSerializable()
class RefreshTokenRequest extends Equatable {
  final String email;

  const RefreshTokenRequest({required this.email});

  @override
  List<Object?> get props => [email];

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
