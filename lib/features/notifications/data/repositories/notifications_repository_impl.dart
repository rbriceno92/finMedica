import 'dart:convert';
import 'dart:io';

import 'package:app/features/notifications/data/models/notification_model.dart';
import 'package:app/features/notifications/data/services/notifications_service.dart';
import 'package:app/features/notifications/domain/repository/notifications_repository.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/constants/constants.dart';
import '../../../../util/models/error_model_server.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final ChopperClient chopperClient;

  NotificationRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, List<NotificationModel>>> getNotifications(
      String userId) async {
    final service = chopperClient.getService<ServiceNotification>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response = await service.getNotificationsList(userId, token ?? '');
      if (response.isSuccessful) {
        final notificationList = getListNotifications(response.body);
        return Right(notificationList);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  List<NotificationModel> getListNotifications(List<dynamic> body) {
    List<NotificationModel> list = [];
    body.forEach((element) {
      list.add(NotificationModel.fromJson(element));
    });
    return list;
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }

  @override
  Future<Either<ErrorGeneral, bool>> deleteNotification(
      String notificationId) async {
    final service = chopperClient.getService<ServiceNotification>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response =
          await service.deleteNotification(notificationId, token ?? '');
      if (response.isSuccessful) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, bool>> viewedNotifications(
      List<String> list) async {
    final service = chopperClient.getService<ServiceNotification>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response = await service.viewedNotifications(list, token ?? '');
      if (response.isSuccessful) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }
}
