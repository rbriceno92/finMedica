import 'package:app/features/terms_conditions/data/models/terms_conditions_response.dart';
import 'package:app/features/terms_conditions/domain/repositories/terms_conditions_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';

import 'package:dartz/dartz.dart';

class TermsConditionsUseCase
    extends UseCase<TermsConditionsResponse, ParametroVacio> {
  final TermsConditionsRepository repository;

  TermsConditionsUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, TermsConditionsResponse>> call(
      ParametroVacio param) async {
    return await repository.termsConditions(param);
  }
}
