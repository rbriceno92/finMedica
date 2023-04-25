import 'package:app/features/notifications/presentation/bloc/settings/notifications_settings_events.dart';
import 'package:app/features/notifications/presentation/bloc/settings/notifications_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsSettingsBloc
    extends Bloc<NotificationsSettingsEvent, NotificationsSettingsState> {
  NotificationsSettingsBloc() : super(const NotificationsSettingsState()) {
    on<ChangeToggle>(_onChangeToggle);
  }

  void _onChangeToggle(
      ChangeToggle event, Emitter<NotificationsSettingsState> emit) {
    emit(state.copyWith(toggleStatus: !state.toggleStatus));
  }
}
