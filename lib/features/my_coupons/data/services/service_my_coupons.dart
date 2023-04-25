import 'package:app/features/my_coupons/data/models/transfer_coupon_request.dart';
import 'package:chopper/chopper.dart';

part 'service_my_coupons.chopper.dart';

@ChopperApi()
abstract class ServiceMyCoupons extends ChopperService {
  static ServiceMyCoupons create([ChopperClient? client]) =>
      _$ServiceMyCoupons(client);

  @Get(path: '/services/remaining-consults/{userId}')
  Future<Response> getRemainingConsults(@Header('Authorization') String token,
      @Path('userId') String userId, @QueryMap() Map<String, dynamic> query);

  @Post(path: 'account/share_consult')
  Future<Response> transferCoupon(@Header('Authorization') String token,
      @Body() TransferCouponRequest body);

  @Get(path: '/services/remaining-consults/{userId}/{couponId}/{couponType}')
  Future<Response> getConsultDettail(
    @Header('Authorization') String token,
    @Path('userId') String userId,
    @Path('couponId') String couponId,
    @Path('couponType') String couponType,
  );

  @Post(path: 'services/exchange_coupon')
  Future<Response> sendCode(
      @Header('Authorization') String token, @Body() body);
}
