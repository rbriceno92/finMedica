import 'package:app/features/my_groups/data/models/get_my_groups_data_response.dart';

class RemoveMemberResponse {
  final int quantity;
  final GetMyGroupsDataResponse groupMembers;

  const RemoveMemberResponse({
    required this.quantity,
    required this.groupMembers,
  });
}
