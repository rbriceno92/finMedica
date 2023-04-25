import 'package:app/features/dashboard/data/models/next_consults_request.dart';
import 'package:chopper/chopper.dart';

import '../models/consult_private_params.dart';
import '../models/reschedule_appointment_param.dart';

part 'services_consults.chopper.dart';

@ChopperApi()
abstract class ServiceConsults extends ChopperService {
  static ServiceConsults create([ChopperClient? client]) =>
      _$ServiceConsults(client);

  @Post(path: 'account/next_consults')
  Future<Response> getNextConsults(
      @Body() NextConsultRequest nextConsultRequest,
      @Header('Authorization') String token);

  @Get(path: 'consult/details/{consultId}')
  Future<Response> getConsultDetails(
      @Path() int consultId, @Header('Authorization') String token);

  @Post(path: 'account/consult_privacy')
  Future<Response> makeConsultPrivacy(
      @Body() ConsultPrivateParams consultPrivateParams,
      @Header('Authorization') String token);

  @Post(path: 'appointment/reschedule')
  Future<Response> rescheduleAppointment(
    @Header('Authorization') String token,
    @Body() RescheduleAppointmentParam params,
  );

  @Get(path: 'consult/doctor_photo/{profesionalPersonaId}')
  Future<Response> getDoctorPhoto(
      @Path() int profesionalPersonaId, @Header('Authorization') String token);
}
