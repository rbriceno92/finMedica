import 'package:equatable/equatable.dart';

class NotificationsSettingsState extends Equatable {
  final bool toggleStatus;
  final bool loading;

  const NotificationsSettingsState(
      {this.toggleStatus = true, this.loading = false});

  NotificationsSettingsState copyWith({bool? toggleStatus, bool? loading}) {
    return NotificationsSettingsState(
        toggleStatus: toggleStatus ?? this.toggleStatus,
        loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [toggleStatus, loading];
}
