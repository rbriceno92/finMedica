import 'package:app/generated/l10n.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/fonts_types.dart';

class PatientInfo extends StatelessWidget {
  final String name;

  const PatientInfo({Key? key, required this.name}) : super(key: key);
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
          SvgPicture.asset(
            iconUsers,
            width: 24,
            height: 24,
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Languages.of(context).patient,
                  style: TypefaceStyles.poppinsSemiBold12NeutralDark,
                ),
                Text(
                  name,
                  style: TypefaceStyles.poppinsRegular,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
