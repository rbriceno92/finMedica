import 'package:app/util/colors_fm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';

class ConsultoryInfo extends StatelessWidget {
  final String? consultory;
  final String? phone;

  const ConsultoryInfo({Key? key, this.consultory, this.phone})
      : super(key: key);
  final double heightPatient = 44;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightPatient,
      margin: const EdgeInsets.symmetric(vertical: minMargin, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(iconHospital2),
              if (phone != null)
                SvgPicture.asset(iconPhone, color: ColorsFM.neutralDark),
            ],
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                consultory ?? '',
                style: TypefaceStyles.poppinsSemiBold12NeutralDark,
              ),
              if (phone != null)
                Text(
                  phone ?? '',
                  style: TypefaceStyles.poppinsRegular,
                )
            ],
          )
        ],
      ),
    );
  }
}
