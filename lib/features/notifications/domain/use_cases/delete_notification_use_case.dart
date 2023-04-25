import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import '../../../../util/use_case.dart';
import '../repository/notifications_repository.dart';

class DeleteNotificationUseCase extends UseCase<bool, String> {
  final NotificationRepository repository;

  DeleteNotificationUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, bool>> call(String param) async {
    return await repository.deleteNotification(param);
  }
}
