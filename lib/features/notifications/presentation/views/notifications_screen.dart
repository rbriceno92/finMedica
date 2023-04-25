import 'package:app/core/di/modules.dart';
import 'package:app/features/notifications/data/models/notification_model.dart';
import 'package:app/features/notifications/presentation/bloc/notifications_events.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';
import '../../data/models/notification_type.dart';
import '../bloc/notifications_bloc.dart';
import '../bloc/notifications_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationsBloc>()..add(GetNotitications()),
      child: NotificationScreenView(),
    );
  }
}

class NotificationScreenView extends StatelessWidget {
  const NotificationScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context
                .read<NotificationsBloc>()
                .add(NotifyServerViewedNotification());
            return true;
          },
          child: Scaffold(
            backgroundColor: ColorsFM.primaryLight99,
            appBar: AppBar(
              title: Text(Languages.of(context).notifications),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.only(
                          top: mediumMargin, right: 24, left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                color: ColorsFM.primaryLight80,
                                borderRadius: BorderRadius.circular(24)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FilterSingleButton(
                                    label: Languages.of(context).allText,
                                    onPressed: () {
                                      context
                                          .read<NotificationsBloc>()
                                          .add(ListAllNotification());
                                    },
                                    selected:
                                        state.type == ListTypeNotifications.ALL,
                                  ),
                                  FilterSingleButton(
                                      label: Languages.of(context).News,
                                      onPressed: () {
                                        context
                                            .read<NotificationsBloc>()
                                            .add(ListNewNotification());
                                      },
                                      selected: state.type ==
                                          ListTypeNotifications.NEW),
                                  FilterSingleButton(
                                      label: Languages.of(context).Views,
                                      onPressed: () {
                                        context
                                            .read<NotificationsBloc>()
                                            .add(ListViewNotification());
                                      },
                                      selected: state.type ==
                                          ListTypeNotifications.VIEWS),
                                ]),
                          ),
                          SizedBox(
                            height: marginStandard,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: (hasToShowEmptyState(state))
                        ? Container(
                            height: double.infinity,
                            child: Center(child: EmptyNotificationState()))
                        : SingleChildScrollView(child: ListNotifications()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool hasToShowEmptyState(NotificationState state) {
    if (state.type != ListTypeNotifications.ALL) {
      if (state.type == ListTypeNotifications.NEW && state.response.isEmpty) {
        return true;
      } else if (state.type == ListTypeNotifications.VIEWS &&
          state.oldNotifications.isEmpty) {
        return true;
      } else {
        return false;
      }
    } else if (state.response.isEmpty && state.oldNotifications.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

class ListNotifications extends StatelessWidget {
  const ListNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          (state.type == ListTypeNotifications.ALL ||
                  state.type == ListTypeNotifications.NEW)
              ? ListNotificationWidget(
                  list: state.response, type: ListTypeNotifications.NEW)
              : Container(),
          (state.type == ListTypeNotifications.ALL ||
                  state.type == ListTypeNotifications.VIEWS)
              ? ListNotificationWidget(
                  list: state.oldNotifications,
                  type: ListTypeNotifications.VIEWS)
              : Container()
        ]);
      },
    );
  }
}

