import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_model.g.dart';

@JsonSerializable()
class PasswordModel extends Equatable {
  final String password;

  const PasswordModel({required this.password});

  @override
  List<Object?> get props => [password];

  Map<String, dynamic> toJson() => _$PasswordModelToJson(this);

  factory PasswordModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordModelFromJson(json);
}
