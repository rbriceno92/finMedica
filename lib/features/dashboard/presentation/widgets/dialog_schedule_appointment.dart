import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/dimens.dart';

class ScheduleAppointmentDashboard {
  static Future<void> showScheduleAppointmentDialog(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(marginStandard),
            topRight: Radius.circular(marginStandard),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 2,
                    width: 55,
                    color: ColorsFM.blackIndicator,
                  ),
                  Text(
                    Languages.of(context).dialogScheduleAppointmentTitle,
                    textAlign: TextAlign.center,
                    style: TypefaceStyles.poppinsSemiBold40.copyWith(
                        fontSize: 18,
                        color: ColorsFM.primary,
                        letterSpacing: 0.15,
                        height: 1.4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      optionToShedule(UserGroupType.user, context),
                      optionToShedule(UserGroupType.group, context)
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static Widget optionToShedule(UserGroupType type, BuildContext context) {
    return GestureDetector(
      onTap: () {
        type == UserGroupType.user
            ? Navigator.of(context).pushNamed(directoryRoute)
            : Navigator.of(context)
                .pushNamed(myGroupsRoute, arguments: dashboardRoute);
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusRounded8),
                topRight: Radius.circular(radiusRounded8),
                bottomRight: Radius.circular(radiusRounded8),
                bottomLeft: Radius.circular(radiusRounded8))),
        color: ColorsFM.green40,
        child: Padding(
          padding: const EdgeInsets.all(marginStandard),
          child: Container(
            constraints: const BoxConstraints(
                maxHeight: 150, maxWidth: 105, minWidth: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(type == UserGroupType.user
                    ? iconDialogUser
                    : iconDialogGroup),
                const SizedBox(
                  height: marginStandard,
                ),
                Text(
                  type == UserGroupType.user
                      ? Languages.of(context).scheduleAppointmentToUser
                      : Languages.of(context).scheduleAppointmentToGroup,
                  textAlign: TextAlign.center,
                  style: TypefaceStyles.poppinsRegular
                      .copyWith(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum UserGroupType { user, group }
