import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

class MyGroupsAlert extends StatelessWidget {
  final String? title;
  final bool? removeMember;
  final bool? inviteMember;
  final bool? memberLimit;
  const MyGroupsAlert(
      {super.key,
      this.title,
      this.removeMember,
      this.inviteMember,
      this.memberLimit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      contentPadding: EdgeInsets.only(
          top: memberLimit != null ? smallMargin : largeMargin,
          bottom: mediumMargin,
          left: mediumMargin,
          right: mediumMargin),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          memberLimit != null ? renderIconMemberLimit() : Container(),
          Padding(
            padding: const EdgeInsets.only(bottom: marginStandard),
            child: removeMember != null
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TypefaceStyles.poppinsSemiBold,
                        children: [
                          TextSpan(
                              style: TypefaceStyles.poppinsSemiBold,
                              text: Languages.of(context)
                                  .warningRemoveMemberGroup1),
                          TextSpan(
                              text: title,
                              style: TypefaceStyles.poppinsSemiBold
                                  .copyWith(color: ColorsFM.primary60)),
                          TextSpan(
                              style: TypefaceStyles.poppinsSemiBold,
                              text: Languages.of(context)
                                  .warningRemoveMemberGroup2),
                        ]),
                  )
                : Text(
                    title!,
                    style: memberLimit != null
                        ? TypefaceStyles.bodyMediumMontserrat
                        : TypefaceStyles.poppinsSemiBold,
                    textAlign: TextAlign.center,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inviteMember == null
                  ? Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                width: 1, color: ColorsFM.green40)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          Languages.of(context).cancel,
                          style:
                              TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                            color: ColorsFM.green40,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              inviteMember == null || memberLimit != null
                  ? const SizedBox(
                      width: extraSmallMargin,
                    )
                  : Container(),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    inviteMember == null || memberLimit != null
                        ? Languages.of(context).continueText
                        : Languages.of(context).accept,
                    style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  renderIconMemberLimit() {
    return Column(
      children: const [
        Icon(
          Icons.block_sharp,
          color: ColorsFM.errorColor,
          size: 48.0,
        ),
        SizedBox(
          height: extraSmallMargin,
        )
      ],
    );
  }
}
