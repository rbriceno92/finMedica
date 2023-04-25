import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:app/features/directory/data/models/schedule_doctor_param.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import '../../../../util/use_case.dart';
import '../repositories/directory_repository.dart';

class GetScheduleUseCase extends UseCase<ScheduleDoctor, ScheduleDoctorParam> {
  final DirectoryRepository repository;

  GetScheduleUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, ScheduleDoctor>> call(
      ScheduleDoctorParam param) async {
    return await repository.getScheduleDoctor(
        param.professional_id, param.date, param.endDate);
  }
}
