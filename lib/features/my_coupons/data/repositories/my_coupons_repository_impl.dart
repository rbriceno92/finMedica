import 'dart:io';

import 'package:app/core/di/modules.dart';
import 'package:app/features/my_coupons/data/models/coupon_detail_request.dart';
import 'package:app/features/my_coupons/data/models/coupon_detail_response.dart';
import 'package:app/features/my_coupons/data/models/my_coupons_code_response.dart';
import 'package:app/features/my_coupons/data/models/remaining_coupons_request.dart';
import 'package:app/features/my_coupons/data/models/remaining_consults_response.dart';
import 'package:app/features/my_coupons/data/models/transfer_coupon_response.dart';
import 'package:app/features/my_coupons/data/models/transfer_coupon_request.dart';
import 'package:app/features/my_coupons/data/services/service_my_coupons.dart';
import 'package:app/features/my_coupons/domain/repository/my_coupons_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/my_coupons_code_request.dart';

class MyCouponsRepositoryImpl implements MyCouponsRepository {
  final ChopperClient chopperClient;

  MyCouponsRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, RemainingConsults>> getRemainingCoupons(
      RemainingCouponsRequest request) async {
    final service = chopperClient.getService<ServiceMyCoupons>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.getRemainingConsults(
          token ?? '', request.userId, request.getQueryMap());

      if (response.isSuccessful) {
        return Right(RemainingConsults.fromJson(response.body));
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, TransferCouponResponse>> transferCoupon(
      TransferCouponRequest request) async {
    final service = chopperClient.getService<ServiceMyCoupons>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.transferCoupon(token ?? '', request);

      if (response.isSuccessful) {
        return Right(TransferCouponResponse.fromJson(response.body));
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, CouponDetailResponse>> getCouponDetail(
      CouponDetailRequest request) async {
    final service = chopperClient.getService<ServiceMyCoupons>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.getConsultDettail(
          token ?? '', request.userId, request.couponId, request.type);

      if (response.isSuccessful) {
        return Right(CouponDetailResponse.fromJson(response.body));
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, MyCouponsCodeResponse>> sendCode(int code) async {
    final service = chopperClient.getService<ServiceMyCoupons>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.sendCode(
          token.toString(), MyCouponsCodeRequest(code: code));
      if (response.isSuccessful) {
        return Right(MyCouponsCodeResponse(message: response.body['message']));
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
