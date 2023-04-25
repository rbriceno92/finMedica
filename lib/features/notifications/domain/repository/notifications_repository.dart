import 'package:app/features/notifications/data/models/notification_model.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepository {
  Future<Either<ErrorGeneral, List<NotificationModel>>> getNotifications(
      String userId);

  Future<Either<ErrorGeneral, bool>> deleteNotification(String notificationId);

  Future<Either<ErrorGeneral, bool>> viewedNotifications(List<String> list);
}
