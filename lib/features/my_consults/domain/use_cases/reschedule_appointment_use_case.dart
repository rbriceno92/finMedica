import 'package:app/features/my_consults/data/models/reschedule_appointment_param.dart';
import 'package:app/features/my_consults/domain/repositories/consult_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class RescheduleAppointmentUseCase
    extends UseCase<bool, RescheduleAppointmentParam> {
  final ConsultRepository repository;

  RescheduleAppointmentUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, bool>> call(
      RescheduleAppointmentParam param) async {
    return await repository.rescheduleAppointment(param);
  }
}
