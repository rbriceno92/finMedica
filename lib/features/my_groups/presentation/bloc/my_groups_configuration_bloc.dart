import 'package:app/features/my_groups/data/models/edit_admin_request.dart';
import 'package:app/features/my_groups/domain/use_case/my_groups_transfer_management.dart';
import 'package:app/util/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './my_groups_configuration_events.dart';
import './my_groups_configuration_state.dart';

class MyGroupsConfigurationBloc
    extends Bloc<MyGroupsConfigurationEvent, MyGroupsConfigurationState> {
  MyGroupsTransferManagementUseCase myGroupsTransferManagementUseCase;

  MyGroupsConfigurationBloc({
    required this.myGroupsTransferManagementUseCase,
  }) : super(const MyGroupsConfigurationState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<SelectMember>(_onSelectMember);
    on<SendData>(_onSendData);
    on<ChangeFilter>(_onChangeFilter);
    on<FetchData>(_onFetchData);
  }

  void _onDisposeLoading(DisposeLoading event,
          Emitter<MyGroupsConfigurationState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onSendData(
      SendData event, Emitter<MyGroupsConfigurationState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var result = await myGroupsTransferManagementUseCase
        .call(EditAdminRequest(adminId: state.selectMember?.userId));

    bool success = result.fold(
      (l) {
        return false;
      },
      (r) {
        return true;
      },
    );
    emit(state.copyWith(loading: LoadingState.close));
    if (success) {
      event.onSuccess();
    } else {
      event.onError();
    }
  }

  void _onChangeFilter(
          ChangeFilter event, Emitter<MyGroupsConfigurationState> emit) async =>
      emit(state.copyWith(filter: event.filter));

  void _onFetchData(
          FetchData event, Emitter<MyGroupsConfigurationState> emit) =>
      emit(state.copyWith(members: event.members));

  void _onSelectMember(
          SelectMember event, Emitter<MyGroupsConfigurationState> emit) =>
      emit(state.copyWith(selectMember: event.member));
}
