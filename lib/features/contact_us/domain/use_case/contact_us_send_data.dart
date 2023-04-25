import 'package:app/features/contact_us/data/models/contact_us_data_request.dart';
import 'package:app/features/contact_us/domain/repository/contact_us_repository.dart';

import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class ContactUsSendDataUseCase extends UseCase<Map, ContactUsDataRequest> {
  final ContactUsRepository repository;

  ContactUsSendDataUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, Map>> call(ContactUsDataRequest param) async {
    return await repository.sendData(param);
  }
}
