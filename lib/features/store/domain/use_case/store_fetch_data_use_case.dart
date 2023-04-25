import 'package:app/features/store/data/models/product_list_response.dart';
import 'package:app/features/store/domain/repository/store_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class StoreFetchDataUseCase
    extends UseCase<ProductListResponse, ParametroVacio> {
  final StoreRepository repository;

  StoreFetchDataUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, ProductListResponse>> call(param) async {
    return await repository.fetchData();
  }
}
