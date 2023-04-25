import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/features/my_consults/data/models/consult_private_params.dart';
import 'package:app/features/my_consults/data/models/doctor_photo_model.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/reschedule_appointment_param.dart';

abstract class ConsultRepository {
  Future<Either<ErrorGeneral, List<ConsultModel>>> getListMyConsults(
      Map states);

  Future<Either<ErrorGeneral, ConsultModel>> getConsultDetail(int consultId);

  Future<Either<ErrorGeneral, bool>> rescheduleAppointment(
      RescheduleAppointmentParam param);

  Future<Either<ErrorGeneral, bool>> makeConsultPrivate(
      ConsultPrivateParams consultPrivateParams);

  Future<Either<ErrorGeneral, DoctorPhotoModel>> getDoctorPhoto(
      int profesionalPersonaId);
}
