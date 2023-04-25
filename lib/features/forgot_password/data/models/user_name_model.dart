import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_name_model.g.dart';

@JsonSerializable()
class UserNameModel extends Equatable {
  @JsonKey(name: 'first_name')
  final String firstName;

  const UserNameModel({required this.firstName});

  factory UserNameModel.fromJson(Map<String, dynamic> json) =>
      _$UserNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserNameModelToJson(this);

  @override
  List<Object?> get props => [firstName];
}
