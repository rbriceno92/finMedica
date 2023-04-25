import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/directory/data/models/discounts_consult_param.dart';
import 'package:app/features/directory/data/models/schedule_doctor_param.dart';
import 'package:chopper/chopper.dart';

part 'directory_services.chopper.dart';

@ChopperApi()
abstract class ServiceDirectory extends ChopperService {
  static ServiceDirectory create([ChopperClient? client]) =>
      _$ServiceDirectory(client);

  @Get(path: '/hospital/{hospitalId}/doctors')
  Future<Response> getDirectory(
      @Header('Authorization') String token,
      @Path() int hospitalId,
      @Query() int? speciality,
      @Query() String? lastName);

  @Get(path: '/specialty')
  Future<Response> getSpecialities(@Header('Authorization') String token);

  @Get(path: '/clinic/default')
  Future<Response> getClinic(@Header('Authorization') String token);

  @Post(path: '/account/doctorschedule')
  Future<Response> getScheduleDoctor(@Header('Authorization') String token,
      @Body() ScheduleDoctorParam scheduleDoctorParam);

  @Post(path: '/account/bookappointment')
  Future<Response> bookAppointment(
    @Header('Authorization') String token,
    @Body() BookAppointmentParams params,
  );

  @Get(path: '/services/remaining-consults/{userId}')
  Future<Response> getRemainingConsults(
      @Header('Authorization') String token, @Path('userId') String userId);

  @Post(path: '/services/discount-consults')
  Future<Response> discountConsult(
    @Header('Authorization') String token,
    @Body() DiscountsConsultParam params,
  );
}
