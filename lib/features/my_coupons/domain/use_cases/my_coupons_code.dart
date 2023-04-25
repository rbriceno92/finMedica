import 'package:app/features/my_coupons/data/models/my_coupons_code_response.dart';
import 'package:app/features/my_coupons/domain/repository/my_coupons_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class MyCouponsCodeUseCase extends UseCase<MyCouponsCodeResponse, int> {
  final MyCouponsRepository repository;

  MyCouponsCodeUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, MyCouponsCodeResponse>> call(int param) async {
    return await repository.sendCode(param);
  }
}
