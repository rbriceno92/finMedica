import 'package:app/features/store/data/models/product_list_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class StoreRepository {
  Future<Either<ErrorGeneral, ProductListResponse>> fetchData();
}
