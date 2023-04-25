import 'dart:async';

import 'package:app/features/my_consults/data/models/consult_private_params.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_event.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/constants/constants.dart';
import '../../../../util/failure.dart';
import '../../domain/entities/consult.dart';
import '../../domain/entities/chips.dart';
import '../../domain/use_cases/make_consult_private_use_case.dart';
import '../../domain/use_cases/get_consults.dart';

class MyConsultsBloc extends Bloc<MyConsultEvent, MyConsultState> {
  GetConsults getConsults;
  MakeConsultPrivateUseCase makeConsultPrivateUseCase;

  MyConsultsBloc(
      {required this.getConsults, required this.makeConsultPrivateUseCase})
      : super(const MyConsultState()) {
    on<LoadMyConsults>(_onLoadMyConsults);
    on<AddOrRemoveFilter>(_onAddOrRemoveFilter);
    on<SetPrivacyState>(_onSetPrivacyState);
  }

  FutureOr<void> _onLoadMyConsults(
      LoadMyConsults event, Emitter<MyConsultState> emit) async {
    emit(state.copyWith(isLoading: true));
    var consults = await getConsults.call(event.states);
    List<ChipFilter> chips;
    consults.fold(
        (l) => {
              emit(state.copyWith(
                  isLoading: false, message: getMessage(l), consults: null))
            }, (response) {
      chips = [
        ChipFilter(name: 'Todas', selected: true, consultType: ConsultType.ALL)
      ];

      var listString = response.map((element) => element.type).toList();
      var element = listString.toSet().toList();
      for (var consultType in element) {
        chips.add(ChipFilter(
            name: consultType.toString(),
            selected: false,
            consultType: consultType));
      }

      emit(state.copyWith(
          consults: response.map((e) => e.toEntity()).toList(),
          consultsFiltered: response.map((e) => e.toEntity()).toList(),
          isLoading: false,
          chips: chips));
    });
  }

  FutureOr<void> _onAddOrRemoveFilter(
      AddOrRemoveFilter event, Emitter<MyConsultState> emit) {
    emit(state.copyWith(isLoading: true));
    var filterSelected = state.chips.where((element) => element.selected);
    if (filterSelected.isNotEmpty) {
      if (event.filter.name == 'Todas' && event.filter.selected) {
        for (var element in state.chips) {
          element.selected = false;
        }
        state.chips.first.selected = true;
        emit(
            state.copyWith(consultsFiltered: state.consults, isLoading: false));
      } else {
        state.chips.first.selected = false;

        var consultFiltered = <Consult>[];

        state.consults?.forEach((consult) {
          for (var chip in filterSelected) {
            if (consult.type.toString().contains(chip.name)) {
              consultFiltered.add(consult);
            }
          }
        });

        emit(state.copyWith(
            consultsFiltered: consultFiltered, isLoading: false));
      }
    } else {
      state.chips.first.selected = true;
      emit(state.copyWith(consultsFiltered: state.consults, isLoading: false));
    }
  }

  FutureOr<void> _onSetPrivacyState(
      SetPrivacyState event, Emitter<MyConsultState> emit) async {
    emit(state.copyWith(isLoading: true));
    final param = ConsultPrivateParams(
        consultId: state.consults![event.position].consultId.toString(),
        flag: event.privacy);
    final response = await makeConsultPrivateUseCase.call(param);

    response.fold((l) => emit(state.copyWith(message: getMessage(l))), (r) {
      state.consults![event.position] = state.consults!
          .elementAt(event.position)
          .copyWith(private: event.privacy);

      state.consultsFiltered![event.position] = state.consultsFiltered!
          .elementAt(event.position)
          .copyWith(private: event.privacy);

      emit(state.copyWith(
          consults: state.consults,
          consultsFiltered: state.consultsFiltered,
          isLoading: false));
    });
  }

  String getMessage(ErrorGeneral l) {
    if (l is ServerFailure) {
      if (l.modelServer.isSimple()) {
        return l.modelServer.message ?? '';
      } else {
        return l.modelServer.message?.first.message ?? '';
      }
    }
    if (l is ErrorMessage) {
      return l.message;
    }
    return ERROR_MESSAGE;
  }
}
