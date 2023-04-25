import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

import 'package:app/util/failure.dart';

import 'package:app/features/my_consults/data/models/cancel_consult_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/models/error_model_server.dart';
import '../models/cancel_consult_request.dart';
import '../services/services_cancel_consult.dart';
import '../../domain/repositories/cancel_consult_repository.dart';

class CancelConsultRepositoryImpl extends CancelConsultRepository {
  final ChopperClient chopperClient;
  CancelConsultRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, CancelConsultResponse>> cancelConsult(
      int consultId) async {
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    final service = chopperClient.getService<ServiceCancelConsults>();
    var cancelConsult = await service.cancelConsult(
        CancelConsultRequest(consultId: consultId), token.toString());
    if (cancelConsult.isSuccessful) {
      final result = getConsults({'cancelConsultSuccess': true});
      return Right(result);
    } else {
      return Left(ServerFailure(
          modelServer: getError(cancelConsult.error as Map<String, dynamic>)));
    }
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  CancelConsultResponse getConsults(Map<String, dynamic> json) {
    return CancelConsultResponse.fromJson(json);
  }
}
