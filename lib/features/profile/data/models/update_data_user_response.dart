import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_data_user_response.g.dart';

@JsonSerializable()
class UpdateDataUserResponse extends Equatable {
  final Map<String, dynamic> message;

  const UpdateDataUserResponse({required this.message});

  factory UpdateDataUserResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateDataUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDataUserResponseToJson(this);

  @override
  List<Object?> get props => [
        message,
      ];
}
