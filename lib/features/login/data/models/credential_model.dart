import 'package:app/features/login/domain/entities/credentials.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credential_model.g.dart';

@JsonSerializable()
class ModelCredential extends Credentials {
  const ModelCredential({required super.email, required super.password});

  factory ModelCredential.fromJson(Map<String, dynamic> json) =>
      _$ModelCredentialFromJson(json);

  Map<String, dynamic> toJson() => _$ModelCredentialToJson(this);
}
