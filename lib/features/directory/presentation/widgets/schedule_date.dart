import 'package:app/util/assets_routes.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../bloc/directory/directory_bloc.dart';
import '../bloc/directory/directory_state.dart';

class ScheduleDate extends StatelessWidget {
  final Function() onTap;
  const ScheduleDate({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DirectoryBloc, DirectoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            height: 73,
            padding: EdgeInsets.zero,
            color: ColorsFM.green40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(iconSchedule),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallMargin),
                  child: Text(
                    Languages.of(context).schedule,
                    style: TypefaceStyles.poppinsSemiBold12NeutralDark
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
