import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';

class NotificationState extends Equatable {
  final LoadingState loading;
  final List<NotificationModel> response;
  final List<NotificationModel> oldNotifications;
  final ListTypeNotifications type;
  final bool deletingNotification;
  List<String> notificationsViewedToNotify;
  final bool markAsReadSelected;

  NotificationState(
      {this.loading = LoadingState.dispose,
      this.response = const [],
      this.type = ListTypeNotifications.ALL,
      this.deletingNotification = false,
      this.oldNotifications = const [],
      this.notificationsViewedToNotify = const [],
      this.markAsReadSelected = false});

  NotificationState copyWith(
      {LoadingState? loading,
      List<NotificationModel>? response,
      ListTypeNotifications? type,
      bool? deletingNotitication,
      List<NotificationModel>? oldNotifications,
      List<String>? notificationsViewedToNotify,
      bool? markAsReadSelected}) {
    return NotificationState(
        loading: loading ?? this.loading,
        response: response ?? this.response,
        type: type ?? this.type,
        deletingNotification: deletingNotification ?? false,
        oldNotifications: oldNotifications ?? this.oldNotifications,
        notificationsViewedToNotify:
            notificationsViewedToNotify ?? this.notificationsViewedToNotify,
        markAsReadSelected: markAsReadSelected ?? this.markAsReadSelected);
  }

  @override
  List<Object?> get props => [
        loading,
        response,
        type,
        deletingNotification,
        oldNotifications,
        notificationsViewedToNotify,
        markAsReadSelected
      ];
}

enum ListTypeNotifications { ALL, NEW, VIEWS }
