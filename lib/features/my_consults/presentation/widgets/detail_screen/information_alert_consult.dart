import 'package:app/features/my_consults/domain/entities/reason.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_bloc.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_state.dart';
import 'package:app/features/terms_conditions/presentation/view/terms_conditions_screen.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../util/colors_fm.dart';

class InformationAlertConsult extends StatelessWidget {
  final Reason reason;
  const InformationAlertConsult({Key? key, required this.reason})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultDetailBloc, MyConsultDetailState>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(marginStandard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              minLeadingWidth: 2,
              contentPadding: EdgeInsets.zero,
              title: Text(
                reason.title,
                style: TypefaceStyles.semiBoldMontserrat.copyWith(
                    color: reason.refund
                        ? ColorsFM.primary80
                        : ColorsFM.errorColor),
              ),
              leading: SvgPicture.asset(
                iconAlert,
                color: reason.refund ? ColorsFM.primary80 : ColorsFM.errorColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 41),
              child: Text(
                reason.description,
                style: TypefaceStyles.bodySmallMontserrat12,
              ),
            ),
            const SizedBox(
              height: smallMargin,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 41),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, termsConditionsRoote,
                        arguments: TCScreenArgs(
                            from: TCScreenFrom.dashboard,
                            acceptedTerms:
                                state.user?.termsConditions ?? true));
                  },
                  child: Text(
                    Languages.of(context).seeTermsAndConditions,
                    style: TypefaceStyles.bodySmallMontserrat12.copyWith(
                        color: reason.refund
                            ? ColorsFM.neutralDark
                            : ColorsFM.errorColor),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
