import 'package:app/features/my_groups/data/models/my_groups_admin_model.dart';
import 'package:app/features/my_groups/data/models/my_groups_member_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_groups_fetch_data_response.g.dart';

@JsonSerializable()
class MyGroupsFetchDataResponse extends Equatable {
  final MyGroupsAdminModel administrator;
  final List<MyGroupsMemberModel> members;

  const MyGroupsFetchDataResponse(
      {required this.administrator, required this.members});

  factory MyGroupsFetchDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MyGroupsFetchDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyGroupsFetchDataResponseToJson(this);

  @override
  List<Object?> get props => [members, administrator];
}
