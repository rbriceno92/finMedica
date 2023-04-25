import 'dart:async';

import 'package:app/features/notifications/domain/use_cases/get_notification_use_case.dart';
import 'package:app/features/notifications/domain/use_cases/notify_use_notification_server.dart';
import 'package:app/features/notifications/presentation/bloc/notifications_events.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/user_preferences_save.dart';
import '../../domain/use_cases/delete_notification_use_case.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationState> {
  GetNotificationUseCase useCase;
  UserPreferenceDao preferenceDao;
  DeleteNotificationUseCase deleteNotificationUseCase;
  NotifyUseNotificationServer notifyServerViewedNotificationUseCase;

  NotificationsBloc(
      {required this.useCase,
      required this.preferenceDao,
      required this.deleteNotificationUseCase,
      required this.notifyServerViewedNotificationUseCase})
      : super(NotificationState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<GetNotitications>(_onGetNotification);
    on<ListAllNotification>(_onListAllNotification);
    on<ListViewNotification>(_onListViewNotification);
    on<ListNewNotification>(_onListNewNotification);
    on<DeleteNotification>(_onDeleteNotification);
    on<NotifyViewedNotification>(_OnNotifyViewedNotification);
    on<NotifyServerViewedNotification>(_onNotifyServerViewedNotification);
    on<SelectAllAsReaded>(_onSelectAllAsReaded);
  }

  FutureOr<void> _onDisposeLoading(
      DisposeLoading event, Emitter<NotificationState> emit) {
    emit(state.copyWith(loading: LoadingState.close));
  }

  FutureOr<void> _onGetNotification(
      GetNotitications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var user = await preferenceDao.getUser();
    await user.fold((l) => null, (r) async {
      final response = await useCase.call(r.userId ?? '');

      response.fold((l) => null, (r) async {
        var list = r.where((element) => !element.isRead).toList();
        var listViewed = r.where((element) => element.isRead).toList();
        emit(state.copyWith(
            loading: LoadingState.close,
            response: list,
            oldNotifications: listViewed));
      });
    });
  }

  FutureOr<void> _onListAllNotification(
      ListAllNotification event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(type: ListTypeNotifications.ALL));
  }

  FutureOr<void> _onListViewNotification(
      ListViewNotification event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(type: ListTypeNotifications.VIEWS));
  }

  FutureOr<void> _onListNewNotification(
      ListNewNotification event, Emitter<NotificationState> emit) {
    emit(state.copyWith(type: ListTypeNotifications.NEW));
  }

  FutureOr<void> _onDeleteNotification(
      DeleteNotification event, Emitter<NotificationState> emit) {
    emit(state.copyWith(loading: LoadingState.show));
    if (event.type == ListTypeNotifications.NEW) {
      var notification = state.response.elementAt(event.position);
      deleteNotificationUseCase.call(notification.id);
      state.response.removeAt(event.position);
    } else if (event.type == ListTypeNotifications.VIEWS) {
      var notification = state.oldNotifications.elementAt(event.position);
      deleteNotificationUseCase.call(notification.id);
      state.oldNotifications.removeAt(event.position);
    }
    emit(state.copyWith(
        oldNotifications: state.oldNotifications,
        response: state.response,
        loading: LoadingState.close,
        deletingNotitication: true));
  }

  FutureOr<void> _OnNotifyViewedNotification(
      NotifyViewedNotification event, Emitter<NotificationState> emit) {
    if (!(state.notificationsViewedToNotify
        .contains(event.viewedNotification))) {
      state.notificationsViewedToNotify =
          List.from(state.notificationsViewedToNotify)
            ..add(event.viewedNotification);
    }
  }

  FutureOr<void> _onNotifyServerViewedNotification(
      NotifyServerViewedNotification event,
      Emitter<NotificationState> emit) async {
    if (state.notificationsViewedToNotify!.isNotEmpty &&
        !state.markAsReadSelected) {
      await notifyServerViewedNotificationUseCase
          .call(state.notificationsViewedToNotify);
    }
  }

  FutureOr<void> _onSelectAllAsReaded(
      SelectAllAsReaded event, Emitter<NotificationState> emit) async {
    var list = state.response.map((e) => e.id).toList();
    var listNotificationsNotViewed =
        List.from(state.notificationsViewedToNotify);
    list.forEach((element) {
      if (!listNotificationsNotViewed.contains(element)) {
        listNotificationsNotViewed.add(element);
      }
    });

    var serverResponse = await notifyServerViewedNotificationUseCase
        .call(state.notificationsViewedToNotify);

    serverResponse.fold((l) => null, (r) {
      state.response.addAll(state.oldNotifications);

      emit(state.copyWith(
          response: List.empty(),
          oldNotifications: state.response,
          markAsReadSelected: true));
    });
  }
}
