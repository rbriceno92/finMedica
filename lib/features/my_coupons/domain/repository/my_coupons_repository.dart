import 'package:app/features/my_coupons/data/models/coupon_detail_request.dart';
import 'package:app/features/my_coupons/data/models/coupon_detail_response.dart';
import 'package:app/features/my_coupons/data/models/my_coupons_code_response.dart';
import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/data/models/remaining_consults_response.dart';
import 'package:app/features/my_coupons/data/models/transfer_coupon_request.dart';
import 'package:app/features/my_coupons/data/models/transfer_coupon_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class MyCouponsRepository {
  Future<Either<ErrorGeneral, MyCouponsCodeResponse>> sendCode(int code);

  Future<Either<ErrorGeneral, RemainingConsults>> getRemainingCoupons(
      RemainingCouponsRequest request);

  Future<Either<ErrorGeneral, TransferCouponResponse>> transferCoupon(
      TransferCouponRequest request);

  Future<Either<ErrorGeneral, CouponDetailResponse>> getCouponDetail(
      CouponDetailRequest request);
}
