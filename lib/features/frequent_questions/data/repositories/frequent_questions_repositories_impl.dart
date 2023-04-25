import 'dart:io';

import 'package:app/features/frequent_questions/data/models/frequent_questions_response.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

import '../services/service_frequent_questions.dart';
import '../../domain/repositories/frequent_questions_repositories.dart';

class FrequentQuestionsRepositoryImpl implements FrequentQuestionsRepository {
  final ChopperClient chopperClient;

  FrequentQuestionsRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, FrequentQuestionsResponse>>
      frequentQuestions() async {
    final service = chopperClient.getService<ServiceFrequentQuestions>();

    try {
      final response = await service.frequentQuestions();
      if (response.isSuccessful) {
        final result = getResult(response.body);
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

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  getResult(List bodyString) {
    return FrequentQuestionsResponse(result: bodyString);
  }
}
