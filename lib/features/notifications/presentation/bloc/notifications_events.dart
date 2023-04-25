import 'package:app/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class DisposeLoading extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class GetNotitications extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class ListAllNotification extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class ListViewNotification extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class ListNewNotification extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class DeleteNotification extends NotificationsEvent {
  final int position;
  final ListTypeNotifications type;

  const DeleteNotification({required this.position, required this.type});

  @override
  List<Object?> get props => [position, type];
}

class NotifyViewedNotification extends NotificationsEvent {
  final String viewedNotification;

  const NotifyViewedNotification({required this.viewedNotification});

  @override
  List<Object?> get props => [viewedNotification];
}

class NotifyServerViewedNotification extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}

class SelectAllAsReaded extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}
