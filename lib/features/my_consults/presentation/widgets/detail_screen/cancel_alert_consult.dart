import 'package:app/generated/l10n.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/modules.dart';
import '../../../../../navigation/routes_names.dart';
import '../../../../../util/enums.dart';
import '../../../../../util/widgets/spinner_loading.dart';
import '../../../domain/entities/consult.dart';
import '../../bloc/my_consult_detail_bloc.dart';
import '../../bloc/my_consult_detail_event.dart';
import '../../bloc/my_consult_detail_state.dart';

class AlertCancel extends StatelessWidget {
  final Consult consult;
  const AlertCancel({super.key, required this.consult});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MyConsultDetailBloc>()..add(AddConsult(consult)),
      child: const DetailAlertCancel(),
    );
  }
}

class DetailAlertCancel extends StatelessWidget {
  const DetailAlertCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultDetailBloc, MyConsultDetailState>(
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                16.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: mediumMargin, horizontal: mediumMargin),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.block_sharp,
                color: ColorsFM.errorColor,
                size: 48.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: smallMargin, bottom: mediumMargin),
                child: Text(
                  Languages.of(context).messageOfCancelConsult,
                  textAlign: TextAlign.center,
                  style: TypefaceStyles.poppinsRegularPrimary
                      .copyWith(color: ColorsFM.neutralDark),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              width: 1, color: ColorsFM.green40)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Languages.of(context).cancel,
                        style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                          color: ColorsFM.green40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: marginStandard,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {
                        context.read<MyConsultDetailBloc>()
                          ..add(const CancelOfConsult())
                          ..add(AddConsult(state.consult));
                      },
                      child: Text(
                        Languages.of(context).continueText,
                        style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
          Navigator.pop(context);
        }
        if (state.loading == LoadingState.close) {
          Navigator.pushNamedAndRemoveUntil(context, myConsultsRoute,
              (route) => route.settings.name == dashboardRoute);
        }
      },
    );
  }
}
