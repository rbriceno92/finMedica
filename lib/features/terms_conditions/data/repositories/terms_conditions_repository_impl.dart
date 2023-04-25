import 'dart:io';

import 'package:app/features/terms_conditions/data/models/terms_conditions_response.dart';
import 'package:app/features/terms_conditions/data/services/service_terms_conditions.dart';
import 'package:app/features/terms_conditions/domain/repositories/terms_conditions_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

class TermsConditionsRepositoryImpl implements TermsConditionsRepository {
  final ChopperClient chopperClient;

  TermsConditionsRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, TermsConditionsResponse>> termsConditions(
      ParametroVacio request) async {
    final service = chopperClient.getService<ServiceTermsConditions>();
    try {
      final response = await service.termsConditions();

      if (response.isSuccessful) {
        final result = getResult(response.bodyString);
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

  TermsConditionsResponse getResult(String body) {
    return TermsConditionsResponse(message: body);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
