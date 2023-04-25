import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/frequent_questions_response.dart';

abstract class FrequentQuestionsRepository {
  Future<Either<ErrorGeneral, FrequentQuestionsResponse>> frequentQuestions();
}
