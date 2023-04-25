import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/data/models/remaining_consults_response.dart';
import 'package:app/features/my_coupons/domain/repository/my_coupons_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetCouponsAvailableUseCase
    extends UseCase<RemainingConsults, RemainingCouponsRequest> {
  final MyCouponsRepository repository;

  GetCouponsAvailableUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, RemainingConsults>> call(
      RemainingCouponsRequest param) async {
    return await repository.getRemainingCoupons(param);
  }
}
