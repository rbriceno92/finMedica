import 'package:app/features/dashboard/presentation/widgets/sign_out_alert.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

import '../features/dashboard/presentation/widgets/list_tile_drawer.dart';

class DrawerSecondary extends StatelessWidget {
  const DrawerSecondary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      ),
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              contentPadding:
                  const EdgeInsets.only(left: 9, top: 0, bottom: 0, right: 0),
              style: ListTileStyle.drawer,
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back, color: ColorsFM.primary),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(Languages.of(context).configuration,
                  textAlign: TextAlign.start,
                  style: TypefaceStyles.poppinsSemiBold14Primary),
            ),
            IntrinsicWidth(
                child: Container(
              width: double.infinity,
              height: 3,
              color: ColorsFM.neutral95,
            )),
            const SizedBox(
              height: extraSmallMargin,
            ),
            ListTileDrawer(
              type: ListTileTypes.secondaryItems,
              text: Languages.of(context).changePassword,
              iconSvg: null,
              onClick: () {
                Navigator.pushNamed(context, changePasswordRoute);
              },
            ),
            ListTileDrawer(
              type: ListTileTypes.secondaryItems,
              text: Languages.of(context).notifications,
              iconSvg: null,
              onClick: () {
                Navigator.pushNamed(context, notificationsSettingsRoute);
              },
            ),
            ListTileDrawer(
              type: ListTileTypes.secondaryItems,
              text: Languages.of(context).privacy,
              iconSvg: null,
              onClick: () {
                Navigator.pushNamed(context, confidentialityScreen);
              },
            ),
            ListTileDrawer(
              type: ListTileTypes.secondaryItems,
              text: Languages.of(context).methodsToPay,
              iconSvg: null,
              onClick: () {
                Navigator.pushNamed(context, paymentRoute);
              },
            ),
            ListTileDrawer(
              type: ListTileTypes.secondaryItems,
              text: Languages.of(context).closeSesion,
              iconSvg: null,
              onClick: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(dashboardRoute));
                showDialog(
                  context: context,
                  builder: (context) => const SignOutAlert(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
