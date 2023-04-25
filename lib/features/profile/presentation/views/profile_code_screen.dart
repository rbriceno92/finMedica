import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';
import '../../../../util/models/model_user.dart';

class ProfileCodeScreen extends StatelessWidget {
  final ModelUser? user;
  const ProfileCodeScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    var codeUser = user!.customId!.toUpperCase();
    return Scaffold(
      backgroundColor: ColorsFM.primaryLight99,
      appBar: AppBar(
        title: Text(Languages.of(context).memberProfile),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: marginStandard,
          right: marginStandard,
          top: mediumMargin,
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(Languages.of(context).codeMember,
                style: TypefaceStyles.poppinsSemiBold22
                    .copyWith(color: ColorsFM.primary)),
          ),
          const SizedBox(height: 120.00),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconCodeBarGroup,
                  color: ColorsFM.green40,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: marginStandard),
                Text('${user?.fullName()}',
                    textAlign: TextAlign.center,
                    style: TypefaceStyles.poppinsSemiBold22.copyWith(
                      color: ColorsFM.primary,
                    )),
                const SizedBox(height: smallMargin),
                Text(codeUser,
                    style: TypefaceStyles.bodyMediumMontserrat
                        .copyWith(fontSize: 22.00)),
                const SizedBox(height: smallMargin),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await Share.share(codeUser,
                            subject: 'Código de Usuario');
                      },
                      child: const Icon(
                        Icons.share,
                        color: ColorsFM.neutralColor,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(width: smallMargin),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: codeUser));
                      },
                      child: const Icon(
                        Icons.copy,
                        color: ColorsFM.neutralColor,
                        size: 24.0,
                      ),
                    ),
                  ],
                )
              ]),
        ]),
      ),
    );
  }
}
