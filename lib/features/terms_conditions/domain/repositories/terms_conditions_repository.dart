import 'package:app/features/terms_conditions/data/models/terms_conditions_response.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

abstract class TermsConditionsRepository {
  Future<Either<ErrorGeneral, TermsConditionsResponse>> termsConditions(
      ParametroVacio request);
}
