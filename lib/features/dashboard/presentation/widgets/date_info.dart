import 'package:app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/util/format_date.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../navigation/routes_names.dart';
import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';
import '../bloc/dashboard_event.dart';

class DateInfo extends StatelessWidget {
  final String date;
  final String time;
  final Consult consult;
  const DateInfo(
      {Key? key, required this.date, required this.time, required this.consult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateObject = date.dateFormat().replaceAll('.', '');
    var amOrPm = time.split(':');
    var dateStrings = dateObject.split(' ');
    return Container(
      height: 115,
      width: 95,
      padding: EdgeInsets.zero,
      color: ColorsFM.blueDark90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 70,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: minMargin,
                  right: marginStandard,
                  left: marginStandard,
                  bottom: minMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateStrings[0],
                    style: TypefaceStyles.poppinsSemiBold24Primary,
                  ),
                  Text(
                    dateStrings[1].capitalizeOnlyFirstWord(),
                    style: TypefaceStyles.poppinsSemiBold14Primary,
                  ),
                  Text(
                    time,
                    style: TypefaceStyles.poppinsRegularPrimary,
                  ),
                  Text(
                    getAmOrPm(int.parse(amOrPm[0])),
                    style: TypefaceStyles.poppinsRegularPrimary,
                  )
                ],
              ),
            ),
          ),
          Container(
              width: 25,
              color: ColorsFM.primary80,
              child: SvgPicture.asset(arrowRight)),
        ],
      ),
    );
  }

  String getAmOrPm(int time) {
    if (time > 11) {
      return 'pm';
    } else {
      return 'am';
    }
  }
}
