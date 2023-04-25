import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';

import 'package:dartz/dartz.dart';

import '../../data/models/frequent_questions_response.dart';
import '../repositories/frequent_questions_repositories.dart';

class FrequentQuestionsUseCase
    extends UseCase<FrequentQuestionsResponse, ParametroVacio> {
  final FrequentQuestionsRepository repository;

  FrequentQuestionsUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, FrequentQuestionsResponse>> call(
      ParametroVacio param) async {
    return await repository.frequentQuestions();
  }
}
