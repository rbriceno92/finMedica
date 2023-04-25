import 'package:app/navigation/routes_names.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/colors_fm.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import 'next_consult_title.dart';

class HeaderNextConsults extends StatelessWidget {
  final bool emptyState;
  const HeaderNextConsults({Key? key, this.emptyState = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const NextConsultTitle(),
        if (!emptyState)
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, myConsultsRoute);
                context
                    .read<DashboardBloc>()
                    .add(const SetRefresh(refresh: true));
              },
              child: Text(
                Languages.of(context).seeAllConsults,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorsFM.neutralDark,
                    fontSize: 13),
              ))
        else
          Container(),
      ],
    );
  }
}
