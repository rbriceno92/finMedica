import 'package:app/core/di/modules.dart';
import 'package:app/features/notifications/presentation/bloc/settings/notifications_settings_bloc.dart';
import 'package:app/features/notifications/presentation/bloc/settings/notifications_settings_events.dart';
import 'package:app/features/notifications/presentation/bloc/settings/notifications_settings_state.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsSettingsBloc>(),
      child: const NotificationsScreenView(),
    );
  }
}

class NotificationsScreenView extends StatelessWidget {
  const NotificationsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsSettingsBloc, NotificationsSettingsState>(
      builder: (context, state) => Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
          title: Text(Languages.of(context).configuration),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: marginStandard,
              vertical: mediumMargin,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(Languages.of(context).notifications,
                  style: TypefaceStyles.poppinsSemiBold22
                      .copyWith(color: ColorsFM.primary)),
              const SizedBox(
                height: largeMargin,
                width: largeMargin,
              ),
              Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.of(context).showNotifications,
                          style: TypefaceStyles.bodyMediumMontserrat
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: extraSmallMargin,
                          width: extraSmallMargin,
                        ),
                        Text(Languages.of(context).notificationsExplain,
                            style: TypefaceStyles.bodySmallMontserrat12),
                      ]),
                ),
                const SizedBox(
                  height: marginStandard,
                  width: marginStandard,
                ),
                FlutterSwitch(
                  value: state.toggleStatus,
                  height: 30,
                  width: 50,
                  activeColor: ColorsFM.green40,
                  inactiveColor: ColorsFM.green80,
                  switchBorder: Border.all(
                    color: ColorsFM.green40,
                    width: 2,
                  ),
                  activeToggleColor: ColorsFM.green80,
                  inactiveToggleColor: ColorsFM.green40,
                  toggleSize: 20,
                  padding: 2,
                  onToggle: (val) {
                    context
                        .read<NotificationsSettingsBloc>()
                        .add(ChangeToggle());
                  },
                ),
                const SizedBox(
                  height: extraSmallMargin,
                  width: extraSmallMargin,
                ),
              ]),
            ]),
          ),
        ),
      ),
      listener: (context, state) {},
      listenWhen: (prevState, state) {
        return prevState != state;
      },
    );
  }
}
