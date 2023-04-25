import 'package:chopper/chopper.dart';

part 'notifications_service.chopper.dart';

@ChopperApi()
abstract class ServiceNotification extends ChopperService {
  static ServiceNotification create([ChopperClient? client]) =>
      _$ServiceNotification(client);

  @Get(path: 'notification/get')
  Future<Response> getNotificationsList(
      @Query('user_id') String userId, @Header('Authorization') String token);

  @Delete(path: 'notification/{notificationId}')
  Future<Response> deleteNotification(
      @Path() String notificationId, @Header('Authorization') String token);

  @Get(path: 'notificationtoggle')
  Future<Response> viewedNotifications(
      @Body() List<String> list, @Header('Authorization') String token);
}
