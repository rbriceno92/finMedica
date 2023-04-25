import 'package:app/features/notifications/data/models/notification_model.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repository/notifications_repository.dart';

class GetNotificationUseCase extends UseCase<List<NotificationModel>, String> {
  final NotificationRepository repository;

  GetNotificationUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, List<NotificationModel>>> call(
      String param) async {
    return await repository.getNotifications(param);
  }
}
