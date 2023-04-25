import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_bloc.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_state.dart';
import 'package:app/features/terms_conditions/presentation/view/terms_conditions_screen.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../util/colors_fm.dart';
import '../../../../../util/dimens.dart';
import '../../../../../util/fonts_types.dart';
import '../../../domain/entities/reason.dart';

class InformationAlertExpired extends StatelessWidget {
  final Reason reason;
  const InformationAlertExpired({Key? key, required this.reason})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultDetailBloc, MyConsultDetailState>(
      listener: (context, state) {},
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reason.title.isEmpty
                ? Languages.of(context).defaulExpiredtReasonTitle
                : reason.title,
            style: TypefaceStyles.semiBoldMontserrat.copyWith(
                color:
                    reason.refund ? ColorsFM.primary80 : ColorsFM.errorColor),
          ),
          const SizedBox(
            height: minMargin,
          ),
          Text(
            reason.description.isEmpty
                ? Languages.of(context).defaulExpiredDReasonDesc
                : reason.description,
            style: TypefaceStyles.bodySmallMontserrat12,
          ),
          const SizedBox(
            height: smallMargin,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, termsConditionsRoote,
                  arguments: TCScreenArgs(
                      from: TCScreenFrom.dashboard,
                      acceptedTerms: state.user?.termsConditions ?? true));
            },
            child: Text(
              Languages.of(context).seeTermsAndConditions,
              style: TypefaceStyles.bodySmallMontserrat12.copyWith(
                  color: reason.refund
                      ? ColorsFM.neutralDark
                      : ColorsFM.errorColor),
            ),
          )
        ],
      ),
    );
  }
}
