import 'dart:io';

import 'package:app/features/store/data/models/product_list_response.dart';
import 'package:app/features/store/data/services/service_product.dart';
import 'package:app/features/store/domain/repository/store_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

class StoreRepositoryImpl implements StoreRepository {
  final ChopperClient chopperClient;

  StoreRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, ProductListResponse>> fetchData() async {
    final service = chopperClient.getService<ServiceProduct>();

    try {
      final response = await service.productList();
      if (response.isSuccessful) {
        final result = getResult(response.body);
        return Right(result);
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

  ProductListResponse getResult(Map<String, dynamic> body) {
    return ProductListResponse.fromJson(body);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
