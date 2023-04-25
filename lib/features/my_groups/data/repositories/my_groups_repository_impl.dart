import 'dart:io';

import 'package:app/features/my_groups/data/models/create_new_member_response.dart';
import 'package:app/features/my_groups/data/models/edit_admin_request.dart';
import 'package:app/features/my_groups/data/models/edit_admin_response.dart';
import 'package:app/features/my_groups/data/models/my_groups_fetch_data_filtered_response.dart';
import 'package:app/features/my_groups/data/models/my_groups_fetch_data_response.dart';
import 'package:app/features/my_groups/data/models/remove_member_response.dart';
import 'package:app/features/my_groups/domain/repository/my_groups_repository.dart';

import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:chopper/chopper.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/constants/constants.dart';
import '../../../../util/user_preferences_save.dart';
import '../models/add_member_existent_request.dart';
import '../models/create_my_groups_request.dart';
import '../models/create_my_groups_response.dart';
import '../models/create_new_member_request.dart';
import '../models/filter_existing_users_request.dart';
import '../models/get_my_groups_data_response.dart';
import '../models/remove_member_request.dart';
import '../services/services_groups.dart';

class MyGroupsRepositoryImpl implements MyGroupsRepository {
  final ChopperClient chopperClient;
  final UserPreferenceDao dao;
  MyGroupsRepositoryImpl({required this.chopperClient, required this.dao});

  @override
  Future<Either<ErrorGeneral, MyGroupsFetchDataResponse>>
      getMyGroupsMembersList(String idAdmin) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var getMyGroups =
          await service.getMyGroupMembers(idAdmin, token.toString());
      if (getMyGroups.isSuccessful) {
        final result = myGroupsMembersList(getMyGroups.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(getMyGroups.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, GetMyGroupsDataResponse>> getMyGroupData(
      ParametroVacio param) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var getMyGroup = await service.getMyGroup(token.toString());
      if (getMyGroup.isSuccessful) {
        final result = myGroupData(getMyGroup.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(getMyGroup.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, CreateMyGroupsResponse>> createMyGroups(
      String idAdmin) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var createGroups = await service.createGroups(
          CreateMyGroupsRequest(idAdmin: idAdmin), token.toString());
      if (createGroups.isSuccessful) {
        return Right(createMyGroupData(createGroups.body));
      } else {
        return Left(ServerFailure(
            modelServer: getError(createGroups.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, MyGroupsFetchDataFilteredResponse>>
      fetchDataFiltered(String param) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var users = await service.searchUserByCode(
          FilterExistingUsersRequest(code: param), token.toString());
      if (users.isSuccessful && users.body != '') {
        var result = getMyGroupsFetchDataFilteredResponse({
          'user': [users.body]
        });
        return Right(result);
      } else if (users.error != null) {
        return Left(ServerFailure(
            modelServer: getError(users.error as Map<String, dynamic>)));
      } else {
        return const Left(ErrorMessage(message: ''));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, bool>> addMember(
      AddMemberExistentRequest param) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var addNewMember =
          await service.addMemberExistent(param, token.toString());
      if (addNewMember.isSuccessful) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
            modelServer: getError(addNewMember.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, RemoveMemberResponse>> removeMember(
      RemoveMemberRequest param) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var removeMember = await service.putRemoveMember(param, token.toString());
      if (removeMember.isSuccessful) {
        return Right(getRemoveMemberResponse(removeMember.body));
      } else {
        return Left(ServerFailure(
            modelServer: getError(removeMember.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, AdminEditResponse>> transferManagement(
      EditAdminRequest param) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var transfer = await service.putEditAdmin(param, token.toString());
      if (transfer.isSuccessful) {
        return Right(getAdminEditResponse(transfer.body));
      } else {
        return Left(ServerFailure(
            modelServer: getError(transfer.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, CreateNewMemberResponse>> newMember(
      CreateMyNewMemberRequest param) async {
    final service = chopperClient.getService<ServicesGroups>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var createNewMember =
          await service.createNewMember(param, token.toString());
      if (createNewMember.isSuccessful) {
        var result = getCreateNewMemberResponse(
            createNewMember.body as Map<String, dynamic>);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer:
                getError(createNewMember.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  CreateMyGroupsResponse createMyGroupData(Map<String, dynamic> body) {
    return CreateMyGroupsResponse.fromJson(body);
  }

  GetMyGroupsDataResponse myGroupData(Map<String, dynamic> body) {
    return GetMyGroupsDataResponse.fromJson(body);
  }

  MyGroupsFetchDataResponse myGroupsMembersList(Map<String, dynamic> body) {
    return MyGroupsFetchDataResponse.fromJson(body);
  }

  MyGroupsFetchDataFilteredResponse getMyGroupsFetchDataFilteredResponse(
      Map<String, dynamic> body) {
    return MyGroupsFetchDataFilteredResponse.fromJson(body);
  }

  CreateNewMemberResponse getCreateNewMemberResponse(
      Map<String, dynamic> body) {
    return CreateNewMemberResponse.fromJson(body);
  }

  RemoveMemberResponse getRemoveMemberResponse(List<dynamic> body) {
    return RemoveMemberResponse(
        quantity: body.first as int,
        groupMembers:
            GetMyGroupsDataResponse.fromJson((body.last as List).first));
  }

  AdminEditResponse getAdminEditResponse(List<dynamic> body) {
    return AdminEditResponse(
        groupMembers:
            GetMyGroupsDataResponse.fromJson((body.last as List).first));
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
