import 'package:equatable/equatable.dart';

abstract class NotificationsSettingsEvent extends Equatable {
  const NotificationsSettingsEvent();
}

class ChangeToggle extends NotificationsSettingsEvent {
  @override
  List<Object?> get props => [];
}
