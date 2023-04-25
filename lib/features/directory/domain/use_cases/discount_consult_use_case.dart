import 'package:app/features/directory/data/models/discounts_consult_param.dart';
import 'package:app/features/directory/data/models/discounts_consult_response.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repositories/directory_repository.dart';

class DiscountConsultUseCase
    extends UseCase<DiscountsConsultResponde, DiscountsConsultParam> {
  final DirectoryRepository repository;

  DiscountConsultUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, DiscountsConsultResponde>> call(
      DiscountsConsultParam param) async {
    return await repository.discountsConsult(param);
  }
}
