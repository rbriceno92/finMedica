import 'package:app/core/di/modules.dart';
import 'package:app/navigation/drawer_secondary.dart';
import 'package:app/features/dashboard/presentation/widgets/list_tile_drawer.dart';
import 'package:app/features/terms_conditions/presentation/view/terms_conditions_screen.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../features/dashboard/presentation/bloc/dashboard_event.dart';
import '../util/assets_routes.dart';
import '../util/colors_fm.dart';

class DrawerMain extends StatelessWidget {
  final String name;
  const DrawerMain({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      ),
      child: Drawer(
        child: Scaffold(
          endDrawerEnableOpenDragGesture: false,
          endDrawer: const DrawerSecondary(),
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            child: ListView(
              children: [
                ListTileDrawer(
                    type: ListTileTypes.mainTitleUser,
                    text: Languages.of(context).helloUser(name),
                    iconSvg: null),
                IntrinsicWidth(
                    child: Container(
                  width: double.infinity,
                  height: 3,
                  color: ColorsFM.neutral95,
                )),
                ListTileDrawer(
                    type: ListTileTypes.itemsMain,
                    text: Languages.of(context).startText,
                    iconSvg: iconHome),
                ListTileDrawer(
                    type: ListTileTypes.itemsMain,
                    text: Languages.of(context).myProfile,
                    onClick: () {
                      Navigator.of(context).pushNamed(profileRoute);
                    },
                    iconSvg: iconUser2),
                ListTileDrawer(
                    type: ListTileTypes.itemsMain,
                    text: Languages.of(context).myGroup,
                    iconSvg: iconGroup,
                    onClick: () {
                      Navigator.pushNamed(context, myGroupsRoute);
                    }),
                ListTileDrawer(
                    type: ListTileTypes.itemsMain,
                    text: Languages.of(context).consults,
                    onClick: () {
                      Navigator.of(context).pushNamed(myConsultsRoute);
                      context
                          .read<DashboardBloc>()
                          .add(const SetRefresh(refresh: true));
                    },
                    iconSvg: iconConsults2),
                ListTileDrawer(
                  type: ListTileTypes.itemsMain,
                  text: Languages.of(context).myCoupons,
                  iconSvg: iconStore2,
                  onClick: () {
                    Navigator.pushNamed(context, myCouponsRoute);
                  },
                ),
                ListTileDrawer(
                    type: ListTileTypes.itemsMain,
                    text: Languages.of(context).myBuysHistorial,
                    iconSvg: iconCreditAll,
                    onClick: () {
                      Navigator.pushNamed(context, paymentsHistoryRoute);
                    }),
                ListTileDrawer(
                    type: ListTileTypes.itemsMain,
                    text: Languages.of(context).directory,
                    onClick: () {
                      Navigator.pushNamed(context, directoryRoute);
                      context
                          .read<DashboardBloc>()
                          .add(const SetRefresh(refresh: true));
                    },
                    iconSvg: iconDirectory),
                ListTileDrawer(
                  type: ListTileTypes.itemsMain,
                  text: Languages.of(context).services,
                  color: ColorsFM.neutralColor,
                  iconSvg: iconStore,
                  onClick: () {
                    Navigator.pushNamed(context, storeRoute);
                  },
                ),
                IntrinsicWidth(
                    child: Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorsFM.neutral95,
                )),
                const SizedBox(
                  height: smallMargin,
                ),
                ListTileDrawer(
                  type: ListTileTypes.secondaryItems,
                  text: Languages.of(context).notifications,
                  iconSvg: null,
                  onClick: () {
                    Navigator.pushNamed(context, notificationsScreenRoute);
                  },
                ),
                Builder(builder: (context) {
                  return ListTileDrawer(
                      type: ListTileTypes.secondaryItems,
                      text: Languages.of(context).configurations,
                      onClick: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      iconSvg: null);
                }),
                ListTileDrawer(
                    onClick: () {
                      var userPreference = getIt<UserPreferenceDao>();
                      userPreference.getUser().then((eitherUser) {
                        var acceptedTerms = eitherUser.fold(
                            (l) => true, (r) => r.termsConditions);
                        Navigator.pushNamed(context, termsConditionsRoote,
                            arguments: TCScreenArgs(
                                from: TCScreenFrom.dashboard,
                                acceptedTerms: acceptedTerms));
                      });
                    },
                    type: ListTileTypes.secondaryItems,
                    text: Languages.of(context).termConditions,
                    iconSvg: null),
                ListTileDrawer(
                  type: ListTileTypes.secondaryItems,
                  text: Languages.of(context).frecuentQuestions,
                  iconSvg: null,
                  onClick: () {
                    Navigator.pushNamed(context, frequentQuestionsRoute);
                  },
                ),
                ListTileDrawer(
                  type: ListTileTypes.secondaryItems,
                  text: Languages.of(context).contact,
                  iconSvg: null,
                  onClick: () {
                    var userPreference = getIt<UserPreferenceDao>();
                    userPreference.getUser().then((eitherUser) {
                      Navigator.pushNamed(context, contactUsRoute);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
