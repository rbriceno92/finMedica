import 'package:app/features/my_groups/data/models/create_new_member_response.dart';
import 'package:app/features/my_groups/data/models/edit_admin_request.dart';
import 'package:app/features/my_groups/data/models/edit_admin_response.dart';
import 'package:app/features/my_groups/data/models/my_groups_fetch_data_filtered_response.dart';
import 'package:app/features/my_groups/data/models/my_groups_fetch_data_response.dart';
import 'package:app/features/my_groups/data/models/remove_member_response.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/add_member_existent_request.dart';
import '../../data/models/create_my_groups_response.dart';
import '../../data/models/create_new_member_request.dart';
import '../../data/models/get_my_groups_data_response.dart';
import '../../data/models/remove_member_request.dart';

abstract class MyGroupsRepository {
  Future<Either<ErrorGeneral, GetMyGroupsDataResponse>> getMyGroupData(
      ParametroVacio param);

  Future<Either<ErrorGeneral, MyGroupsFetchDataFilteredResponse>>
      fetchDataFiltered(String param);

  Future<Either<ErrorGeneral, bool>> addMember(AddMemberExistentRequest param);

  Future<Either<ErrorGeneral, RemoveMemberResponse>> removeMember(
      RemoveMemberRequest param);

  Future<Either<ErrorGeneral, CreateNewMemberResponse>> newMember(
      CreateMyNewMemberRequest param);

  Future<Either<ErrorGeneral, AdminEditResponse>> transferManagement(
      EditAdminRequest param);

  Future<Either<ErrorGeneral, MyGroupsFetchDataResponse>>
      getMyGroupsMembersList(String param);

  Future<Either<ErrorGeneral, CreateMyGroupsResponse>> createMyGroups(
      String idAdmin);
}
