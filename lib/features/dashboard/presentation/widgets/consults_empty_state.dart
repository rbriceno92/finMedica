import 'package:app/generated/l10n.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../util/dimens.dart';
import 'header_next_consult.dart';

class ConsultEmptyState extends StatelessWidget {
  const ConsultEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderNextConsults(
          emptyState: true,
        ),
        Expanded(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Languages.of(context).notConsultsYet,
                style: TypefaceStyles.poppinsMedium14,
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                width: marginStandard,
              ),
              SvgPicture.asset(calendarDashboards)
            ],
          ),
        )),
        Text(
          Languages.of(context).scheduleConsultNow,
          style: TypefaceStyles.bodyMediumMontserratGreen,
        )
      ],
    );
  }
}
