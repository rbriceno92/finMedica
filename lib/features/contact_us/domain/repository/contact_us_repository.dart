import 'package:app/features/contact_us/data/models/contact_us_data_request.dart';
import 'package:app/util/failure.dart';

import 'package:dartz/dartz.dart';

abstract class ContactUsRepository {
  Future<Either<ErrorGeneral, Map>> sendData(ContactUsDataRequest param);
}
