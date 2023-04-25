import 'package:app/features/my_coupons/data/models/coupon_detail_request.dart';
import 'package:app/features/my_coupons/data/models/coupon_detail_response.dart';
import 'package:app/features/my_coupons/domain/repository/my_coupons_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetCouponDetailUseCase
    extends UseCase<CouponDetailResponse, CouponDetailRequest> {
  final MyCouponsRepository repository;

  GetCouponDetailUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, CouponDetailResponse>> call(
      CouponDetailRequest param) async {
    return await repository.getCouponDetail(param);
  }
}
