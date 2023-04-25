import 'dart:io';

import 'package:app/features/contact_us/data/models/contact_us_data_request.dart';
import 'package:app/features/contact_us/domain/repository/contact_us_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../services/service_contact.dart';

class ContactUsRepositoryImpl implements ContactUsRepository {
  final ChopperClient chopperClient;
  ContactUsRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, Map>> sendData(ContactUsDataRequest param) async {
    final service = chopperClient.getService<ServiceContact>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    try {
      var contact = await service.postContact(param, token ?? '');
      if (contact.isSuccessful) {
        return Right(contact.body);
      } else {
        return Left(ServerFailure(
            modelServer: getError(contact.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
