import 'package:app/features/payments/data/models/create_payment_method_request.dart';
import 'package:chopper/chopper.dart';

part 'service_user_payment_methods.chopper.dart';

@ChopperApi()
abstract class ServiceUserPaymentMethods extends ChopperService {
  static ServiceUserPaymentMethods create([ChopperClient? client]) =>
      _$ServiceUserPaymentMethods(client);

  @Get(path: 'user-payment-methods/{stripe_customer_id}')
  Future<Response> getPaymentMethods(@Header('Authorization') String token,
      @Path('stripe_customer_id') String stripeCustomerId);

  @Post(path: 'user-payment-methods')
  Future<Response> createPaymentMethod(
    @Header('Authorization') String token,
    @Body() CreatePaymentMethodRequest request,
  );

  @Delete(path: 'user-payment-methods/{stripe_customer_id}/{payment_method_id}')
  Future<Response> deletePaymentMethod(
    @Header('Authorization') String token,
    @Path('stripe_customer_id') String stripeCustomerId,
    @Path('payment_method_id') String paymentMethodId,
  );
}
