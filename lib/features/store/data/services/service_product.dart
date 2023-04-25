import 'package:chopper/chopper.dart';

part 'service_product.chopper.dart';

@ChopperApi()
abstract class ServiceProduct extends ChopperService {
  static ServiceProduct create([ChopperClient? client]) =>
      _$ServiceProduct(client);

  @Get(path: 'products/product-list')
  Future<Response> productList();
}
