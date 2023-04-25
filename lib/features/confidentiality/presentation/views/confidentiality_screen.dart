import 'package:app/generated/l10n.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/colors_fm.dart';
import '../bloc/confidentiality_bloc.dart';
import '../bloc/confidentiality_event.dart';
import '../bloc/confidentiality_state.dart';

class ConfidentialityScreen extends StatelessWidget {
  const ConfidentialityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context).configuration),
      ),
      backgroundColor: ColorsFM.primaryLight99,
      body: BlocProvider(
        create: (context) => getIt<ConfidentialityBloc>(),
        child: const Padding(
          padding: EdgeInsets.all(marginStandard),
          child: ContentConfidentialityScreen(),
        ),
      ),
    );
  }
}

class ContentConfidentialityScreen extends StatelessWidget {
  const ContentConfidentialityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfidentialityBloc, ConfidentialityState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Languages.of(context).confidentiality,
              style: TypefaceStyles.poppinsSemiBold22
                  .copyWith(color: ColorsFM.primary),
            ),
            const SizedBox(
              height: largeMargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Languages.of(context).allConsultsPrivate,
                  style: TypefaceStyles.semiBoldMontserrat,
                ),
                FlutterSwitch(
                  value: state.isPrivate,
                  height: 30,
                  width: 50,
                  activeColor: ColorsFM.green40,
                  inactiveColor: ColorsFM.green80,
                  switchBorder: Border.all(
                    color: ColorsFM.green40,
                    width: 2,
                  ),
                  activeToggleColor: ColorsFM.green80,
                  inactiveToggleColor: ColorsFM.green40,
                  toggleSize: 20,
                  padding: 2,
                  onToggle: (val) {
                    context
                        .read<ConfidentialityBloc>()
                        .add(ConfidentialityPrivate());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: smallMargin,
            ),
            Text(
              Languages.of(context).confidentialityDescription,
              style: TypefaceStyles.bodyMediumMontserrat,
            )
          ],
        );
      },
    );
  }
}
