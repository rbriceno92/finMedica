import 'package:app/features/my_coupons/data/models/transfer_coupon_request.dart';
import 'package:app/features/my_coupons/data/models/transfer_coupon_response.dart';
import 'package:app/features/my_coupons/domain/repository/my_coupons_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class TransferCouponUseCase
    extends UseCase<TransferCouponResponse, TransferCouponRequest> {
  final MyCouponsRepository repository;

  TransferCouponUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, TransferCouponResponse>> call(
      TransferCouponRequest param) async {
    return await repository.transferCoupon(param);
  }
}
