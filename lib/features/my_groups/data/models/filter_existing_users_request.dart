import 'package:json_annotation/json_annotation.dart';

part 'filter_existing_users_request.g.dart';

@JsonSerializable()
class FilterExistingUsersRequest {
  final String code;

  const FilterExistingUsersRequest({
    required this.code,
  });

  factory FilterExistingUsersRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterExistingUsersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FilterExistingUsersRequestToJson(this);
}
