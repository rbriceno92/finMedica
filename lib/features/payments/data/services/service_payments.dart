import 'package:app/features/payments/data/models/create_payment_request.dart';
import 'package:app/features/payments/data/models/payment_config_request.dart';
import 'package:chopper/chopper.dart';

part 'service_payments.chopper.dart';

@ChopperApi()
abstract class ServicePayments extends ChopperService {
  static ServicePayments create([ChopperClient? client]) =>
      _$ServicePayments(client);

  @Post(path: 'payments/payment-config')
  Future<Response> getPaymentConfig(@Body() PaymentConfigRequest request,
      @Header('Authorization') String token);

  @Post(path: 'payments/create-payment')
  Future<Response> createPaymentIntent(@Body() CreatePaymentRequest request,
      @Header('Authorization') String token);
}
