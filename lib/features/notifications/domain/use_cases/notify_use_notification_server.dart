import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repository/notifications_repository.dart';

class NotifyUseNotificationServer extends UseCase<bool, List<String>> {
  final NotificationRepository repository;

  NotifyUseNotificationServer({required this.repository});

  @override
  Future<Either<ErrorGeneral, bool>> call(List<String> param) async {
    return await repository.viewedNotifications(param);
  }
}
