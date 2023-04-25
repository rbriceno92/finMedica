import 'package:app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';

class NextConsultTitle extends StatelessWidget {
  const NextConsultTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconConsults),
        const SizedBox(
          width: smallMargin,
        ),
        Text(
          Languages.of(context).nextConsults,
          style: const TextStyle(
              color: ColorsFM.primary,
              fontWeight: FontWeight.w400,
              fontSize: 17),
        )
      ],
    );
  }
}
