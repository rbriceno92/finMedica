import 'package:app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../navigation/routes_names.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import 'consult_item.dart';
import 'header_next_consult.dart';

//Widget who has the items of the content of the next two or one consult
class NextConsult extends StatelessWidget {
  const NextConsult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            const HeaderNextConsults(),
            const SizedBox(
              height: marginStandard,
            ),
            GestureDetector(
                onTap: () {
                  detailConsult(context, state.consult!.first);
                },
                child: ConsultItem(consult: state.consult!.first)),
            if ((state.consult?.length ?? 0) > 1)
              GestureDetector(
                  onTap: () {
                    detailConsult(context, state.consult![1]);
                  },
                  child: ConsultItem(consult: state.consult![1]))
            else
              Container()
          ],
        );
      },
    );
  }

  detailConsult(BuildContext context, consult) {
    Navigator.of(context).pushNamed(myConsultsDetailRoute, arguments: consult);
    context.read<DashboardBloc>().add(const SetRefresh(refresh: true));
  }
}
