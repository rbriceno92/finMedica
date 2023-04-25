import 'dart:io';

import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/features/my_consults/data/models/consult_private_params.dart';
import 'package:app/features/my_consults/data/models/doctor_photo_model.dart';
import 'package:app/features/my_consults/domain/repositories/consult_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/models/error_model_server.dart';
import '../../../../util/user_preferences_save.dart';
import '../../../dashboard/data/models/next_consults_request.dart';
import '../services/services_consults.dart';
import '../../data/models/reschedule_appointment_param.dart';

class ConsultRepositoryImpl extends ConsultRepository {
  final ChopperClient chopperClient;
  final UserPreferenceDao dao;

  ConsultRepositoryImpl({required this.chopperClient, required this.dao});
  @override
  Future<Either<ErrorGeneral, List<ConsultModel>>> getListMyConsults(
      Map states) async {
    final service = chopperClient.getService<ServiceConsults>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    final userResponse = await dao.getUser();

    return userResponse.fold((error) {
      return const Left(ErrorMessage(message: USER_NOT_FOUND));
    }, (modelUser) async {
      var alephooId = modelUser.idUserAlephoo;
      var documentId = modelUser.documentId;
      var addPastDates = true;
      var statesRequired = states['statesRequired'];

      try {
        var consults = await service.getNextConsults(
            NextConsultRequest(
                alephooId: alephooId.toString(),
                documentId: documentId ?? '',
                addPastDates: addPastDates,
                statesRequired: statesRequired),
            token ?? '');
        if (consults.isSuccessful) {
          final result = getConsults(consults.body);
          return Right(result);
        } else {
          return Left(ServerFailure(
              modelServer: getError(consults.error as Map<String, dynamic>)));
        }
      } on SocketException {
        return const Left(ErrorMessage(message: CONNECTION_ERROR));
      } catch (e) {
        return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
      }
    });
  }

  @override
  Future<Either<ErrorGeneral, ConsultModel>> getConsultDetail(
      int consultId) async {
    final service = chopperClient.getService<ServiceConsults>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response = await service.getConsultDetails(consultId, token ?? '');
      if (response.isSuccessful) {
        final result = getConsult(response.body);
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
  Future<Either<ErrorGeneral, bool>> rescheduleAppointment(
      RescheduleAppointmentParam param) async {
    final service = chopperClient.getService<ServiceConsults>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.rescheduleAppointment(token ?? '', param);

      if (response.isSuccessful) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  ConsultModel getConsult(Map<String, dynamic> json) =>
      ConsultModel.fromJson(json);

  List<ConsultModel> getConsults(List<dynamic> json) {
    var list = [];
    for (var element in json) {
      if (STATE_CONSULT.contains(element['state'].toLowerCase())) {
        list.add(element);
      }
    }

    return list.map((elem) => getConsult(elem)).toList();
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  @override
  Future<Either<ErrorGeneral, bool>> makeConsultPrivate(
      ConsultPrivateParams consultPrivateParams) async {
    final service = chopperClient.getService<ServiceConsults>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response =
          await service.makeConsultPrivacy(consultPrivateParams, token ?? '');

      if (response.isSuccessful) {
        return const Right(true);
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
  Future<Either<ErrorGeneral, DoctorPhotoModel>> getDoctorPhoto(
      int profesionalPersonaId) async {
    final service = chopperClient.getService<ServiceConsults>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response =
          await service.getDoctorPhoto(profesionalPersonaId, token ?? '');
      if (response.isSuccessful) {
        return Right(DoctorPhotoModel.fromJson(response.body));
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
