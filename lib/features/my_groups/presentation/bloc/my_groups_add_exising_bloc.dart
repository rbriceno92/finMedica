import 'dart:async';

import 'package:app/features/my_groups/domain/use_case/my_groups_add_member.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_fetch_data_filter.dart';
import 'package:app/util/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/constants/constants.dart';
import '../../../../util/failure.dart';
import '../../data/models/add_member_existent_request.dart';
import './my_groups_events.dart';
import './my_groups_add_existing_state.dart';

class MyGroupsAddExistingBloc
    extends Bloc<MyGroupsEvent, MyGroupsAddExistingState> {
  MyGroupsFetchDataFilteredUseCase myGroupsFetchDataFilteredUseCase;
  MyGroupsAddMemberUseCase myGroupsAddMemberUseCase;

  MyGroupsAddExistingBloc(
      {required this.myGroupsFetchDataFilteredUseCase,
      required this.myGroupsAddMemberUseCase})
      : super(const MyGroupsAddExistingState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<AddMember>(_onAddMember);
    on<ChangeFilter>(_onChangeFilter);
    on<SetAdminData>(_onSetAdminData);
    on<ClearMesssage>(_onClearMesssage);
  }

  FutureOr<void> _onClearMesssage(
      ClearMesssage event, Emitter<MyGroupsAddExistingState> emit) async {
    emit(state.copyWith(errorMessage: ''));
  }

  void _onSetAdminData(
      SetAdminData event, Emitter<MyGroupsAddExistingState> emit) {
    emit(state.copyWith(admin: event.admin));
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<MyGroupsAddExistingState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onChangeFilter(
      ChangeFilter event, Emitter<MyGroupsAddExistingState> emit) async {
    emit(state.copyWith(filter: event.filter.toString().toLowerCase()));
    if (event.filter.isEmpty) {
      emit(state.copyWith(members: [], addSuccess: false));
    } else {
      await _onFetchData(emit);
    }
  }

  Future<void> _onFetchData(Emitter<MyGroupsAddExistingState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));
    var result = await myGroupsFetchDataFilteredUseCase.call(state.filter);
    result.fold((l) {
      var message = getMessage(l);
      emit(state.copyWith(
          members: [],
          loading: LoadingState.close,
          errorMessage: USER_NOT_FOUND != message ? message : ''));
    }, (r) {
      emit(state.copyWith(
          members: r.user.map((e) => e.toEntity()).toList(),
          loading: LoadingState.close));
    });
  }

  void _onAddMember(
      AddMember event, Emitter<MyGroupsAddExistingState> emit) async {
    var result = await myGroupsAddMemberUseCase.call(AddMemberExistentRequest(
        groupId: state.admin!.groupId,
        idAdmin: state.admin!.idAdmin,
        userId: event.member.userId.toString()));
    emit(state.copyWith(loading: LoadingState.show, addSuccess: false));
    result.fold((l) {
      var message = getMessage(l);
      emit(state.copyWith(
          loading: LoadingState.close,
          errorMessage: message,
          addSuccess: false,
          member: null));
    }, (r) {
      emit(state.copyWith(
          loading: LoadingState.close, errorMessage: '', addSuccess: true));
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