class ListNotificationWidget extends StatelessWidget {
  final List<NotificationModel> list;
  final ListTypeNotifications type;
  const ListNotificationWidget(
      {Key? key, required this.list, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.type != ListTypeNotifications.ALL && list.isEmpty
            ? Container()
            : Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: marginStandard),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (state.type == ListTypeNotifications.ALL &&
                                list.isNotEmpty)
                            ? Text(
                                type == ListTypeNotifications.NEW
                                    ? Languages.of(context).News
                                    : Languages.of(context).oldNotifications,
                                style: TypefaceStyles.poppinsSemiBold24Primary,
                              )
                            : Container(),
                        (type == ListTypeNotifications.NEW &&
                                state.type == ListTypeNotifications.ALL &&
                                list.isNotEmpty)
                            ? GestureDetector(
                                onTap: () {
                                  context
                                      .read<NotificationsBloc>()
                                      .add(SelectAllAsReaded());
                                },
                                child: Text(
                                  Languages.of(context).selectAsRead,
                                  style: TypefaceStyles.bodyMediumMontserrat
                                      .copyWith(color: ColorsFM.green40),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, position) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: minMargin),
                          child: VisibilityDetector(
                            key: Key(list[position].id),
                            onVisibilityChanged: (VisibilityInfo info) {
                              if (info.visibleFraction > 0.80 &&
                                  !list[position].isRead) {
                                context.read<NotificationsBloc>().add(
                                    NotifyViewedNotification(
                                        viewedNotification: list[position].id));
                              }
                            },
                            child: Slidable(
                                closeOnScroll: false,
                                direction: Axis.horizontal,
                                key: UniqueKey(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: marginStandard),
                                  child: CardNotification(
                                      notification: list[position]),
                                ),
                                endActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),
                                  // A pane can dismiss the Slidable.
                                  dismissible: DismissiblePane(onDismissed: () {
                                    context.read<NotificationsBloc>().add(
                                        DeleteNotification(
                                            position: position, type: type));
                                  }),

                                  // All actions are defined in the children parameter.
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    CustomSlidableAction(
                                      flex: 1,
                                      padding: EdgeInsets.symmetric(
                                          vertical: marginStandard),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      onPressed: (context) {
                                        context.read<NotificationsBloc>().add(
                                            DeleteNotification(
                                                position: position,
                                                type: type));
                                      },
                                      backgroundColor: ColorsFM.errorColor,
                                      foregroundColor: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              iconDelete,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              Languages.of(context).delete,
                                              style: TypefaceStyles
                                                  .poppinsSemiBold
                                                  .copyWith(
                                                      color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      })
                ],
              );
      },
    );
  }
}

class CardNotification extends StatelessWidget {
  final NotificationModel notification;
  const CardNotification({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: ColorsFM.primaryLight80, width: 2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(48),
                  child: Container(
                      width: 64,
                      height: 64,
                      color: notification.getColorNotification(),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          notification.getNotificationIcon(),
                          width: 32,
                          height: 32,
                          color: Colors.white,
                        ),
                      ))),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  right: marginStandard,
                  top: marginStandard,
                  bottom: marginStandard,
                  left: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.content,
                    textAlign: TextAlign.start,
                    style: notification.type == NotificationType.GROUP_ADDED
                        ? TypefaceStyles.poppinsMedium16
                            .copyWith(color: ColorsFM.neutralDark, height: 0)
                        : TypefaceStyles.poppinsRegular.copyWith(fontSize: 15),
                  ),
                  (notification.type == NotificationType.GROUP_ADDED ||
                          notification.type == NotificationType.REINTEGRED)
                      ? Container()
                      : Text(
                          'Paciente: ',
                          textAlign: TextAlign.start,
                          style: TypefaceStyles.bodyMediumMontserrat
                              .copyWith(color: ColorsFM.neutralDark),
                        )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class EmptyNotificationState extends StatelessWidget {
  const EmptyNotificationState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Languages.of(context).emptyNotifications,
              style: TypefaceStyles.poppinsSemiBold
                  .copyWith(color: ColorsFM.blueDark90, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Text(
              Languages.of(context).emptyNotificationsTwo,
              style: TypefaceStyles.bodyMediumMontserrat
                  .copyWith(color: ColorsFM.primary80, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}

class FilterSingleButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool selected;

  const FilterSingleButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
        backgroundColor: ColorsFM.primaryLight80,
        selectedColor: ColorsFM.primary,
        disabledColor: ColorsFM.primaryLight80,
        showCheckmark: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        selected: selected,
        onSelected: (bool value) {
          if (onPressed != null) {
            onPressed!();
          }
        },
        labelPadding: const EdgeInsets.symmetric(horizontal: marginStandard),
        label: Text(label),
        labelStyle: TypefaceStyles.poppinsRegular.copyWith(
            fontSize: 13, color: selected ? Colors.white : ColorsFM.primary60),
      ),
    );
  }
}
