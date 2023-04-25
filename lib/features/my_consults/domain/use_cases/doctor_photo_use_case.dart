import 'package:app/features/my_consults/data/models/doctor_photo_model.dart';
import 'package:app/features/my_consults/domain/repositories/consult_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class DoctorPhotoUseCase extends UseCase<DoctorPhotoModel, int> {
  final ConsultRepository repository;

  DoctorPhotoUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, DoctorPhotoModel>> call(int param) async {
    return await repository.getDoctorPhoto(param);
  }
}
