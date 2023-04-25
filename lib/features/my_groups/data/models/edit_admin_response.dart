import 'package:app/features/my_groups/data/models/get_my_groups_data_response.dart';

class AdminEditResponse {
  final GetMyGroupsDataResponse groupMembers;

  const AdminEditResponse({
    required this.groupMembers,
  });
}
