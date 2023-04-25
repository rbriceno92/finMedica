import 'dart:ui';

import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'notification_type.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  final String title;
  final NotificationType type;
  @JsonKey(name: 'is_read')
  final bool isRead;
  final String metadata;
  final String createdAt;
  final String updatedAt;

  const NotificationModel(
      {required this.id,
      required this.type,
      required this.userId,
      required this.content,
      required this.title,
      required this.isRead,
      required this.metadata,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props => [
        id,
        type,
        userId,
        content,
        title,
        isRead,
        metadata,
        createdAt,
        updatedAt
      ];

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  String getNotificationIcon() {
    switch (type) {
      case NotificationType.SCHEDULE:
        return iconConsults2;
      case NotificationType.CANCELED:
        return iconCancelWhite;
      case NotificationType.GROUP_ADDED:
        return iconGroup;
      case NotificationType.REINTEGRED:
        return iconCupon;
      case NotificationType.GROUP_OUT:
        return iconGroup;
    }
  }

  Color getColorNotification() {
    switch (type) {
      case NotificationType.SCHEDULE:
        return ColorsFM.green40;
      case NotificationType.CANCELED:
        return ColorsFM.errorColor;
      case NotificationType.GROUP_ADDED:
        return ColorsFM.blueDark90;
      case NotificationType.REINTEGRED:
        return ColorsFM.green80;
      case NotificationType.GROUP_OUT:
        return ColorsFM.blueDark90;
    }
  }
}
