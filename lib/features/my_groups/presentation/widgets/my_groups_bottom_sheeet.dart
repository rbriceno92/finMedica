import 'package:app/features/my_groups/presentation/views/my_group_member_screen.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/my_groups_info.dart';
import '../bloc/my_groups_events.dart';

class MyGroupsBottomSheet extends StatelessWidget {
  final MyGroupsInfo info;
  const MyGroupsBottomSheet({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
      Container(
        margin: const EdgeInsets.only(
          top: smallMargin,
        ),
        height: 24,
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          height: 2,
          width: 65,
          decoration: const BoxDecoration(
              color: Color(0xff1c1b1f),
              borderRadius: BorderRadius.all(Radius.circular(1))),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: marginStandard,
            left: marginStandard,
            right: marginStandard,
            bottom: MediaQuery.of(context).padding.bottom + largeMargin),
        child: Column(children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1, color: ColorsFM.green40)),
            onPressed: () async {
              Navigator.pushNamed(context, myGroupsExistingUserRoute,
                      arguments: ScreenArguments(info, null))
                  .then((member) {
                Navigator.pop(context, member);
              });
            },
            child: Text(
              Languages.of(context).addExisting,
              style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                color: ColorsFM.green40,
              ),
            ),
          ),
          const SizedBox(
            height: extraSmallMargin,
            width: extraSmallMargin,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, myGroupsMemberRoute,
                        arguments: MyGroupsMemberScreenArgs(info, null))
                    .then((member) {
                  Navigator.pop(context, member);
                });
              },
              child: Text(Languages.of(context).addNew,
                  style: TypefaceStyles.buttonPoppinsSemiBold14)),
        ]),
      )
    ]);
  }
}
