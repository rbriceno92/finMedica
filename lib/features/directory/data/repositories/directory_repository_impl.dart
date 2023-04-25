import 'dart:io';

import 'package:app/core/di/modules.dart';
import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/directory/data/models/book_appointment_response.dart';
import 'package:app/features/directory/data/models/clinic_model.dart';
import 'package:app/features/directory/data/models/directory_model.dart';
import 'package:app/features/directory/data/models/discounts_consult_response.dart';
import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:app/features/directory/data/models/schedule_doctor_param.dart';
import 'package:app/features/directory/data/models/speciality_model.dart';
import 'package:app/features/directory/data/services/directory_services.dart';
import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';

import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/models/error_model_server.dart';
import '../models/discounts_consult_param.dart';
import '../../domain/entities/directory.dart';

class DirectoryRepositoryImpl extends DirectoryRepository {
  final ChopperClient chopperClient;

  DirectoryRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, Directory>> getDirectory(int hospital) async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.getDirectory(token!, hospital, null, '');

      if (response.isSuccessful) {
        final result = getDirectoryModel(response.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, Directory>> getDirectoryBySpecialistAndName(
      int? specialist, String? name, int hospital) async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response =
          await service.getDirectory(token!, hospital, specialist, name);

      if (response.isSuccessful) {
        final result = getDirectoryModel(response.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, List<Speciality>>> getSpecialities() async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.getSpecialities(token ?? '');

      if (response.isSuccessful) {
        final result = getSpecialitiesList(response.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  List<Speciality> getSpecialitiesList(List<dynamic> json) {
    List<Speciality> list = [];
    for (var element in json) {
      var item = Speciality.fromJson(element as Map<String, dynamic>);
      list.add(item);
    }
    return list;
  }

  DirectoryModel getDirectoryModel(List<dynamic> json) {
    List<Doctor> list = [];
    for (var element in json) {
      var item = Doctor.fromJson(element as Map<String, dynamic>);
      if ((item.speciality?.isNotEmpty) ?? false) list.add(item);
    }
    return DirectoryModel(doctors: list);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  @override
  Future<Either<ErrorGeneral, ClinicModel>> getClinicDefault() async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.getClinic(token ?? '');

      if (response.isSuccessful) {
        final result = getClinic(response.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  ClinicModel getClinic(Map<String, dynamic> json) {
    return ClinicModel.fromJson(json);
  }

  @override
  Future<Either<ErrorGeneral, ScheduleDoctor>> getScheduleDoctor(
      int doctor, String date, String endDate) async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    ScheduleDoctorParam param = ScheduleDoctorParam(
        professional_id: doctor, date: date, endDate: endDate);

    try {
      final response = await service.getScheduleDoctor(token ?? '', param);

      if (response.isSuccessful) {
        final result = getScheduleModel(response.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  ScheduleDoctor getScheduleModel(Map<String, dynamic> json) {
    return ScheduleDoctor.fromJson(json);
  }

  @override
  Future<Either<ErrorGeneral, BookAppointmentResponse>> bookAppointment(
      BookAppointmentParams params) async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.bookAppointment(token ?? '', params);

      if (response.isSuccessful) {
        return Right(BookAppointmentResponse.fromJson(
            response.body as Map<String, dynamic>));
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, DiscountsConsultResponde>> discountsConsult(
      DiscountsConsultParam param) async {
    final service = chopperClient.getService<ServiceDirectory>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.discountConsult(token ?? '', param);
      if (response.isSuccessful) {
        return Right(DiscountsConsultResponde.fromJson(
            response.body as Map<String, dynamic>));
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }
}
