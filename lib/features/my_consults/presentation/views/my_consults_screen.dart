import 'package:app/features/my_consults/presentation/bloc/my_consult_event.dart';
import 'package:app/features/my_consults/presentation/widgets/main_screen/consult_item.dart';
import 'package:app/features/my_consults/presentation/widgets/main_screen/header_screen.dart';
import 'package:app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/widgets/alert_notification.dart';
import '../../../../util/widgets/spinner_loading.dart';
import '../bloc/my_consult_bloc.dart';
import '../bloc/my_consult_state.dart';
import '../widgets/main_screen/filter_chips.dart';

final List statesList = ['ALL'];

class MyConsultsScreen extends StatelessWidget {
  const MyConsultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyConsultsBloc>()
        ..add(LoadMyConsults(states: {'statesRequired': statesList})),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).myConsults),
        ),
        body: const ContentConsultsScreen(),
      ),
    );
  }
}

class ContentConsultsScreen extends StatelessWidget {
  const ContentConsultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultsBloc, MyConsultState>(
      listener: (context, state) {
        if (state.isLoading) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (!state.isLoading) {
          Navigator.pop(context);
        }
        if (state.message.isNotEmpty) {
          AlertNotification.error(context, state.message);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              HeaderScreen(numConsults: state.consults?.length ?? 0),
              const FilterChips(),
              Expanded(
                child: ListView.builder(
                    itemCount: state.consultsFiltered?.length ?? 0,
                    itemBuilder: (context, position) {
                      return ConsultItem(
                          consult: state.consultsFiltered?.elementAt(position),
                          position: position);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
