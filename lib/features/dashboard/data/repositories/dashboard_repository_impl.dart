import 'dart:io';

import 'package:app/core/di/modules.dart';
import 'package:app/features/dashboard/data/services/service_next_consult.dart';
import 'package:app/features/dashboard/domain/repositories/dashboard_repositories.dart';
import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/user_preferences_save.dart';
import '../models/next_consults_request.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final ChopperClient chopperClient;
  final UserPreferenceDao dao;

  DashboardRepositoryImpl({required this.chopperClient, required this.dao});

  @override
  Future<Either<ErrorGeneral, List<ConsultModel>>> getNextConsults(
      Map states) async {
    final service = chopperClient.getService<ServiceNextConsult>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    final userResponse = await dao.getUser();

    return userResponse.fold((error) {
      return const Left(ErrorMessage(message: USER_NOT_FOUND));
    }, (modelUser) async {
      var alephooId = modelUser.idUserAlephoo;
      var documentId = modelUser.documentId;
      var addPastDates = false;
      var statesRequired = states['statesRequired'];
      try {
        var nextConsult = await service.getNextConsults(
            NextConsultRequest(
                alephooId: alephooId.toString(),
                documentId: documentId ?? '',
                addPastDates: addPastDates,
                statesRequired: statesRequired),
            token ?? '');

        if (nextConsult.isSuccessful) {
          final result = getModelNextConsult(nextConsult.body);
          return Right(result);
        } else {
          return Left(ServerFailure(
              modelServer:
                  getError(nextConsult.error as Map<String, dynamic>)));
        }
      } on SocketException {
        return const Left(ErrorMessage(message: CONNECTION_ERROR));
      } catch (e) {
        return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
      }
    });
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  List<ConsultModel> getModelNextConsult(List<dynamic> json) {
    var list = <ConsultModel>[];

    for (var element in json) {
      list.add(ConsultModel.fromJson(element));
    }
    return list;
  }
}
