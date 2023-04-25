import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/directory/data/models/book_appointment_response.dart';
import 'package:app/features/directory/data/models/clinic_model.dart';
import 'package:app/features/directory/data/models/discounts_consult_param.dart';
import 'package:app/features/directory/data/models/discounts_consult_response.dart';
import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:app/features/directory/data/models/speciality_model.dart';
import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DirectoryRepository {
  Future<Either<ErrorGeneral, Directory>> getDirectory(int hospital);

  Future<Either<ErrorGeneral, Directory>> getDirectoryBySpecialistAndName(
      int? specialist, String? name, int hospital);

  Future<Either<ErrorGeneral, List<Speciality>>> getSpecialities();

  Future<Either<ErrorGeneral, ClinicModel>> getClinicDefault();

  Future<Either<ErrorGeneral, ScheduleDoctor>> getScheduleDoctor(
      int doctor, String date, String endDate);

  Future<Either<ErrorGeneral, BookAppointmentResponse>> bookAppointment(
      BookAppointmentParams params);

  Future<Either<ErrorGeneral, DiscountsConsultResponde>> discountsConsult(
      DiscountsConsultParam param);
}
