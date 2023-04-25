import 'package:app/features/my_consults/presentation/bloc/my_consult_event.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/consult_type.dart';
import '../../../../../util/fonts_types.dart';
import '../../bloc/my_consult_bloc.dart';
import '../../bloc/my_consult_state.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultsBloc, MyConsultState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(
                left: marginStandard, right: marginStandard),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.chips.length,
                itemBuilder: (context, index) {
                  return ChipFM(position: index);
                }),
          ),
        );
      },
    );
  }
}

class ChipFM extends StatelessWidget {
  const ChipFM({Key? key, required this.position}) : super(key: key);
  final int position;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultsBloc, MyConsultState>(
      listenWhen: (state, newState) {
        return true;
      },
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: extraSmallMargin),
          child: FilterChip(
              label: Text(state.chips
                  .elementAt(position)
                  .consultType
                  .getTypeTitle(context)),
              disabledColor: ColorsFM.primaryLight80,
              labelStyle: TypefaceStyles.poppinsRegular.copyWith(
                  color: state.chips.elementAt(position).selected
                      ? Colors.white
                      : ColorsFM.primary60),
              selectedColor: ColorsFM.primary,
              selected: state.chips.elementAt(position).selected,
              backgroundColor: ColorsFM.primaryLight80,
              showCheckmark: false,
              onSelected: (bool value) {
                state.chips.elementAt(position).selected =
                    !state.chips.elementAt(position).selected;
                context.read<MyConsultsBloc>().add(
                    AddOrRemoveFilter(filter: state.chips.elementAt(position)));
              }),
        );
      },
    );
  }
}
