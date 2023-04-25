import 'package:chopper/chopper.dart';

import '../models/create_my_groups_request.dart';
part 'services_groups.chopper.dart';

@ChopperApi()
abstract class ServicesGroups extends ChopperService {
  static ServicesGroups create([ChopperClient? client]) =>
      _$ServicesGroups(client);

  @Get(path: 'groups/get_my_group_members?id_admin={idAdmin}')
  Future<Response> getMyGroupMembers(
      @Path() String idAdmin, @Header('Authorization') String token);

  @Get(path: 'groups/get_my_group')
  Future<Response> getMyGroup(@Header('Authorization') String token);

  @Post(path: 'groups/create_group')
  Future<Response> createGroups(@Body() CreateMyGroupsRequest consultId,
      @Header('Authorization') String token);

  @Post(path: 'groups/add_member_new')
  Future<Response> createNewMember(
      @Body() newMember, @Header('Authorization') String token);

  @Put(path: 'groups/eliminate_member')
  Future<Response> putRemoveMember(
      @Body() removeMember, @Header('Authorization') String token);

  @Post(path: 'groups/search_by_code')
  Future<Response> searchUserByCode(
      @Body() searchUser, @Header('Authorization') String token);

  @Post(path: 'groups/search_user')
  Future<Response> searchUser(
      @Body() searchUser, @Header('Authorization') String token);

  @Put(path: 'groups/edit_admin')
  Future<Response> putEditAdmin(
      @Body() editAdmin, @Header('Authorization') String token);

  @Post(path: 'groups/send_invitation_member')
  Future<Response> addMemberExistent(
      @Body() addMember, @Header('Authorization') String token);
}
