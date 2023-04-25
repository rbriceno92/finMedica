import 'package:app/features/my_groups/data/models/my_groups_member_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_groups_fetch_data_filtered_response.g.dart';

@JsonSerializable()
class MyGroupsFetchDataFilteredResponse extends Equatable {
  final List<MyGroupsMemberModel> user;

  const MyGroupsFetchDataFilteredResponse({required this.user});

  factory MyGroupsFetchDataFilteredResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MyGroupsFetchDataFilteredResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MyGroupsFetchDataFilteredResponseToJson(this);

  @override
  List<Object?> get props => [user];
}
